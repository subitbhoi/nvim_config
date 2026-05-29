local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------------------------
-- Groups
-----------------------------------------------------------

local general = augroup("SubitGeneralAutocmds", { clear = true })
local ui = augroup("SubitUIAutocmds", { clear = true })
local editing = augroup("SubitEditingAutocmds", { clear = true })
local terminal = augroup("SubitTerminalAutocmds", { clear = true })

-----------------------------------------------------------
-- Highlight yanked text
-----------------------------------------------------------

autocmd("TextYankPost", {
	group = general,
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 120,
		})
	end,
	desc = "Highlight yanked text",
})

-----------------------------------------------------------
-- Restore last cursor position
-----------------------------------------------------------

autocmd("BufReadPost", {
	group = general,
	callback = function(event)
		local exclude = {
			"gitcommit",
			"gitrebase",
			"help",
		}

		if vim.tbl_contains(exclude, vim.bo[event.buf].filetype) then
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(event.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(event.buf)

		if last_pos[1] > 0 and last_pos[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
		end
	end,
	desc = "Restore cursor position",
})

-----------------------------------------------------------
-- Auto-create parent directories on save
-----------------------------------------------------------

autocmd("BufWritePre", {
	group = editing,
	callback = function(event)
		local file = vim.api.nvim_buf_get_name(event.buf)
		if file == "" then
			return
		end

		local dir = vim.fn.fnamemodify(file, ":p:h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
	desc = "Create missing parent directories",
})

-----------------------------------------------------------
-- Keep splits equal after resizing the editor
-----------------------------------------------------------

autocmd("VimResized", {
	group = ui,
	callback = function()
		vim.cmd("wincmd =")
	end,
	desc = "Equalize window splits",
})

-----------------------------------------------------------
-- Close certain helper windows with q
-----------------------------------------------------------

autocmd("FileType", {
	group = ui,
	pattern = {
		"help",
		"man",
		"qf",
		"notify",
		"checkhealth",
		"lspinfo",
	},
	callback = function(event)
		vim.keymap.set("n", "q", "<cmd>close<cr>", {
			buffer = event.buf,
			silent = true,
			desc = "Close window",
		})
	end,
	desc = "Close helper windows with q",
})

-----------------------------------------------------------
-- Web-dev friendly buffers
-----------------------------------------------------------

autocmd("FileType", {
	group = editing,
	pattern = {
		"markdown",
		"gitcommit",
	},
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
		vim.opt_local.conceallevel = 2
	end,
	desc = "Enable prose-friendly settings",
})

autocmd("FileType", {
	group = editing,
	pattern = {
		"html",
		"css",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"jsonc",
		"yaml",
		"lua",
		"sh",
	},
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
	desc = "Reduce auto-comment continuation",
})

-----------------------------------------------------------
-- Terminal behavior
-----------------------------------------------------------

autocmd("TermOpen", {
	group = terminal,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.cursorline = false
		vim.cmd("startinsert")
	end,
	desc = "Enter insert mode in terminal",
})

autocmd("TermClose", {
	group = terminal,
	callback = function(event)
		if vim.bo[event.buf].buftype == "terminal" then
			vim.cmd("stopinsert")
		end
	end,
	desc = "Leave insert mode when terminal closes",
})

-----------------------------------------------------------
-- Animated LSP
-----------------------------------------------------------

autocmd("LspProgress", {
	group = ui,
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
			id = "lsp_progress",
			title = "LSP Progress",
			opts = function(notif)
				notif.icon = ev.data.params.value.kind == "end" and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})
