local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local navic = require("nvim-navic")

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "NvimTree" },
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "filename" },
		lualine_b = { "diff", "diagnostics" },
		lualine_c = {
			{ navic.get_location, cond = navic.is_available },
		},
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
