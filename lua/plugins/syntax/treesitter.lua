return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	init = function()
		-- 1. Enable Tree-sitter highlighting natively
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})

		-- 2. (Optional) Enable Tree-sitter based folding
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
	end,
	config = function()
		local ensure_installed = {
			-----------------------------------------------------------
			-- Web Development
			"html",
			"css",
			"scss",
			"javascript",
			"typescript",
			"tsx",
			"vue",
			"svelte",
			"astro",
			"xml",

			-----------------------------------------------------------
			-- Data / Config
			"json",
			"yaml",
			"toml",

			-----------------------------------------------------------
			-- Backend / DevOps
			"bash",
			"dockerfile",

			-----------------------------------------------------------
			-- Markdown
			"markdown",
			"markdown_inline",

			-----------------------------------------------------------
			-- Git
			"gitignore",

			-----------------------------------------------------------
			-- Lua / Neovim
			"lua",
			"luadoc",
			"vim",
			"vimdoc",

			-----------------------------------------------------------
			-- Treesitter internals
			"query",
			"regex",
		}

		-- The new install API automatically skips already-installed parsers!
		require("nvim-treesitter").install(ensure_installed)
	end,
}
