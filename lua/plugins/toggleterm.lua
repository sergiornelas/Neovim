local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	open_mapping = [[<c-g>]],
	size = 120,
	direction = "float",
	float_opts = {
		border = "single",
		width = 100,
		height = 40,
	},
	insert_mappings = false, --disables toggle term when you're on insert mode
})

vim.cmd([[
  autocmd TermEnter term://*toggleterm#*
  \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "5ToggleTerm"<CR>

  nnoremap <silent><c-t> <Cmd>exe v:count1 . "5ToggleTerm"<CR>

  autocmd TermEnter term://*toggleterm#*
  \ tnoremap <silent><c-g> <Cmd>exe v:count1 . "ToggleTerm"<CR>

  nnoremap <silent><c-g> <Cmd>exe v:count1 . "ToggleTerm"<CR>
]])

-- local Terminal = require("toggleterm.terminal").Terminal
-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

-- function _LAZYGIT_TOGGLE()
-- 	lazygit:toggle()
-- end

-- vim.api.nvim_set_keymap("n", "<c-w><c-g>", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })
