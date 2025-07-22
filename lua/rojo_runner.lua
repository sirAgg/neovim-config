local M = {}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local rojo_serve_process = nil
local rojo_sourcemap_process = nil
local rojo_log_buffer = nil

local function rojo_log_write(msg)

    if rojo_log_buffer == nil then
        rojo_log_buffer = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_buf_set_name(rojo_log_buffer, "rojo_log");
    end

    vim.api.nvim_buf_set_lines(rojo_log_buffer, -1, -1, false, {msg})
end

local function parse_rojo_error(msg)
    local file_start, file_end = string.find(msg, 'c:\\[^\n]+')
    local file = string.sub(msg, file_start, file_end)

    local line, col = string.match(msg, 'line (%d*) column (%d*)')

    local _, text_end = string.find(msg, '%]')
    local text = string.sub(msg, text_end+1, file_start-1)

    local _, text2_start = string.find(msg, 'Caused by:')
    local text2_end, _ = string.find(msg, 'at line')
    local text2 = ""
    if text2_start ~= nil and text2_end ~= nil then
        text2 = string.sub(msg, text2_start+1, text2_end-1)
    end

    if string.sub(file, #file, #file) == '.' then
        file = string.sub(file, 1, #file-1)
    end

    local type = 'E'
    if string.find(msg, '%[WARN') then
        type = 'W'
    end

    return {filename = file, lnum = line, col = col, type = type, text = text .. " " .. text2}
end

local function rojo_serve(project_file)

    rojo_log_write("[Staring rojo serve " .. project_file .. "]");

    local on_output = vim.schedule_wrap(function(_, data)
        if not data then return end

        local success, msg = pcall(parse_rojo_error, data)

        if success then
            vim.fn.setqflist({msg}, 'a')
            vim.cmd("copen")
        end

        local lines = {}
        for line in string.gmatch(data, '([^\n\r]*)') do
            if #line > 0 then
                table.insert(lines, line)
            end
        end
        vim.api.nvim_buf_set_lines(rojo_log_buffer, -1, -1, false, lines)

    end)

    rojo_serve_process = vim.system({"rojo", "serve", "--color", "never", project_file}, {stdout = on_output, text = true, stderr = on_output}, vim.schedule_wrap(function(_)
        rojo_serve_process = nil
        rojo_log_write("[Rojo serve stopped]");
    end))

end

local function rojo_sourcemap(project_file)
    rojo_log_write("[Staring rojo sourcemap " .. project_file .. "]");

    if not vim.fn.filereadable(project_file) then
        return
    end

    local command = {"rojo", "sourcemap", "--watch", project_file, "--output", "sourcemap.json", "--include-non-scripts"}
    rojo_sourcemap_process = vim.system(command, {text = true}, function(_)
        rojo_sourcemap_process = nil
        vim.schedule(function() rojo_log_write("[Rojo sourcemap stopped]") end);
    end)
end

local function rojo_stop()
    if rojo_serve_process then
        rojo_log_write("[Killing rojo serve]");
        rojo_serve_process:kill()
    end

    if rojo_sourcemap_process then
        rojo_log_write("[Killing rojo sourcemap]");
        rojo_sourcemap_process:kill()
    end
end

local function start_rojo(project_file)
    vim.api.nvim_create_user_command('RojoServe', function(_) rojo_serve(project_file) end, {} )
    vim.api.nvim_create_user_command('RojoStop', function(_) rojo_stop() end, {} )
    vim.api.nvim_create_autocmd({"BufWritePre"}, {
        pattern = {"*.luau", "*.json"},
        desc = "Clears qf on write so Rojo can write new stuff",
        group = vim.api.nvim_create_augroup('rojo-autocommands', {clear = true}),
        callback = vim.schedule_wrap(function (_)
            vim.fn.setqflist({}, 'r')
            vim.cmd("cclose")
        end)
    })

    rojo_serve(project_file)
    rojo_sourcemap(project_file)

end

local function stop_and_cleanup_rojo()
    rojo_stop()

    vim.api.nvim_create_augroup('rojo-autocommands', {clear = false})
    vim.api.nvim_del_augroup_by_name('rojo-autocommands')
end

local function find_all_project_files_in_dir(project_files, dir, recursion)
    if recursion > 3 then return end

    local file_ext = ".project.json"
    local dir_content = vim.split(vim.fn.glob(dir .. "/*"), '\n', {trimempty=true})
    for _,v in pairs(dir_content) do
        if v:sub(-#file_ext) == file_ext then
             table.insert(project_files, v)
        elseif vim.fn.isdirectory(tostring(v)) > 0 then
            if v ~= '.' and v ~= '..' then
                find_all_project_files_in_dir(project_files, v, recursion+1)
            end
        end
    end
end

local function find_all_project_files()
    local cwd = vim.fn.getcwd()

    local project_files = {}

    find_all_project_files_in_dir(project_files, cwd, 0)

    for _, p in ipairs(project_files) do
        rojo_log_write(p)
    end

    return project_files
end

M.setup = function (_)
    vim.api.nvim_create_autocmd({'VimEnter', 'DirChanged'}, {
        desc = 'Starts rojo serve and rojo sourcemap',
        group = vim.api.nvim_create_augroup('rojo-checker', {clear = true}),
        callback = vim.schedule_wrap(function()
            stop_and_cleanup_rojo()
            local project_files = find_all_project_files()
            if #project_files == 0 then return end

            if #project_files == 1 then 
                start_rojo(project_files[1])
            else
                -- open telescope picker
                local select_projects = function(opts)
                  opts = opts or {}
                  pickers.new(opts, {
                    prompt_title = "rojo project file",
                    finder = finders.new_table {
                      results = project_files
                    },
                    sorter = conf.generic_sorter(opts),
                    attach_mappings = function(prompt_bufnr, map)
                      actions.select_default:replace(function()
                        actions.close(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        start_rojo(selection[1])
                        vim.schedule(function()
                            vim.cmd("e " .. selection[1])
                        end)
                      end)
                      return true
                    end,
                  }):find()
                end

                select_projects()
            end
        end)
    })
end

return M
