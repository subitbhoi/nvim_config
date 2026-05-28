return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	
	opts = function()
		local actions = require("telescope.actions")
		local icons = require("core.icons")
		local borders = require("core.borders")

		return {
			defaults = {
				prompt_prefix = icons.general.search .. " ",
				selection_caret = icons.ui.selection .. " ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.58,
						mirror = false,
					},
					width = 0.92,
					height = 0.86,
					preview_cutoff = 120,
				},
				file_ignore_patterns = {
					"node_modules",
					".git/",
					"dist/",
					"build/",
					".next/",
					"coverage/",
					"vendor/",
				},
				path_display = { "smart" },
				winblend = 0,
				border = true,
				borderchars = borders.telescope,
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-q>"] = actions.send_to_qflist,
						["<Esc>"] = actions.close,
					},
					n = {
						["q"] = actions.close,
					},
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob",
					"!.git",
					"--glob",
					"!node_modules",
					"--glob",
					"!.next",
					"--glob",
					"!dist",
					"--glob",
					"!build",
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
				},
				buffers = {
					sort_mru = true,
					ignore_current_buffer = true,
					previewer = false,
				},
			},
		}
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
	end,
}
