local M = {}

M.completion = {
  class = "󰠱",
  color = "󰏘",
  constant = "󰏿",
  constructor = "",
  enum = "",
  enum_member = "",
  event = "",
  field = "󰜢",
  file = "󰈔",
  folder = "󰉋",
  function_ = "󰊕",
  interface = "",
  keyword = "󰌋",
  method = "󰆧",
  module = "󰏗",
  operator = "󰆕",
  property = "󰜢",
  reference = "󰈇",
  snippet = "󰘍",
  struct = "󰙅",
  text = "󰉿",
  type_parameter = "󰊄",
  unit = "󰑭",
  value = "󰎠",
  variable = "󰂡",
}

M.dashboard = {
  config = "",
  find_file = "",
  find_text = "",
  lazy = "󰒲",
  new_file = "",
  quit = "",
  recent_files = "",
  restore_session = "",
}

M.dev = {
  docker = "󰡨",
  nextjs = "󰇄",
  nodejs = "󰎙",
  package = "󰏗",
  react = "󰞺",
  tailwind = "󱏿",
  test = "󰙨",
}

M.diagnostics = {
  diagnostic = "󰒡",
  error = "",
  hint = "",
  info = "",
  trace = "",
  warn = "",
}

M.editing = {
  comment = "󰅺",
  delete = "󰆴",
  delete_line = "",
  format = "󰒓",
  insert = "󰦪",
  pair = "󰆴",
  pencil = "󰑕",
  replace = "󰛔",
  select = "󰒅",
  tag = "󰗀",
}

M.filetypes = {
  css = "󰌜",
  html = "󰌝",
  javascript = "󰌞",
  json = "󰘦",
  jsx = "󰜈",
  lua = "󰢱",
  markdown = "󰍔",
  shell = "󰆍",
  tsx = "󰛦",
  typescript = "󰛦",
  yaml = "󰰂",
}

M.general = {
  buffer = "",
  bug = "",
  clear = "󰅶",
  clipboard = "󰅍",
  clipboardcopy = "󱉥",
  close = "󰈆",
  close_buffer = "󰅗",
  code = "󰘳",
  command = "",
  disable = "󱎭",
  exit = "󰌑",
  files = "󰈔",
  filter = "",
  find = "",
  find_file = "󰱼",
  help = "󰋖",
  keymap = "󰌌",
  live_grep = "󰛔",
  mode = "󰀘",
  readonly = "󰌾",
  recent = "󰋚",
  save = "󰆓",
  search = "",
  selection = "󰘥",
  settings = "󰒓",
  terminal = "󰆍",
  theme = "",
  ui = "",
}

M.git = {
  add = "",
  blame = "",
  branch = "",
  change = "",
  conflict = "",
  delete = "",
  git = "󰊢",
  ignored = "",
  next_hunk = "󰶻",
  reset = "",
  reset_hunk = "󱓍",
  reset_buffer = "󰗂",
  preview_hunk = "",
  previous_hunk = "󰶺",
  rename = "󰁕",
  staged = "",
  topdelete = "󰍵",
  unstaged = "󰄱",
  untracked = "",
}

M.lsp = {
  code_action = "󰌵",
  definition = "󰒕",
  formatting = "󰉢",
  hover = "󰞋",
  implementation = "󰡱",
  references = "󰈇",
  rename = "󰑕",
  server = "󰒓",
}

M.mason = {
  package_installed = "",
  package_pending = "",
  package_uninstalled = "",
}

M.navigation = {
  buffer = "󰓩",
  buffer_list = "",
  buffer_previous = "",
  buffer_next = "",
  explorer = "",
  explorer_tree = "",
  file = "󰈔",
  folder = "󰉋",
  folder_empty = "󰉖",
  folder_open = "󰝰",
  search = "󰇉",
  source = "󰒓",
}

M.textobjects = {
  swap = "󰯍",
  swap_next = "󰔰",
  swap_prev = "󰶢",
}

M.ui = {
  expand_collapsed = "",
  expand_expanded = "",
  group = "󰙅",
  horizontal = "─",
  horizontal_thin = "╌",
  rounded_bottom_left = "╰",
  rounded_bottom_right = "╯",
  rounded_left = "╭",
  rounded_right = "╮",
  selection = "",
  separator = "│",
  split = "󱤗",
  vertical_bar = "│",
  vertical_bar_thin = "▏",
}

M.whichkey = {
  buffer = "",
  code = "",
  git = "",
  lsp = "󰰌",
  search = "",
  split = "󰯌",
  terminal = "",
  ui = "",
}

return M
