local function color_to_hexstring(r,g,b)
    return string.format("%02x%02x%02x", r,g,b)
end

return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        filetypes = { "*" }, -- Filetype options.  Accepts table like `user_default_options`
        buftypes = {}, -- Buftype options.  Accepts table like `user_default_options`
        -- Boolean | List of usercommands to enable.  See User commands section.
        user_commands = true, -- Enable all or some usercommands
        lazy_load = false, -- Lazily schedule buffer highlighting setup function
        user_default_options = {
          names = true, -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
          names_opts = { -- options for mutating/filtering names.
            lowercase = false, -- name:lower(), highlight `blue` and `red`
            camelcase = true, -- name, highlight `Blue` and `Red`
            uppercase = false, -- name:upper(), highlight `BLUE` and `RED`
            strip_digits = false, -- ignore names with digits,
            -- highlight `blue` and `red`, but not `blue3` and `red4`
          },
          -- Expects a table of color name to #RRGGBB value pairs.  # is optional
          -- Example: { cool = "#107dac", ["notcool"] = "ee9240" }
          -- Set to false to disable, for example when setting filetype options
          names_custom = {nocheckin = 'ff0000', -- Custom names to be highlighted: table|function|false
            ["White"] = color_to_hexstring(242, 243, 243),
            ["Grey"] = color_to_hexstring(161, 165, 162),
            ["Light yellow"] = color_to_hexstring(249, 233, 153),
            ["Brick yellow"] = color_to_hexstring(215, 197, 154),
            ["Light green (Mint)"]= color_to_hexstring(194, 218, 184),
            ["Light reddish violet"] = color_to_hexstring(232, 186, 200),
            ["Pastel Blue"] = color_to_hexstring(128, 187, 219),
            ["Light orange brown"] = color_to_hexstring(203, 132, 66),
            ["Nougat"] = color_to_hexstring(204, 142, 105),
            ["Bright red"] = color_to_hexstring(196, 40, 28),
            ["Med. reddish violet"] = color_to_hexstring(196, 112, 160),
            ["Bright blue"] = color_to_hexstring(13, 105, 172),
            ["Bright yellow"] = color_to_hexstring(245, 205, 48),
            ["Earth orange"] = color_to_hexstring(98, 71, 50),
            ["Black"] = color_to_hexstring(27, 42, 53),
            ["Dark grey"] = color_to_hexstring(109, 110, 108),
            ["Dark green"] = color_to_hexstring(40, 127, 71),
            ["Medium green"] = color_to_hexstring(161, 196, 140),
            ["Lig. Yellowich orange"] = color_to_hexstring(243, 207, 155),
            ["Bright green"] = color_to_hexstring(75, 151, 75),
            ["Dark orange"] = color_to_hexstring(160, 95, 53),
            ["Light bluish violet"] = color_to_hexstring(193, 202, 222),
            ["Transparent"] = color_to_hexstring(236, 236, 236),
            ["Tr. Red"] = color_to_hexstring(205, 84, 75),
            ["Tr. Lg blue"] = color_to_hexstring(193, 223, 240),
            ["Tr. Blue"] = color_to_hexstring(123, 182, 232),
            ["Tr. Yellow"] = color_to_hexstring(247, 241, 141),
            ["Light blue"] = color_to_hexstring(180, 210, 228),
            ["Tr. Flu. Reddish orange"] = color_to_hexstring(217, 133, 108),
            ["Tr. Green"] = color_to_hexstring(132, 182, 141),
            ["Tr. Flu. Green"] = color_to_hexstring(248, 241, 132),
            ["Phosph. White"] = color_to_hexstring(236, 232, 222),
            ["Light red"] = color_to_hexstring(238, 196, 182),
            ["Medium red"] = color_to_hexstring(218, 134, 122),
            ["Medium blue"] = color_to_hexstring(110, 153, 202),
            ["Light grey"] = color_to_hexstring(199, 193, 183),
            ["Bright violet"] = color_to_hexstring(107, 50, 124),
            ["Br. yellowish orange"] = color_to_hexstring(226, 155, 64),
            ["Bright orange"] = color_to_hexstring(218, 133, 65),
            ["Bright bluish green"] = color_to_hexstring(0, 143, 156),
            ["Earth yellow"] = color_to_hexstring(104, 92, 67),
            ["Bright bluish violet"] = color_to_hexstring(67, 84, 147),
            ["Tr. Brown"] = color_to_hexstring(191, 183, 177),
            ["Medium bluish violet"] = color_to_hexstring(104, 116, 172),
            ["Tr. Medi. reddish violet"] = color_to_hexstring(229, 173, 200),
            ["Med. yellowish green"] = color_to_hexstring(199, 210, 60),
            ["Med. bluish green"] = color_to_hexstring(85, 165, 175),
            ["Light bluish green"] = color_to_hexstring(183, 215, 213),
            ["Br. yellowish green"] = color_to_hexstring(164, 189, 71),
            ["Lig. yellowish green"] = color_to_hexstring(217, 228, 167),
            ["Med. yellowish orange"] = color_to_hexstring(231, 172, 88),
            ["Br. reddish orange"] = color_to_hexstring(211, 111, 76),
            ["Bright reddish violet"] = color_to_hexstring(146, 57, 120),
            ["Light orange"] = color_to_hexstring(234, 184, 146),
            ["Tr. Bright bluish violet"] = color_to_hexstring(165, 165, 203),
            ["Dark nougat"] = color_to_hexstring(174, 122, 89),
            ["Silver"] = color_to_hexstring(156, 163, 168),
            ["Neon orange"] = color_to_hexstring(213, 115, 61),
            ["Neon green"] = color_to_hexstring(216, 221, 86),
            ["Sand blue"] = color_to_hexstring(116, 134, 157),
            ["Sand violet"] = color_to_hexstring(135, 124, 144),
            ["Medium orange"] = color_to_hexstring(224, 152, 100),
            ["Sand yellow"] = color_to_hexstring(149, 138, 115),
            ["Earth blue"] = color_to_hexstring(32, 58, 86),
            ["Earth green"] = color_to_hexstring(39, 70, 45),
            ["Tr. Flu. Blue"] = color_to_hexstring(207, 226, 247),
            ["Sand blue metallic"] = color_to_hexstring(121, 136, 161),
            ["Sand violet metallic"] = color_to_hexstring(149, 142, 163),
            ["Sand yellow metallic"] = color_to_hexstring(147, 135, 103),
            ["Dark grey metallic"] = color_to_hexstring(87, 88, 87),
            ["Black metallic"] = color_to_hexstring(22, 29, 50),
            ["Light grey metallic"] = color_to_hexstring(171, 173, 172),
            ["Sand green"] = color_to_hexstring(120, 144, 130),
            ["Sand red"] = color_to_hexstring(149, 121, 119),
            ["Dark red"] = color_to_hexstring(123, 46, 47),
            ["Tr. Flu. Yellow"] = color_to_hexstring(255, 246, 123),
            ["Tr. Flu. Red"] = color_to_hexstring(225, 164, 194),
            ["Gun metallic"] = color_to_hexstring(117, 108, 98),
            ["Red flip/flop"] = color_to_hexstring(151, 105, 91),
            ["Yellow flip/flop"] = color_to_hexstring(180, 132, 85),
            ["Silver flip/flop"] = color_to_hexstring(137, 135, 136),
            ["Curry"] = color_to_hexstring(215, 169, 75),
            ["Fire Yellow"] = color_to_hexstring(249, 214, 46),
            ["Flame yellowish orange"] = color_to_hexstring(232, 171, 45),
            ["Reddish brown"] = color_to_hexstring(105, 64, 40),
            ["Flame reddish orange"] = color_to_hexstring(207, 96, 36),
            ["Medium stone grey"] = color_to_hexstring(163, 162, 165),
            ["Royal blue"] = color_to_hexstring(70, 103, 164),
            ["Dark Royal blue"] = color_to_hexstring(35, 71, 139),
            ["Bright reddish lilac"] = color_to_hexstring(142, 66, 133),
            ["Dark stone grey"] = color_to_hexstring(99, 95, 98),
            ["Lemon metalic"] = color_to_hexstring(130, 138, 93),
            ["Light stone grey"] = color_to_hexstring(229, 228, 223),
            ["Dark Curry"] = color_to_hexstring(176, 142, 68),
            ["Faded green"] = color_to_hexstring(112, 149, 120),
            ["Turquoise"] = color_to_hexstring(121, 181, 181),
            ["Light Royal blue"] = color_to_hexstring(159, 195, 233),
            ["Medium Royal blue"] = color_to_hexstring(108, 129, 183),
            ["Brown"] = color_to_hexstring(124, 92, 70),
            ["Reddish lilac"] = color_to_hexstring(150, 112, 159),
            ["Light lilac"] = color_to_hexstring(167, 169, 206),
            ["Bright purple"] = color_to_hexstring(205, 98, 152),
            ["Light purple"] = color_to_hexstring(228, 173, 200),
            ["Light pink"] = color_to_hexstring(220, 144, 149),
            ["Light brick yellow"] = color_to_hexstring(240, 213, 160),
            ["Warm yellowish orange"] = color_to_hexstring(235, 184, 127),
            ["Cool yellow"] = color_to_hexstring(253, 234, 141),
            ["Dove blue"] = color_to_hexstring(125, 187, 221),
            ["Medium lilac"] = color_to_hexstring(52, 43, 117),
            ["Slime green"] = color_to_hexstring(80, 109, 84),
            ["Smoky grey"] = color_to_hexstring(91, 93, 105),
            ["Dark blue"] = color_to_hexstring(0, 16, 176),
            ["Parsley green"] = color_to_hexstring(44, 101, 29),
            ["Steel blue"] = color_to_hexstring(82, 124, 174),
            ["Storm blue"] = color_to_hexstring(51, 88, 130),
            ["Lapis"] = color_to_hexstring(16, 42, 220),
            ["Dark indigo"] = color_to_hexstring(61, 21, 133),
            ["Sea green"] = color_to_hexstring(52, 142, 64),
            ["Shamrock"] = color_to_hexstring(91, 154, 76),
            ["Fossil"] = color_to_hexstring(159, 161, 172),
            ["Mulberry"] = color_to_hexstring(89, 34, 89),
            ["Forest green"] = color_to_hexstring(31, 128, 29),
            ["Cadet blue"] = color_to_hexstring(159, 173, 192),
            ["Electric blue"] = color_to_hexstring(9, 137, 207),
            ["Eggplant"] = color_to_hexstring(123, 0, 123),
            ["Moss"] = color_to_hexstring(124, 156, 107),
            ["Artichoke"] = color_to_hexstring(138, 171, 133),
            ["Sage green"] = color_to_hexstring(185, 196, 177),
            ["Ghost grey"] = color_to_hexstring(202, 203, 209),
            ["Lilac"] = color_to_hexstring(167, 94, 155),
            ["Plum"] = color_to_hexstring(123, 47, 123),
            ["Olivine"] = color_to_hexstring(148, 190, 129),
            ["Laurel green"] = color_to_hexstring(168, 189, 153),
            ["Quill grey"] = color_to_hexstring(223, 223, 222),
            ["Crimson"] = color_to_hexstring(151, 0, 0),
            ["Mint"] = color_to_hexstring(177, 229, 166),
            ["Baby blue"] = color_to_hexstring(152, 194, 219),
            ["Carnation pink"] = color_to_hexstring(255, 152, 220),
            ["Persimmon"] = color_to_hexstring(255, 89, 89),
            ["Maroon"] = color_to_hexstring(117, 0, 0),
            ["Gold"] = color_to_hexstring(239, 184, 56),
            ["Daisy orange"] = color_to_hexstring(248, 217, 109),
            ["Pearl"] = color_to_hexstring(231, 231, 236),
            ["Fog"] = color_to_hexstring(199, 212, 228),
            ["Salmon"] = color_to_hexstring(255, 148, 148),
            ["Terra Cotta"] = color_to_hexstring(190, 104, 98),
            ["Cocoa"] = color_to_hexstring(86, 36, 36),
            ["Wheat"] = color_to_hexstring(241, 231, 199),
            ["Buttermilk"] = color_to_hexstring(254, 243, 187),
            ["Mauve"] = color_to_hexstring(224, 178, 208),
            ["Sunrise"] = color_to_hexstring(212, 144, 189),
            ["Tawny"] = color_to_hexstring(150, 85, 85),
            ["Rust"] = color_to_hexstring(143, 76, 42),
            ["Cashmere"] = color_to_hexstring(211, 190, 150),
            ["Khaki"] = color_to_hexstring(226, 220, 188),
            ["Lily white"] = color_to_hexstring(237, 234, 234),
            ["Seashell"] = color_to_hexstring(233, 218, 218),
            ["Burgundy"] = color_to_hexstring(136, 62, 62),
            ["Cork"] = color_to_hexstring(188, 155, 93),
            ["Burlap"] = color_to_hexstring(199, 172, 120),
            ["Beige"] = color_to_hexstring(202, 191, 163),
            ["Oyster"] = color_to_hexstring(187, 179, 178),
            ["Pine Cone"] = color_to_hexstring(108, 88, 75),
            ["Fawn brown"] = color_to_hexstring(160, 132, 79),
            ["Hurricane grey"] = color_to_hexstring(149, 137, 136),
            ["Cloudy grey"] = color_to_hexstring(171, 168, 158),
            ["Linen"] = color_to_hexstring(175, 148, 131),
            ["Copper"] = color_to_hexstring(150, 103, 102),
            ["Dirt brown"] = color_to_hexstring(86, 66, 54),
            ["Bronze"] = color_to_hexstring(126, 104, 63),
            ["Flint"] = color_to_hexstring(105, 102, 92),
            ["Dark taupe"] = color_to_hexstring(90, 76, 66),
            ["Burnt Sienna"] = color_to_hexstring(106, 57, 9),
            ["Institutional white"] = color_to_hexstring(248, 248, 248),
            ["Mid gray"] = color_to_hexstring(205, 205, 205),
            ["Really black"] = color_to_hexstring(17, 17, 17),
            ["Really red"] = color_to_hexstring(255, 0, 0),
            ["Alder"] = color_to_hexstring(180, 128, 255),
            ["Dusty Rose"] = color_to_hexstring(163, 75, 75),
            ["Olive"] = color_to_hexstring(193, 190, 66),
            ["New Yeller"] = color_to_hexstring(255, 255, 0),
            ["Really blue"] = color_to_hexstring(0, 0, 255),
            ["Navy blue"] = color_to_hexstring(0, 32, 96),
            ["Deep blue"] = color_to_hexstring(33, 84, 185),
            ["Cyan"] = color_to_hexstring(4, 175, 236),
            ["CGA brown"] = color_to_hexstring(170, 85, 0),
            ["Magenta"] = color_to_hexstring(170, 0, 170),
            ["Pink"] = color_to_hexstring(255, 102, 204),
            ["Deep orange"] = color_to_hexstring(255, 175, 0),
            ["Teal"] = color_to_hexstring(18, 238, 212),
            ["Toothpaste"] = color_to_hexstring(0, 255, 255),
            ["Lime green"] = color_to_hexstring(0, 255, 0),
            ["Camo"] = color_to_hexstring(58, 125, 21),
            ["Grime"] = color_to_hexstring(127, 142, 100),
            ["Lavender"] = color_to_hexstring(140, 91, 159),
            ["Pastel light blue"] = color_to_hexstring(175, 221, 255),
            ["Pastel orange"] = color_to_hexstring(255, 201, 201),
            ["Pastel violet"] = color_to_hexstring(177, 167, 255),
            ["Pastel blue-green"] = color_to_hexstring(159, 243, 233),
            ["Pastel green"] = color_to_hexstring(204, 255, 204),
            ["Pastel yellow"] = color_to_hexstring(255, 255, 204),
            ["Pastel brown"] = color_to_hexstring(255, 204, 153),
            ["Royal purple"] = color_to_hexstring(98, 37, 209),
            ["Hot pink"] = color_to_hexstring(255, 0, 191),
          },




          RGB = true, -- #RGB hex codes
          RGBA = true, -- #RGBA hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          RRGGBBAA = false, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = false, -- CSS rgb() and rgba() functions
          hsl_fn = false, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS *features*:
          -- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
          css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
          tailwind = false, -- Enable tailwind colors
          tailwind_opts = { -- Options for highlighting tailwind names
            update_names = false, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
          },
          -- parsers can contain values used in `user_default_options`
          sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
          -- Highlighting mode.  'background'|'foreground'|'virtualtext'
          mode = "background", -- Set the display mode
          -- Virtualtext character to use
          virtualtext = "■",
          -- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
          virtualtext_inline = false,
          -- Virtualtext highlight mode: 'background'|'foreground'
          virtualtext_mode = "foreground",
          -- update color values even if buffer is not focused
          -- example use: cmp_menu, cmp_docs
          always_update = false,
          -- hooks to invert control of colorizer
          hooks = {
            -- called before line parsing.  Accepts boolean or function that returns boolean
            -- see hooks section below
            disable_line_highlight = false,
          },
        },
  }
}
