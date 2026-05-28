local M = {}

-----------------------------------------------------------
-- Border presets
-----------------------------------------------------------

M.rounded_telescope = {
   "─",
  "│",
  "─",
  "│",
  "╭",
  "╮",
  "╯",
  "╰",
}

M.rounded = {
  "╭",
  "─",
  "╮",
  "│",
  "╯",
  "─",
  "╰",
  "│",
}

M.single = {
 "─", -- Top
  "│", -- Right
  "─", -- Bottom
  "│", -- Left
  "┌", -- TopLeft
  "┐", -- TopRight
  "┘", -- BottomRight
  "└", -- BottomLeft
}

M.double = {
  "═", 
  "║", 
  "═", 
  "║", 
  "╔", 
  "╗", 
  "╝",
  "╚", 
}

M.minimal = {
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
}

M.none = M.minimal

-----------------------------------------------------------
-- Common aliases
-----------------------------------------------------------

M.default = M.rounded
M.popup = M.rounded
M.float = M.rounded
M.lsp = M.rounded
M.noice = M.rounded
M.telescope = M.rounded_telescope
M.neo_tree = M.rounded
M.which_key = M.rounded
M.notify = M.rounded

-----------------------------------------------------------
-- Access helper
-----------------------------------------------------------

function M.get(name)
  return M[name] or M.default
end

return M
