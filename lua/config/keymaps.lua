local map = vim.keymap.set
local icons = require("core.icons")

local function desc(text)
	return { noremap = true, silent = true, desc = text }
end

local general = icons.general
local ui = icons.ui
local nav = icons.navigation
local edit = icons.editing
local diag = icons.diagnostics
local lsp = icons.lsp
local git = icons.git

-----------------------------------------------------------
-- Core editing
-----------------------------------------------------------

map("i", "jk", "<Esc>", desc(general.exit .. " Exit insert mode"))
map("i", "kj", "<Esc>", desc(general.exit .. " Exit insert mode"))
map({ "n", "v" }, "<Space>", "<Nop>", desc(general.disable .. " Disable space"))

map("n", "<Esc>", "<cmd>nohlsearch<cr>", desc(general.clear .. " Clear search highlight"))
map("n", "<leader>w", "<cmd>w<cr>", desc(general.save .. " Save file"))
map("n", "<leader>q", "<cmd>q<cr>", desc(general.close .. " Quit window"))
map("n", "<leader>x", "<cmd>bd<cr>", desc(general.close .. " Close buffer"))

map("n", "x", '"_x', desc(edit.delete .. " Delete without yank"))
map({ "n", "v" }, "<leader>y", '"+y', desc(general.clipboard .. " Yank to clipboard"))
map("n", "<leader>Y", '"+Y', desc(general.clipboard .. " Yank line to clipboard"))
map({ "n", "v" }, "<leader>d", '"_d', desc(edit.delete .. " Delete without yank"))
map("n", "<leader>D", '"_D', desc(edit.delete .. " Delete line without yank"))
map("n", "Q", "<nop>", desc(general.close .. " Disable Q"))

-----------------------------------------------------------
-- Window management
-----------------------------------------------------------

map("n", "<leader>sv", "<cmd>vsplit<cr>", desc(ui.split .. " Split vertical"))
map("n", "<leader>sh", "<cmd>split<cr>", desc(ui.split .. " Split horizontal"))
map("n", "<leader>se", "<C-w>=", desc(ui.split .. " Equalize splits"))
map("n", "<leader>sx", "<cmd>close<cr>", desc(ui.split .. " Close split"))

map("n", "<C-h>", "<C-w>h", desc(ui.split .. " Move left"))
map("n", "<C-j>", "<C-w>j", desc(ui.split .. " Move down"))
map("n", "<C-k>", "<C-w>k", desc(ui.split .. " Move up"))
map("n", "<C-l>", "<C-w>l", desc(ui.split .. " Move right"))

-----------------------------------------------------------
-- Buffers
-----------------------------------------------------------

map("n", "<leader>bn", "<cmd>bnext<cr>", desc(nav.buffer .. " Next buffer"))
map("n", "<leader>bp", "<cmd>bprevious<cr>", desc(nav.buffer .. " Previous buffer"))
map("n", "<leader>bl", "<cmd>ls<cr>", desc(nav.buffer .. " List buffers"))

-----------------------------------------------------------
-- Search
-----------------------------------------------------------
--telescope

-- map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", desc(general.find .. " Find files"))
-- map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", desc(general.search .. " Live grep"))
-- map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", desc(nav.buffer .. " Buffers"))
-- map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", desc(general.help .. " Help tags"))
-- map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc(general.recent .. " Recent files"))
-- map("n", "<leader>fc", "<cmd>Telescope commands<cr>", desc(general.command .. " Commands"))
-- map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", desc(general.keymap .. " Keymaps"))

-- Snacks picker

map("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find Files" })
map("n", "<leader>fw", function()
	Snacks.picker.grep()
end, { desc = "Live Grep (Words)" })
map("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Find Buffers" })
map("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent Files" })
map("n", "<leader>fc", function()
	Snacks.picker.colorschemes()
end, { desc = "Colorschemes" })
map("n", "<leader>fC", function()
	Snacks.picker.commands()
end, { desc = "Commands" })
map("n", "<leader>fh", function()
	Snacks.picker.help()
end, { desc = "Help Pages" })
map("n", "<leader>fk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps" })
map("n", "<leader>sR", function()
	Snacks.picker.resume()
end, { desc = "Resume Last Search" })

-----------------------------------------------------------
-- File tree / navigation
-----------------------------------------------------------

map("n", "<leader>e", "<cmd>Neotree toggle<cr>", desc(nav.explorer .. " Toggle explorer"))
map("n", "<leader>o", "<cmd>Neotree focus<cr>", desc(nav.explorer .. " Focus explorer"))

-----------------------------------------------------------
-- Diagnostics / LSP
-----------------------------------------------------------

map("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, desc(diag.diagnostic .. " Previous diagnostic"))
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, desc(diag.diagnostic .. " Next diagnostic"))
map("n", "<leader>ud", vim.diagnostic.open_float, desc(diag.diagnostic .. " Show diagnostics"))

map("n", "K", vim.lsp.buf.hover, desc(lsp.hover .. " Hover"))
map("n", "gd", vim.lsp.buf.definition, desc(lsp.definition .. " Go to definition"))
map("n", "gD", vim.lsp.buf.declaration, desc(lsp.definition .. " Go to declaration"))
map("n", "gi", vim.lsp.buf.implementation, desc(lsp.implementation .. " Go to implementation"))
map("n", "gr", vim.lsp.buf.references, desc(lsp.references .. " References"))
map("n", "<leader>rn", vim.lsp.buf.rename, desc(lsp.rename .. " Rename"))
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, desc(lsp.code_action .. " Code action"))
map("n", "<leader>lf", function()
	vim.lsp.buf.format({ async = true })
end, desc(lsp.formatting .. " Format"))

-----------------------------------------------------------
-- Git
-----------------------------------------------------------

local function with_gitsigns(fn)
	return function(...)
		local ok, gs = pcall(require, "gitsigns")
		if not ok then
			return
		end
		return fn(gs, ...)
	end
end

map(
	"n",
	"]c",
	with_gitsigns(function(gs)
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gs.nav_hunk("next")
		end
	end),
	desc(git.change .. " Next hunk")
)

map(
	"n",
	"[c",
	with_gitsigns(function(gs)
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gs.nav_hunk("prev")
		end
	end),
	desc(git.change .. " Previous hunk")
)

map(
	"n",
	"<leader>gs",
	with_gitsigns(function(gs)
		gs.stage_hunk()
	end),
	desc(git.add .. " Stage hunk")
)

map(
	"n",
	"<leader>gr",
	with_gitsigns(function(gs)
		gs.reset_hunk()
	end),
	desc(git.delete .. " Reset hunk")
)

map(
	"v",
	"<leader>gs",
	with_gitsigns(function(gs)
		gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end),
	desc(git.add .. " Stage selection")
)

map(
	"v",
	"<leader>gr",
	with_gitsigns(function(gs)
		gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end),
	desc(git.delete .. " Reset selection")
)

map(
	"n",
	"<leader>gS",
	with_gitsigns(function(gs)
		gs.stage_buffer()
	end),
	desc(git.staged .. " Stage buffer")
)

map(
	"n",
	"<leader>gR",
	with_gitsigns(function(gs)
		gs.reset_buffer()
	end),
	desc(git.delete .. " Reset buffer")
)

map(
	"n",
	"<leader>gp",
	with_gitsigns(function(gs)
		gs.preview_hunk()
	end),
	desc(git.change .. " Preview hunk")
)

map(
	"n",
	"<leader>gb",
	with_gitsigns(function(gs)
		gs.blame_line({ full = true })
	end),
	desc(git.blame .. " Blame line")
)

map(
	"n",
	"<leader>gd",
	with_gitsigns(function(gs)
		gs.diffthis()
	end),
	desc(git.change .. " Diff this")
)

map(
	"n",
	"<leader>gD",
	with_gitsigns(function(gs)
		gs.diffthis("~")
	end),
	desc(git.change .. " Diff against HEAD")
)

map(
	"n",
	"<leader>gt",
	with_gitsigns(function(gs)
		gs.toggle_current_line_blame()
	end),
	desc(git.blame .. " Toggle blame")
)

map(
	"n",
	"<leader>gw",
	with_gitsigns(function(gs)
		gs.toggle_word_diff()
	end),
	desc(git.change .. " Toggle word diff")
)

-----------------------------------------------------------
-- UI / toggles
-----------------------------------------------------------

map("n", "<leader>ul", "<cmd>set list!<cr>", desc(general.ui .. " Toggle list chars"))
map("n", "<leader>ur", "<cmd>set relativenumber!<cr>", desc(general.ui .. " Toggle relative numbers"))
map("n", "<leader>uw", "<cmd>set wrap!<cr>", desc(general.ui .. " Toggle wrap"))
map("n", "<leader>uc", "<cmd>set cursorline!<cr>", desc(general.ui .. " Toggle cursorline"))

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------

map("n", "<leader>tt", "<cmd>split | terminal<cr>", desc(general.terminal .. " Terminal horizontal"))
map("n", "<leader>tv", "<cmd>vsplit | terminal<cr>", desc(general.terminal .. " Terminal vertical"))
