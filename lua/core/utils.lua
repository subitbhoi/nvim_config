local M = {}

-----------------------------------------------------------
-- Safe require
-----------------------------------------------------------

function M.safe_require(module)
  local ok, lib = pcall(require, module)
  if ok then
    return lib
  end
  return nil
end

-----------------------------------------------------------
-- Table helpers
-----------------------------------------------------------

function M.is_empty(tbl)
  return tbl == nil or next(tbl) == nil
end

function M.merge(...)
  return vim.tbl_deep_extend("force", ...)
end

-----------------------------------------------------------
-- Filesystem helpers
-----------------------------------------------------------

function M.path_exists(path)
  return vim.uv.fs_stat(path) ~= nil
end

function M.is_dir(path)
  local stat = vim.uv.fs_stat(path)
  return stat ~= nil and stat.type == "directory"
end

function M.is_file(path)
  local stat = vim.uv.fs_stat(path)
  return stat ~= nil and stat.type == "file"
end

-----------------------------------------------------------
-- Process / executable helpers
-----------------------------------------------------------

function M.has(cmd)
  return vim.fn.executable(cmd) == 1
end

-----------------------------------------------------------
-- Buffer helpers
-----------------------------------------------------------

function M.get_buf_name(bufnr)
  bufnr = bufnr or 0
  return vim.api.nvim_buf_get_name(bufnr)
end

function M.is_normal_buffer(bufnr)
  bufnr = bufnr or 0
  local bt = vim.bo[bufnr].buftype
  return bt == ""
end

function M.is_large_file(bufnr, max_filesize)
  bufnr = bufnr or 0
  max_filesize = max_filesize or 1024 * 1024

  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return false
  end

  local stat = vim.uv.fs_stat(name)
  if not stat then
    return false
  end

  return stat.size > max_filesize
end

-----------------------------------------------------------
-- Keymap helper
-----------------------------------------------------------

function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  opts.noremap = opts.noremap ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
