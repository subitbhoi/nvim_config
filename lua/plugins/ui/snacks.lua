return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,

	opts = function()
		local icons = require("core.icons")

		return {
			dashboard = {
				enabled = true,

				width = 60,
				row = nil,
				col = nil,
				pane_gap = 4,

				autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

				preset = {
					pick = nil,

					keys = {
						{
							icon = icons.dashboard.find_file,
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{
							icon = icons.dashboard.new_file,
							key = "n",
							desc = "New File",
							action = ":ene | startinsert",
						},
						{
							icon = icons.dashboard.find_text,
							key = "g",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = icons.dashboard.recent_files,
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = icons.dashboard.config,
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
						},
						{
							icon = icons.dashboard.restore_session,
							key = "s",
							desc = "Restore Session",
							section = "session",
						},
						{
							icon = icons.dashboard.lazy,
							key = "L",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{
							icon = icons.general.settings,
							key = "h",
							desc = "Check Health",
							action = ":checkhealth",
						},
						{
							icon = icons.dashboard.quit,
							key = "q",
							desc = "Quit",
							action = ":qa",
						},
					},

					header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
				},

				formats = {
					icon = function(item)
						if item.file and (item.icon == "file" or item.icon == "directory") then
							return Snacks.dashboard.icon(item.file, item.icon)
						end

						return {
							item.icon,
							width = 2,
							hl = "icon",
						}
					end,

					footer = {
						"%s",
						align = "center",
					},

					header = {
						"%s",
						align = "center",
					},

					file = function(item, ctx)
						local fname = vim.fn.fnamemodify(item.file, ":~")

						fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname

						if #fname > ctx.width then
							local dir = vim.fn.fnamemodify(fname, ":h")
							local file = vim.fn.fnamemodify(fname, ":t")

							if dir and file then
								file = file:sub(-(ctx.width - #dir - 2))
								fname = dir .. "/…" .. file
							end
						end

						local dir, file = fname:match("^(.*)/(.+)$")

						return dir and {
							{ dir .. "/", hl = "dir" },
							{ file, hl = "file" },
						} or {
							{ fname, hl = "file" },
						}
					end,
				},

				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},

			notifier = {
				enabled = true,
				timeout = 3000,
				width = { min = 40, max = 0.4 },
				height = { min = 1, max = 0.6 },
				margin = { top = 0, right = 1, bottom = 0 },
				padding = true,
				gap = 0,
				sort = { "level", "added" },
				level = vim.log.levels.TRACE,
				icons = {
					error = icons.diagnostics.error,
					warn = icons.diagnostics.warn,
					info = icons.diagnostics.info,
					debug = icons.general.bug,
					trace = icons.diagnostics.trace,
				},
				style = "compact",
				top_down = true,
				date_format = "%R",
				more_format = " " .. icons.ui.expand_expanded .. " %d lines ",
				refresh = 50,
			},

			indent = {
				enabled = true,
				char = "│", -- Standard subtle vertical bar
				only_scope = false,
				only_current = false,

				-- 🌈 Rainbow Indents: Cycles through highlight groups
				hl = {
					"SnacksIndent1",
					"SnacksIndent2",
					"SnacksIndent3",
					"SnacksIndent4",
					"SnacksIndent5",
					"SnacksIndent6",
					"SnacksIndent7",
					"SnacksIndent8",
				},

				-- 🎬 Smooth Animations (Requires Neovim 0.10+)
				animate = {
					enabled = vim.fn.has("nvim-0.10") == 1,
					style = "out", -- Animates outwards from where your cursor is placed
					easing = "linear",
					duration = {
						step = 20, -- ms per step
						total = 500, -- maximum duration
					},
				},

				-- 🎯 Active Scope (The current block you are inside)
				scope = {
					enabled = true,
					char = "┃", -- Thicker bar to easily spot the active scope
					underline = false,
					only_current = false,
				},

				-- 📦 Chunk Mode (Draws a beautiful bounding box around the active scope)
				chunk = {
					enabled = true,
					only_current = false,
					char = {
						corner_top = "╭", -- Smooth rounded corners at the top
						corner_bottom = "╰", -- Smooth rounded corners at the bottom
						horizontal = "─", -- Horizontal top/bottom lines
						vertical = "│", -- Vertical sides
						arrow = "►", -- Pointer to the exact line your cursor is on
					},
				},
			},
		}
	end,
}
