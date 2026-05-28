return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = {
    "Neotree",
    "NeotreeShow",
    "NeotreeToggle",
    "NeotreeFocus",
    "NeotreeReveal",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    local icons = require("core.icons")
    local borders = require("core.borders")

    local git = icons.git
    local nav = icons.navigation
    local ui = icons.ui

    return {
      close_if_last_window = true,
      popup_border_style = borders.neo_tree,
      enable_git_status = true,
      enable_diagnostics = true,
      use_libuv_file_watcher = true,

      default_component_configs = {
        container = {
          enable_character_fade = true,
        },

        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = ui.vertical_bar,
          last_indent_marker = ui.vertical_bar,
          highlight = "NeoTreeIndentMarker",
          with_expanders = true,
          expander_collapsed = ui.expand_collapsed,
          expander_expanded = ui.expand_expanded,
          expander_highlight = "NeoTreeExpander",
        },

        icon = {
          folder_closed = nav.folder,
          folder_open = nav.folder_open,
          folder_empty = nav.folder_empty,
          default = nav.file,
          highlight = "NeoTreeFileIcon",
          use_filtered_colors = true,

          provider = function(icon, node, _)
            if node.type == "file" or node.type == "terminal" then
              local ok, devicons = pcall(require, "nvim-web-devicons")
              if ok then
                local name = node.type == "terminal" and "terminal" or node.name
                local devicon, hl = devicons.get_icon(name)
                icon.text = devicon or icon.text
                icon.highlight = hl or icon.highlight
              end
            end
          end,
        },

        modified = {
          symbol = git.change,
          highlight = "NeoTreeModified",
        },

        name = {
          trailing_slash = false,
          use_filtered_colors = true,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },

        git_status = {
          symbols = {
            added = git.add,
            modified = git.change,
            deleted = git.delete,
            renamed = git.rename,
            untracked = git.untracked,
            ignored = git.ignored,
            unstaged = git.unstaged,
            staged = git.staged,
            conflict = git.conflict,
          },
        },
      },

      window = {
        position = "left",
        width = 36,

        mapping_options = {
          noremap = true,
          nowait = true,
        },

        mappings = {
          ["<space>"] = "toggle_node",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",

          ["o"] = {
            "show_help",
            nowait = false,
            config = {
              title = "Order by",
              prefix_key = "o",
            },
          },

          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["og"] = { "order_by_git_status", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        },
      },

      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },

        hijack_netrw_behavior = "open_default",

        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true,

          never_show = {
            ".DS_Store",
            "Thumbs.db",
          },
        },
      },

      buffers = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },

        group_empty_dirs = true,
        show_unloaded = true,
      },

      git_status = {
        window = {
          position = "float",
        },
      },
    }
  end,
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
}
