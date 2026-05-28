return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = function()
    local icons = require("core.icons")
    local borders = require("core.borders")
 
    return {
      cmdline = {
        enabled = true,
        view = "cmdline_popup",

        format = {
          cmdline = {
            icon = icons.ui.selection,
          },

          search_down = {
            icon = icons.general.search,
          },

          search_up = {
            icon = icons.general.search,
          },

          filter = {
            icon = icons.general.filter,
          },

          lua = {
            icon = icons.filetypes.lua,
          },

          help = {
            icon = icons.general.help,
          },

          input = {
            view = "cmdline_input",
            icon = icons.editing.insert,
          },
        },
      },

      messages = {
        enabled = true,
        view = "mini",
        view_error = "mini",
        view_warn = "mini",
        view_history = "messages",
        view_search = "virtualtext",
      },

      popupmenu = {
        enabled = true,
        backend = "nui",

        kind_icons = {
          Text = icons.completion.text,
          Method = icons.completion.method,
          Function = icons.completion.function_,
          Constructor = icons.completion.constructor,
          Field = icons.completion.field,
          Variable = icons.completion.variable,
          Class = icons.completion.class,
          Interface = icons.completion.interface,
          Module = icons.completion.module,
          Property = icons.completion.property,
          Unit = icons.completion.unit,
          Value = icons.completion.value,
          Enum = icons.completion.enum,
          Keyword = icons.completion.keyword,
          Snippet = icons.completion.snippet,
          Color = icons.completion.color,
          File = icons.completion.file,
          Reference = icons.completion.reference,
          Folder = icons.completion.folder,
          EnumMember = icons.completion.enum_member,
          Constant = icons.completion.constant,
          Struct = icons.completion.struct,
          Event = icons.completion.event,
          Operator = icons.completion.operator,
          TypeParameter = icons.completion.type_parameter,
        },
      },

      notify = {
        enabled = false,
      },

      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },

        progress = {
          enabled = true,
          view = "mini",
        },

        signature = {
          enabled = true,
        },

        documentation = {
          view = "hover",

          opts = {
            border = borders.noice,
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },

            win_options = {
              concealcursor = "n",
              conceallevel = 3,
            },
          },
        },
      },

      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },

          opts = {
            skip = true,
          },
        },
      },

      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    }
  end,
  config = function(_, opts)
    require("noice").setup(opts)
  end,
}
