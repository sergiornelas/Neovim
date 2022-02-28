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
})

vim.cmd([[
  autocmd TermEnter term://*toggleterm#*
  \ tnoremap <silent><c-q> <Cmd>exe v:count1 . "5ToggleTerm direction=horizontal size=20"<CR>

  nnoremap <silent><c-q> <Cmd>exe v:count1 . "5ToggleTerm direction=horizontal size=20"<CR>
  inoremap <silent><c-q> <Esc><Cmd>exe v:count1 . "5ToggleTerm direction=horizontal size=20"<CR>

  autocmd TermEnter term://*toggleterm#*
  \ tnoremap <silent><c-g> <Cmd>exe v:count1 . "ToggleTerm"<CR>

  nnoremap <silent><c-g> <Cmd>exe v:count1 . "ToggleTerm"<CR>
  inoremap <silent><c-g> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
]])

-- local Terminal = require("toggleterm.terminal").Terminal
-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

-- function _LAZYGIT_TOGGLE()
-- 	lazygit:toggle()
-- end

-- vim.api.nvim_set_keymap("n", "<c-w><c-g>", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })
