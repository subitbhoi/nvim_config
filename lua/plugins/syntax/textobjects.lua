return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  event = "VeryLazy",
  init = function()
    vim.g.no_plugin_maps = true
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local ts_select = require("nvim-treesitter-textobjects.select")
    local ts_move = require("nvim-treesitter-textobjects.move")
    local ts_swap = require("nvim-treesitter-textobjects.swap")
    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "<c-v>",
        },
        include_surrounding_whitespace = false,
      },
      move = {
        set_jumps = true,
      },
    })

    local function map(mode, lhs, rhs, desc, opts)
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", {
        silent = true,
        desc = desc,
      }, opts or {}))
    end

    -- Select
    map({ "x", "o" }, "am", function()
      ts_select.select_textobject("@function.outer", "textobjects")
    end, "Around function")

    map({ "x", "o" }, "im", function()
      ts_select.select_textobject("@function.inner", "textobjects")
    end, "Inside function")

    map({ "x", "o" }, "ac", function()
      ts_select.select_textobject("@class.outer", "textobjects")
    end, "Around class")

    map({ "x", "o" }, "ic", function()
      ts_select.select_textobject("@class.inner", "textobjects")
    end, "Inside class")

    map({ "x", "o" }, "as", function()
      ts_select.select_textobject("@local.scope", "locals")
    end, "Around scope")

    -- Move
    map({ "n", "x", "o" }, "]m", function()
      ts_move.goto_next_start("@function.outer", "textobjects")
    end, "Next function start")

    map({ "n", "x", "o" }, "[m", function()
      ts_move.goto_previous_start("@function.outer", "textobjects")
    end, "Previous function start")

    map({ "n", "x", "o" }, "]M", function()
      ts_move.goto_next_end("@function.outer", "textobjects")
    end, "Next function end")

    map({ "n", "x", "o" }, "[M", function()
      ts_move.goto_previous_end("@function.outer", "textobjects")
    end, "Previous function end")

    map({ "n", "x", "o" }, "]]", function()
      ts_move.goto_next_start("@class.outer", "textobjects")
    end, "Next class start")

    map({ "n", "x", "o" }, "[[", function()
      ts_move.goto_previous_start("@class.outer", "textobjects")
    end, "Previous class start")

    map({ "n", "x", "o" }, "]o", function()
      ts_move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
    end, "Next loop")

    map({ "n", "x", "o" }, "[o", function()
      ts_move.goto_previous_start({ "@loop.inner", "@loop.outer" }, "textobjects")
    end, "Previous loop")

    map({ "n", "x", "o" }, "]t", function()
      ts_move.goto_next("@conditional.outer", "textobjects")
    end, "Next conditional")

    map({ "n", "x", "o" }, "[t", function()
      ts_move.goto_previous("@conditional.outer", "textobjects")
    end, "Previous conditional")

    map({ "n", "x", "o" }, "]s", function()
      ts_move.goto_next_start("@local.scope", "locals")
    end, "Next scope")

    map({ "n", "x", "o" }, "[s", function()
      ts_move.goto_previous_start("@local.scope", "locals")
    end, "Previous scope")

    -- Swap parameters
    map("n", "<leader>a", function()
      ts_swap.swap_next("@parameter.inner")
    end, "Swap next parameter")

    map("n", "<leader>A", function()
      ts_swap.swap_previous("@parameter.outer")
    end, "Swap previous parameter")

    -- Repeatable move
    map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, "Repeat next move")
    map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, "Repeat previous move")
  end,
}
