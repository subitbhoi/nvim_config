return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local icons = require("core.icons")
    local borders = require("core.borders")

    local kind_icons = {
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
    }

    local source_icons = {
      nvim_lsp = icons.lsp.server,
      luasnip = icons.completion.snippet,
      buffer = icons.navigation.buffer,
      path = icons.navigation.folder,
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      completion = {
        completeopt = "menu,menuone,noselect",
      },

      window = {
        completion = cmp.config.window.bordered({
          border = borders.rounded,
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          border = borders.rounded,
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
        }),
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        ["<CR>"] = cmp.mapping.confirm({
          select = true,
          behavior = cmp.ConfirmBehavior.Replace,
        }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          item.kind = string.format("%s %s", kind_icons[item.kind] or "󰞷", item.kind)
          item.menu = string.format("[%s]", source_icons[entry.source.name] or entry.source.name)
          return item
        end,
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
    })
  end,
}
