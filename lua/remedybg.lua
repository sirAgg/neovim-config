print'hello remedy'
local M = {}

local function is_remedy_running()
    local output = vim.fn.system('tasklist', '')

    if output:find('remedybg.exe', 1, true) then
	return true
    end

    return false
end

local function find_remedy_project_file()
    local handle = io.popen('dir /b', 'r')

    if handle then
	local res = '\n' .. handle:read('*a')
	local s, e = string.find(res, '\n.+%.rdbg')
	if s and e then return string.sub(res, s, e) end
    end
end


local function start_remedy()
    local remedy_proj = find_remedy_project_file()
    if remedy_proj then
	vim.system({'remedybg.exe', remedy_proj}, {text = true})
    end
end

local function start_debugging()
    if is_remedy_running() then
    	vim.fn.system('remedybg.exe start-debugging')
	return
    end

    local remedy_proj = find_remedy_project_file()
    if remedy_proj then
	vim.system({'remedybg.exe', '-g', remedy_proj}, {text = true})
    end
end

local function stop_debugging()
    if is_remedy_running() then
    	vim.fn.system('remedybg.exe stop-debugging')
    end
end

function M.set_breakpoint_at_cursor()
	if not is_remedy_running() then
		start_remedy()
	end
	local file = vim.api.nvim_buf_get_name(0)
	local line = tostring(vim.api.nvim_win_get_cursor(0)[1])

	vim.system({'remedybg.exe', 'open-file', file, line}, {text = true})
	vim.system({'remedybg.exe', 'add-breakpoint-at-file', file, line}, {text = true})
end

M.setup = function (_)
    vim.api.nvim_create_user_command('RemedyStartDebugging', function(_) start_debugging() end, {} )
    vim.api.nvim_create_user_command('RemedyStopDebugging', function(_) stop_debugging() end, {} )
end
vim.api.nvim_create_user_command('RemedySetBreakpointAtCursor', function(_) M.set_breakpoint_at_cursor() end, {} )

M.start_debugging = start_debugging
M.stop_debugging = stop_debugging

return M
