local ok, cybu = pcall(require, "cybu")
if not ok then
	return
end
cybu.setup({
	display_time = 750,
	style = {
		highlights = {
			current_buffer = "IncSearch",
		},
		padding = 2,
	},
	behavior = { -- set behavior for different modes
		mode = {
			default = {
				switch = "immediate", -- immediate, on_close
				view = "rolling", -- paging, rolling
			},
			last_used = {
				switch = "immediate", -- immediate, on_close
				view = "paging", -- paging, rolling
			},
		},
	},
})
