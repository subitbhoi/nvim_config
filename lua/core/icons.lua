local M = {}

M.ui = {
  separator = "│",
  vertical_bar = "│",
  vertical_bar_thin = "▏",
  rounded_left = "╭",
  rounded_right = "╮",
  rounded_bottom_left = "╰",
  rounded_bottom_right = "╯",
  horizontal = "─",
  horizontal_thin = "╌",
  expand_collapsed = "",
  expand_expanded = "",
  group = "󰙅",
  split = "󰖲",
  selection = "",
}

M.general = {
  close     = "󰅖",
  save      = "󰆓",
  find      = "",
  find_file = "󰱼",
  files     = "󰈔",
  recent    = "󰋚",
  command   = "󰘳",
  keymap    = "󰌌",
  help      = "󰋖",
  terminal  = "󰆍",
  settings  = "󰒓",
  ui        = "󰙅",
  selection = "󰘥",
  search    = "",
  buffer    = "󰓩",
  mode      = "󰀘",
  readonly  = "󰌾",
  filter    = "",
  bug       = "",
  clipboard = "󰅍",
  exit      = "󰌑",
  clear     = "󰅶",
  disable   = "󱎭",
}

M.editing = {
  delete = "󰅖",
  insert = "󰦪",
  replace = "󰛔",
  select = "󰒅",
  comment = "󰅺",
  format = "󰒓",
  pair = "󰆴",
  tag = "󰗀",
}

M.navigation = {
  explorer = "󰉋",
  folder = "󰉋",
  folder_open = "󰝰",
  folder_empty = "󰉖",
  file = "󰈔",
  search = "󰇉",
  buffer = "󰓩",
  source = "󰒓",
}

M.git = {
  git = "󰊢",
  branch = "",
  add = "",
  change = "",
  delete = "",
  topdelete = "󰍵",
  rename = "󰁕",
  untracked = "",
  ignored = "",
  staged = "",
  unstaged = "󰄱",
  conflict = "",
  blame = "󰊢",
}

M.diagnostics = {
  error = "",
  warn = "",
  info = "",
  hint = "",
  trace = "",
  diagnostic = "󰒡",
}

M.lsp = {
  server       = "󰒓",
  code_action  = "󰌵",
  hover        = "󰞋",
  rename       = "󰑕",
  definition   = "󰒕",
  implementation = "󰡱",
  references   = "󰈇",
  formatting   = "󰉢",
}

M.completion = {
  text = "󰉿",
  method = "󰆧",
  function_ = "󰊕",
  constructor = "",
  field = "󰜢",
  variable = "󰂡",
  class = "󰠱",
  interface = "",
  module = "󰏗",
  property = "󰜢",
  unit = "󰑭",
  value = "󰎠",
  enum = "",
  keyword = "󰌋",
  snippet = "󰘍",
  color = "󰏘",
  file = "󰈔",
  reference = "󰈇",
  folder = "󰉋",
  enum_member = "",
  constant = "󰏿",
  struct = "󰙅",
  event = "",
  operator = "󰆕",
  type_parameter = "󰊄",
}

M.filetypes = {
  html = "󰌝",
  css = "󰌜",
  javascript = "󰌞",
  typescript = "󰛦",
  jsx = "󰜈",
  tsx = "󰛦",
  json = "󰘦",
  yaml = "󰰂",
  markdown = "󰍔",
  lua = "󰢱",
  shell = "󰆍",
}

M.dev = {
  react = "󰞺",
  nextjs = "󰇄",
  nodejs = "󰎙",
  tailwind = "󱏿",
  docker = "󰡨",
  package = "󰏗",
  test = "󰙨",
}

M.mason = {
  package_installed = "",
  package_pending = "",
  package_uninstalled = "",
}

M.dashboard = {
  find_file = "",
  new_file = "",
  find_text = "",
  recent_files = "",
  config = "",
  restore_session = "",
  lazy = "󰒲",
  quit = "",
}

return M
