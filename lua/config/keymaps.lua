---@diagnostic disable: undefined-global

local icons = require("core.icons")

-----------------------------------------------------------
-- THE SMART WRAPPER
-----------------------------------------------------------
local wk_specs = {} -- Table to secretly hold all our icons

-- Custom map function that safely intercepts the `icon` key
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  local icon = opts.icon
  opts.icon = nil -- Remove it so Neovim doesn't crash!

  -- 1. Register the native Neovim keymap instantly
  vim.keymap.set(mode, lhs, rhs, opts)

  -- 2. Save the icon to give to Which-Key later
  if icon then
    table.insert(wk_specs, { lhs, icon = icon, mode = mode })
  end
end

-----------------------------------------------------------
-- ICON VARIABLES
-----------------------------------------------------------
local general = icons.general
local ui = icons.ui
local nav = icons.navigation
local edit = icons.editing
local diag = icons.diagnostics
local lsp = icons.lsp
local git = icons.git
local dashboard = icons.dashboard
-- local whichkey = icons.whichkey
local textobjects = icons.textobjects

local function with_gitsigns(fn)
  return function(...)
    local has_gs, gs = pcall(require, "gitsigns")
    if not has_gs then
      return
    end
    return fn(gs, ...)
  end
end

-----------------------------------------------------------
-- FOLDER GROUP DEFINITIONS
-----------------------------------------------------------
table.insert(wk_specs, { "<leader>b", group = "Buffers", icon = general.buffer })
table.insert(wk_specs, { "<leader>c", group = "Code", icon = general.code })
table.insert(wk_specs, { "<leader>f", group = "Find", icon = general.find })
table.insert(wk_specs, { "<leader>g", group = "Git", icon = git.git })
table.insert(wk_specs, { "<leader>l", group = "LSP", icon = lsp.server })
table.insert(wk_specs, { "<leader>s", group = "Splits", icon = ui.split })
table.insert(wk_specs, { "<leader>t", group = "Terminal", icon = general.terminal })
table.insert(wk_specs, { "<leader>u", group = "UI", icon = general.ui })

table.insert(wk_specs, { "<leader>r", group = "Rename", icon = edit.pencil })

table.insert(wk_specs, { "<leader>a", group = "Swap", icon = textobjects.swap })

-----------------------------------------------------------
-- INLINE KEYMAPS (Beautiful and Crash-Free)
-----------------------------------------------------------

-- Core Editing
map("i", "jk", "<Esc>", { desc = "Exit insert mode", icon = general.exit })
map("i", "kj", "<Esc>", { desc = "Exit insert mode", icon = general.exit })
map({ "n", "v" }, "<Space>", "<Nop>", { desc = "Disable space", icon = general.disable })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight", icon = general.clear })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file", icon = general.save })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit", icon = dashboard.quit })
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "Close buffer", icon = general.close_buffer })
map("n", "x", '"_x', { desc = "Delete without yank", icon = edit.delete })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank", icon = general.clipboardcopy })
map("n", "<leader>Y", '"+Y', { desc = "Yank line", icon = general.clipboard })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete", icon = edit.delete })
map("n", "<leader>D", '"_D', { desc = "Delete line", icon = edit.delete_line })
map("n", "Q", "<nop>", { desc = "Disable Q", icon = general.close })

-- Window Management
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical", icon = ui.split })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal", icon = ui.split })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits", icon = ui.split })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close split", icon = ui.split })
map("n", "<C-h>", "<C-w>h", { desc = "Move left", icon = ui.split })
map("n", "<C-j>", "<C-w>j", { desc = "Move down", icon = ui.split })
map("n", "<C-k>", "<C-w>k", { desc = "Move up", icon = ui.split })
map("n", "<C-l>", "<C-w>l", { desc = "Move right", icon = ui.split })

-- Buffers
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer", icon = nav.buffer_next })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer", icon = nav.buffer_previous })
map("n", "<leader>bl", "<cmd>ls<cr>", { desc = "List buffers", icon = nav.buffer_list })

-- Search (Snacks.picker)
map("n", "<leader>fC", function()
  Snacks.picker.commands()
end, { desc = "Commands", icon = general.command })
map("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Find Buffers", icon = nav.buffer })
map("n", "<leader>fc", function()
  Snacks.picker.colorschemes()
end, { desc = "Colorschemes", icon = general.theme })
map("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Find Files", icon = general.find_file })
map("n", "<leader>fh", function()
  Snacks.picker.help()
end, { desc = "Help Pages", icon = general.help })
map("n", "<leader>fk", function()
  Snacks.picker.keymaps()
end, { desc = "Keymaps", icon = general.keymap })
map("n", "<leader>fr", function()
  Snacks.picker.recent()
end, { desc = "Recent Files", icon = general.recent })
map("n", "<leader>fw", function()
  Snacks.picker.grep()
end, { desc = "Live Grep (Words)", icon = general.live_grep })
map("n", "<leader>sR", function()
  Snacks.picker.resume()
end, { desc = "Resume Last Search", icon = general.search })

-- File Tree / Navigation
map("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "Neotree", icon = nav.explorer_tree })

map("n", "<leader>e", function()
  local explorer = Snacks.picker.get({ source = "explorer" })

  if #explorer > 0 then
    explorer[1]:focus()
  else
    Snacks.picker.explorer()
  end
end, {
  desc = "Explorer",
  icon = nav.explorer,
})

-- Diagnostics / LSP
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic", icon = diag.diagnostic })
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic", icon = diag.diagnostic })
map("n", "<leader>ud", vim.diagnostic.open_float, { desc = "Show diagnostics", icon = diag.diagnostic })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover", icon = lsp.hover })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", icon = lsp.definition })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", icon = lsp.definition })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", icon = lsp.implementation })
map("n", "gr", vim.lsp.buf.references, { desc = "References", icon = lsp.references })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename", icon = lsp.rename })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", icon = lsp.code_action })
map("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format", icon = lsp.formatting })

-- Git
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
  { desc = "Next hunk", icon = git.next_hunk }
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
  { desc = "Previous hunk", icon = git.previous_hunk }
)
map(
  "n",
  "<leader>gs",
  with_gitsigns(function(gs)
    gs.stage_hunk()
  end),
  { desc = "Stage hunk", icon = git.add }
)
map(
  "n",
  "<leader>gr",
  with_gitsigns(function(gs)
    gs.reset_hunk()
  end),
  { desc = "Reset hunk", icon = git.reset_hunk }
)
map(
  "v",
  "<leader>gs",
  with_gitsigns(function(gs)
    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end),
  { desc = "Stage selection", icon = git.add }
)
map(
  "v",
  "<leader>gr",
  with_gitsigns(function(gs)
    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end),
  { desc = "Reset selection", icon = git.reset }
)
map(
  "n",
  "<leader>gS",
  with_gitsigns(function(gs)
    gs.stage_buffer()
  end),
  { desc = "Stage buffer", icon = git.staged }
)
map(
  "n",
  "<leader>gR",
  with_gitsigns(function(gs)
    gs.reset_buffer()
  end),
  { desc = "Reset buffer", icon = git.reset_buffer }
)
map(
  "n",
  "<leader>gp",
  with_gitsigns(function(gs)
    gs.preview_hunk()
  end),
  { desc = "Preview hunk", icon = git.preview_hunk }
)
map(
  "n",
  "<leader>gb",
  with_gitsigns(function(gs)
    gs.blame_line({ full = true })
  end),
  { desc = "Blame line", icon = git.blame }
)
map(
  "n",
  "<leader>gd",
  with_gitsigns(function(gs)
    gs.diffthis()
  end),
  { desc = "Diff this", icon = git.change }
)
map(
  "n",
  "<leader>gD",
  with_gitsigns(function(gs)
    gs.diffthis("~")
  end),
  { desc = "Diff against HEAD", icon = git.change }
)
map(
  "n",
  "<leader>gt",
  with_gitsigns(function(gs)
    gs.toggle_current_line_blame()
  end),
  { desc = "Toggle blame", icon = git.blame }
)
map(
  "n",
  "<leader>gw",
  with_gitsigns(function(gs)
    gs.toggle_word_diff()
  end),
  { desc = "Toggle word diff", icon = git.change }
)

-----------------------------------------------------------
-- LAZYGIT
-----------------------------------------------------------
-- vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit UI" })
-- vim.keymap.set("n", "<leader>gG", "<cmd>LazyGitCurrentFile<cr>", { desc = "Current file git UI" })
-- vim.keymap.set("n", "<leader>gc", "<cmd>LazyGitConfig<cr>", { desc = "LazyGit config" })
-- vim.keymap.set("n", "<leader>gf", "<cmd>LazyGitFilter<cr>", { desc = "Git filter" })
-- vim.keymap.set("n", "<leader>gF", "<cmd>LazyGitFilterCurrentFile<cr>", { desc = "File git filter" })
--

-- Snacks Lazygit Keymaps
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit.open() end, { desc = "Open Lazygit" })
vim.keymap.set("n", "<leader>gl", function() Snacks.lazygit.log() end, { desc = "Lazygit Log (Project)" })
vim.keymap.set("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Log (Current File)" })

-- UI / Toggles
map("n", "<leader>ul", "<cmd>set list!<cr>", { desc = "Toggle list chars", icon = general.ui })
map("n", "<leader>ur", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative numbers", icon = general.ui })
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle wrap", icon = general.ui })
map("n", "<leader>uc", "<cmd>set cursorline!<cr>", { desc = "Toggle cursorline", icon = general.ui })

-- Terminal
map("n", "<leader>tt", "<cmd>split | terminal<cr>", { desc = "Terminal horizontal", icon = general.terminal })
map("n", "<leader>tv", "<cmd>vsplit | terminal<cr>", { desc = "Terminal vertical", icon = general.terminal })

-- rrent line down/up in Normal mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Move current line down/up in Insert mode
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })

-- Move visually selected blocks down/up
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-----------------------------------------------------------
-- INJECT ICONS INTO WHICH-KEY
-----------------------------------------------------------
-- This runs quietly in the background. Once Which-Key finishes loading,
-- it injects all the icons we secretly saved in `wk_specs` above.
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(args)
    if args.data == "which-key.nvim" then
      require("which-key").add(wk_specs)
    end
  end,
})

-----------------------------------------------------------
-- Treesitter textobjects
-----------------------------------------------------------
-- Select
map({ "x", "o" }, "am", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end, { desc = "Around function" })

map({ "x", "o" }, "im", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end, { desc = "Inside function" })

map({ "x", "o" }, "ac", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end, { desc = "Around class" })

map({ "x", "o" }, "ic", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end, { desc = "Inside class" })

map({ "x", "o" }, "as", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
end, { desc = "Around scope" })

-- Move
map({ "n", "x", "o" }, "]m", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function start" })

map({ "n", "x", "o" }, "[m", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function start" })

map({ "n", "x", "o" }, "]M", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end, { desc = "Next function end" })

map({ "n", "x", "o" }, "[M", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end, { desc = "Previous function end" })

map({ "n", "x", "o" }, "]]", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end, { desc = "Next class start" })

map({ "n", "x", "o" }, "[[", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end, { desc = "Previous class start" })

map({ "n", "x", "o" }, "]o", function()
  require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end, { desc = "Next loop" })

map({ "n", "x", "o" }, "[o", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end, { desc = "Previous loop" })

map({ "n", "x", "o" }, "]t", function()
  require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
end, { desc = "Next conditional" })

map({ "n", "x", "o" }, "[t", function()
  require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
end, { desc = "Previous conditional" })

map({ "n", "x", "o" }, "]s", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
end, { desc = "Next scope" })

map({ "n", "x", "o" }, "[s", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@local.scope", "locals")
end, { desc = "Previous scope" })

-- Swap parameters
map("n", "<leader>an", function()
  require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end, { desc = "Swap next parameter", icon = textobjects.swap_next })

map("n", "<leader>ap", function()
  require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
end, { desc = "Swap previous parameter", icon = textobjects.swap_prev })

-- Repeatable move
map({ "n", "x", "o" }, ";", function()
  require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_next()
end, { desc = "Repeat next move" })

map({ "n", "x", "o" }, ",", function()
  require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_previous()
end, { desc = "Repeat previous move" })
