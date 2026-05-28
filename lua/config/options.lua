local opt = vim.opt

-----------------------------------------------------------
-- General
-----------------------------------------------------------

opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.autoread = true
opt.confirm = true

-----------------------------------------------------------
-- Appearance
-----------------------------------------------------------

opt.termguicolors = true
opt.signcolumn = "yes"
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.showmode = false
opt.laststatus = 3
opt.pumheight = 10
opt.cmdheight = 0
opt.conceallevel = 2

-----------------------------------------------------------
-- Indentation
-----------------------------------------------------------

opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

-----------------------------------------------------------
-- Search
-----------------------------------------------------------

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-----------------------------------------------------------
-- Splits
-----------------------------------------------------------

opt.splitbelow = true
opt.splitright = true

-----------------------------------------------------------
-- Folding
-----------------------------------------------------------

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-----------------------------------------------------------
-- Completion
-----------------------------------------------------------

opt.completeopt = {
  "menu",
  "menuone",
  "noselect",
}

-----------------------------------------------------------
-- Invisible Characters
-----------------------------------------------------------

opt.list = true
opt.listchars = {
  tab = "󰌒 ",
  trail = "·",
  nbsp = "␣",
}

-----------------------------------------------------------
-- Performance
-----------------------------------------------------------

opt.lazyredraw = false
opt.synmaxcol = 240

-----------------------------------------------------------
-- File Behavior
-----------------------------------------------------------

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-----------------------------------------------------------
-- Better Markdown Experience
-----------------------------------------------------------

opt.breakindent = true
opt.linebreak = true

-----------------------------------------------------------
-- Global Variables
-----------------------------------------------------------

vim.g.have_nerd_font = true
