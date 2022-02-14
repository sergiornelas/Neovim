-- Use a protected call so we don't error out on first use
local present, packer = pcall(require, "packerInit")
if present then
	packer = require("packer")
else
	return false
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost pluginList.lua source <afile> | PackerSync
  augroup end
]])

local use = packer.use
return packer.startup(function()
	-- HAVE PACKER MANAGE ITSELF -----------------------
	use({
		"wbthomason/packer.nvim",
		event = "VimEnter",
	})

	-- STARTUP OPTIMIZATIONS ---------------------------
	use({
		"nathom/filetype.nvim",
		config = function()
			vim.g.did_load_filetypes = 1
		end,
	})
	use({
		"lewis6991/impatient.nvim",
		-- after = 'filetype.nvim',
	})

	use({
		"tweekmonster/startuptime.vim",
		cmd = "StartupTime",
	})

	-- COLORSCHEMES
	use("lunarvim/darkplus.nvim")
	use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }) --heavy af
	use("rebelot/kanagawa.nvim")
	use("nxvu699134/vn-night.nvim")
	use("ray-x/aurora")
	use("folke/tokyonight.nvim")

	-- CMP ---------------------------------------------
	use({
		"hrsh7th/nvim-cmp",
		after = "friendly-snippets",
		config = function()
			require("plugins.cmp")
		end,
	})
	use({
		"hrsh7th/cmp-buffer",
		after = "nvim-cmp",
	})
	use({
		"hrsh7th/cmp-path",
		after = "nvim-cmp",
	})

	use({
		"hrsh7th/cmp-cmdline",
		after = "nvim-cmp",
	})
	use({
		"saadparwaiz1/cmp_luasnip",
		after = "LuaSnip",
	})
	-- LSP CMP
	use({
		"hrsh7th/cmp-nvim-lsp",
		after = "nvim-lspconfig",
		-- after = "nvim-cmp",
		-- after = {"nvim-lspconfig", "nvim-cmp"}
	})
	-- LUA CMP
	use({
		"hrsh7th/cmp-nvim-lua",
		after = "nvim-cmp",
	})
	-- DETAILED INFO CMP
	-- use {
	-- "ray-x/lsp_signature.nvim",
	-- after = "nvim-lspconfig",
	-- config = function()
	-- require("plugins.others").signature()
	-- end,
	-- }
	-- TREESITTER CMP
	-- use {
	--   "ray-x/cmp-treesitter",
	--   after = "nvim-cmp",
	-- }

	-- SNIPPETS ------------------------------------------
	use({
		"L3MON4D3/LuaSnip",
		wants = "friendly-snippets",
		after = "nvim-cmp",
	})
	use({
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
	})

	-- LSP ----------------------------------------------
	use({
		"neovim/nvim-lspconfig",
		after = "nvim-lsp-installer",
		config = function()
			require("lsp")
		end,
	})
	use({
		"williamboman/nvim-lsp-installer",
		opt = true,
		setup = function()
			require("config").packer_lazy_load("nvim-lsp-installer")
			-- reload the current file so lsp actually starts for it
			vim.defer_fn(function()
				vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
			end, 0)
		end,
		config = function()
			require("lsp")
		end,
	})

	-- NULL-LS -------------------------------------------
	use({
		"jose-elias-alvarez/null-ls.nvim",
		module = "lspconfig",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({
		"jose-elias-alvarez/nvim-lsp-ts-utils", -- LSP-TS-UTILS
		after = "null-ls.nvim",
	})

	-- TREESITTER -----------------------------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
		event = "BufRead",
		run = ":TSUpdate",
	})
	-- RAINBOW
	use({
		"p00f/nvim-ts-rainbow",
		after = "nvim-treesitter",
	})

	-- COMMENTS --------------------------------------------
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.others").comment()
		end,
	})

	-- JSX COMMENTS
	use({
		"JoosepAlviste/nvim-ts-context-commentstring", --heavy plugin (0.784)
		-- ft = "javascript, javascriptreact, typescript, typescriptreact", (didn't work)
	})

	-- TELESCOPE ------------------------------------------
	use({
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		requires = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				"nvim-lua/plenary.nvim",
				run = "make",
			},
		},
		config = function()
			require("plugins.telescope")
		end,
	})
	-- use "nvim-telescope/telescope-media-files.nvim"

	-- NVIM TREE ------------------------------------------
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("plugins.nvimtree")
		end,
	})
	-- DEVICONS
	use({
		"kyazdani42/nvim-web-devicons",
	})

	-- COLORIZER ------------------------------------------
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("plugins.others").colorizer()
		end,
	})

	-- GIT SIGNS -------------------------------------------
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.gitsigns")
		end,
	})

	-- GIT DIFF --------------------------------------------------
	use({
		"sindrets/diffview.nvim", --heavy plugin (+3.8)
		cmd = { "DiffviewOpen" },
		config = function()
			require("plugins.others").gitdiff()
		end,
	})

	-- HOP --------------------------------------------------
	use({
		"phaazon/hop.nvim",
		cmd = {
			"HopWord",
			"HopLine",
			"HopChar1",
			"HopChar2",
			"HopPattern",
		},
		as = "hop",
		config = function()
			require("hop").setup()
		end,
	})

	-- AUTOPAIRS ---------------------------------------------
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.autopairs")
		end,
	})

	-- TERMINAL ------------------------------------------------
	use({
		"akinsho/toggleterm.nvim",
		opt = true,
		cmd = "ToggleTerm",
		config = function()
			require("plugins.toggleterm")
		end,
	})

	-- PROJECT --------------------------------------------------
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup()
		end,
	})

	-- LUALINE --------------------------------------------------
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	})

	-- NOTES --------------------------------------------------
	use({
		"nvim-neorg/neorg",
		setup = vim.cmd("autocmd BufRead,BufNewFile *.norg setlocal filetype=norg"),
		after = { "nvim-treesitter" }, -- you may also specify telescope
		ft = "norg",
		config = function()
			require("plugins.neorg")
		end,
		requires = "nvim-lua/plenary.nvim",
	})

	use({
		"nvim-neorg/neorg-telescope",
	})

	-- BUFFERLINE --------------------------------------------------
	use({
		"akinsho/bufferline.nvim",
		after = "nvim-web-devicons",
		config = function()
			require("plugins.bufferline")
		end,
	})

	-- ZEN MODE --------------------------------------------------
	use({
		"Pocco81/TrueZen.nvim",
		cmd = { "TZAtaraxis", "TZFocus", "TZMinimalist" },
		config = function()
			require("plugins.others").truezen()
		end,
	})

	-- BUFFER DELETE --------------------------------------------------
	use({
		"famiu/bufdelete.nvim",
		cmd = { "Bdelete", "Bwipeout", "Bdelete!", "Bwipeout!" },
	})

	-- EMMET ------------------------------------------------
	-- use {
	--   "mattn/emmet-vim",
	--   opt = true,
	--   keys = '<c-c>',
	--   -- cmd = {'emmet-expand-abbr'}
	-- }

	-- AUTO CHANGE HTML & JSX TAGS --------------------------
	-- use {
	--   "windwp/nvim-ts-autotag",
	-- }

	-- HARD MODE --------------------------------------------
	-- use 'takac/vim-hardtime'

	-- COPILOT ----------------------------------------------
	-- LSP (and copilot
	-- use {
	--    "github/copilot.vim",
	--    event = "InsertEnter",
	-- }

	-- NEOGIT -----------------------------------------------
	-- use {
	--    "TimUntersberger/neogit",
	--    cmd = {
	--       "Neogit",
	--       "Neogit commit",
	--    },
	--    config = function()
	--       require "plugins.neogit"
	--    end,
	-- }
end)
