return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,

  opts = function()
    local icons = require("core.icons")

    return {
      dashboard = {
        enabled = true,

        width = 60,
        row = nil,
        col = nil,
        pane_gap = 4,

        autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

        preset = {
          pick = nil,

          keys = {
            {
              icon = icons.general.explorer,
              key = "e",
              desc = "File Explorer",
              action = ":lua Snacks.explorer()",
            },
            {
              icon = icons.dashboard.find_file,
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            {
              icon = icons.dashboard.new_file,
              key = "n",
              desc = "New File",
              action = ":ene | startinsert",
            },
            {
              icon = icons.dashboard.find_text,
              key = "g",
              desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = icons.dashboard.recent_files,
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            {
              icon = icons.dashboard.config,
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
            },
            {
              icon = icons.dashboard.restore_session,
              key = "s",
              desc = "Restore Session",
              section = "session",
            },
            {
              icon = icons.dashboard.lazy,
              key = "L",
              desc = "Lazy",
              action = ":Lazy",
              enabled = package.loaded.lazy ~= nil,
            },
            {
              icon = icons.general.settings,
              key = "h",
              desc = "Check Health",
              action = ":checkhealth",
            },
            {
              icon = icons.dashboard.quit,
              key = "q",
              desc = "Quit",
              action = ":qa",
            },
          },

          header = [[
                                             
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████
]],
        },

        formats = {
          icon = function(item)
            if item.file and (item.icon == "file" or item.icon == "directory") then
              return Snacks.dashboard.icon(item.file, item.icon)
            end

            return {
              item.icon,
              width = 2,
              hl = "icon",
            }
          end,

          footer = {
            "%s",
            align = "center",
          },

          header = {
            "%s",
            align = "center",
          },

          file = function(item, ctx)
            local fname = vim.fn.fnamemodify(item.file, ":~")

            fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname

            if #fname > ctx.width then
              local dir = vim.fn.fnamemodify(fname, ":h")
              local file = vim.fn.fnamemodify(fname, ":t")

              if dir and file then
                file = file:sub(-(ctx.width - #dir - 2))
                fname = dir .. "/…" .. file
              end
            end

            local dir, file = fname:match("^(.*)/(.+)$")

            return dir and {
              { dir .. "/", hl = "dir" },
              { file,       hl = "file" },
            } or {
              { fname, hl = "file" },
            }
          end,
        },

        sections = {
          { section = "header" },
          { section = "keys",   gap = 1, padding = 1 },
          { section = "startup" },
        },
      },

      notifier = {
        enabled = true,
        timeout = 3000,
        width = { min = 40, max = 0.4 },
        height = { min = 1, max = 0.6 },
        margin = { top = 0, right = 1, bottom = 0 },
        padding = true,
        gap = 1,
        sort = { "level", "added" },
        level = vim.log.levels.TRACE,
        icons = {
          error = icons.diagnostics.error,
          warn = icons.diagnostics.warn,
          info = icons.diagnostics.info,
          debug = icons.general.bug,
          trace = icons.diagnostics.trace,
        },
        style = "compact",
        top_down = true,
        date_format = "%R",
        more_format = " " .. icons.ui.expand_expanded .. " %d lines ",
        refresh = 50,
      },

      indent = {
        enabled = true,
        char = "│", -- Standard subtle vertical bar
        only_scope = false,
        only_current = false,

        -- 🌈 Rainbow Indents: Cycles through highlight groups
        hl = {
          "SnacksIndent1",
          "SnacksIndent2",
          "SnacksIndent3",
          "SnacksIndent4",
          "SnacksIndent5",
          "SnacksIndent6",
          "SnacksIndent7",
          "SnacksIndent8",
        },

        -- 🎬 Smooth Animations (Requires Neovim 0.10+)
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          style = "out", -- Animates outwards from where your cursor is placed
          easing = "linear",
          duration = {
            step = 20,   -- ms per step
            total = 500, -- maximum duration
          },
        },

        -- 🎯 Active Scope (The current block you are inside)
        scope = {
          enabled = true,
          char = "┃", -- Thicker bar to easily spot the active scope
          underline = false,
          only_current = false,
        },

        -- 📦 Chunk Mode (Draws a beautiful bounding box around the active scope)
        chunk = {
          enabled = true,
          only_current = false,
          char = {
            corner_top = "╭", -- Smooth rounded corners at the top
            corner_bottom = "╰", -- Smooth rounded corners at the bottom
            horizontal = "─", -- Horizontal top/bottom lines
            vertical = "│", -- Vertical sides
            arrow = "►", -- Pointer to the exact line your cursor is on
          },
        },
      },

      picker = {
        enabled = true,
        prompt = " " .. icons.general.find .. " ",
        ui_select = true, -- Replaces vim.ui.select with a beautiful picker

        layout = {
          preset = "telescope", -- Standard, centered floating layout
        },

        formatters = {
          file = {
            filename_first = true, -- Puts the filename visually first, muting the folder path!
            truncate = "center",
          },
        },

        previewers = {
          diff = {
            style = "fancy", -- Uses multi-column line numbers & syntax highlighting for diffs
          },
        },

        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } }, -- Closes instantly on escape
            },
          },
        },

        icons = {
          ui = {
            selected = icons.ui.selection .. " ",
          },
          git = {
            added = icons.git.add,
            modified = icons.git.change,
            deleted = icons.git.delete,
          },
          diagnostics = {
            Error = icons.diagnostics.error,
            Warn = icons.diagnostics.warn,
            Hint = icons.diagnostics.hint,
            Info = icons.diagnostics.info,
          },
        },
        sources = {
          explorer = {
            layout = {
              preset = "sidebar",
              preview = false, -- Toggle with 'P' to keep the sidebar clean initially
            },
            diagnostics = true,
            git_status = true,
            hidden = false,
            ignored = true,
          },
        },
      },

      explorer = {
        replace_netrw = true,
        trash = true,
      },

      lazygit = {
        -- Enables automatic colorscheme integration and edit integration
        configure = true,

        -- Native Lazygit configuration merged into the YAML
        config = {
          os = {
            editPreset = "nvim-remote" -- Ensures files open in your current Nvim instance
          },
          gui = {
            nerdFontsVersion = "3", -- Essential for the best visual aesthetics (icons)
          },
        },

        -- Dynamic theme generation mapping Lazygit UI to Neovim Highlight Groups
        theme = {
          [241]                      = { fg = "Special" },
          activeBorderColor          = { fg = "MatchParen", bold = true },
          cherryPickedCommitBgColor  = { fg = "Identifier" },
          cherryPickedCommitFgColor  = { fg = "Function" },
          defaultFgColor             = { fg = "Normal" },
          inactiveBorderColor        = { fg = "FloatBorder" },
          optionsTextColor           = { fg = "Function" },
          searchingActiveBorderColor = { fg = "MatchParen", bold = true },
          selectedLineBgColor        = { bg = "Visual" },
          unstagedChangesColor       = { fg = "DiagnosticError" },
        },

        -- Window styling integration
        win = {
          style = "lazygit",
        },
      },

      image = {
        -- 1. FORMATS & PERFORMANCE
        force = false, -- Prevents UI breakage if terminal support is missing.
        formats = {
          "png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff",
          "heic", "avif", "mp4", "mov", "avi", "mkv", "webm",
          "pdf", "icns",
        }, -- Enables every single supported static and animated format.

        -- 2. INLINE DOCUMENT RENDERING
        doc = {
          enabled = true, -- Activates image rendering within supported filetypes.
          inline = true,  -- Prioritizes true inline rendering over floating windows for supported terminals[cite: 1].
          float = true,   -- Acts as a graceful fallback for environments lacking inline support[cite: 1].
          max_width = 80, -- Restricts massive images to maintain code readability[cite: 1].
          max_height = 40,

          -- AESTHETIC TWEAK: Hides the raw markdown/code when the image is rendered inline
          conceal = function(_, type)
            -- Expanding this beyond just math to conceal image tags as well for the cleanest look
            return type == "math" or type == "image"
          end,
        },

        -- 3. INTELLIGENT PATH RESOLUTION
        img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" }, -- Automatically searches all standard project directories for local images[cite: 1].

        -- 4. CLEAN BUFFER UI
        wo = {
          wrap = false,
          number = false,
          relativenumber = false,
          cursorcolumn = false,
          signcolumn = "no",
          foldcolumn = "0",
          list = false,
          spell = false,
          statuscolumn = "",
        }, -- Strips all Neovim UI clutter (like line numbers and gutters) from the image window for a pure viewing experience[cite: 1].

        -- 5. MATH EXPRESSION RENDERING
        math = {
          enabled = true,                                                          -- Turns on LaTeX and Typst formula rendering[cite: 1].
          latex = {
            font_size = "Large",                                                   -- Bumps up the font size for perfect readability against code[cite: 1].
            packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" }, -- Includes advanced math symbol packages[cite: 1].
          },
        },

        -- 6. UI ICONS
        icons = {
          math = "󰪚 ",
          chart = "󰄧 ",
          image = " ",
        }, -- Uses crisp Nerd Font icons to denote inline placements[cite: 1].
      },

      -- 7. FLOATING WINDOW STYLES
      styles = {
        snacks_image = {
          relative = "cursor",
          border = "rounded", -- Replaces the default border with a softer, aesthetic rounded border (assuming global standard Neovim borders are used)[cite: 1].
          focusable = false,  -- Prevents the cursor from accidentally jumping into the image buffer[cite: 1].
          backdrop = 60,      -- Adds a dimming effect to the background code to make the floating image pop[cite: 1].
          row = 1,
          col = 1,
        }
      }

    }
  end,
}
