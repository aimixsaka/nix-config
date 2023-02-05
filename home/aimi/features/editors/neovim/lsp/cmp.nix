{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    #cmp-cmdline
    # nvim-cmp source for neovim Lua API.
    cmp-nvim-lua
    
    # snip
    luasnip
    cmp_luasnip
    friendly-snippets

    # lspkind (vs-code like icons for autocompletion)
    lspkind-nvim
    {
      plugin = nvim-cmp;
      type = "lua";
      config = /* lua */ ''
        -----------------------------------------------
        --- most important place for autocompletion ---
        -----------------------------------------------
        local cmp_status_ok, cmp = pcall(require, "cmp")
        if not cmp_status_ok then
          error("Load [cmp] Failed!")
          return
        end
        
        local luasnip_status_ok, luasnip = pcall(require, "luasnip")
        if not luasnip_status_ok then
          error("Load [luasnip] Failed!")
          return
        end
        
        local lspkind_status, lspkind = pcall(require, "lspkind")
        if not lspkind_status then
          error("Load [lspking] Failed!")
          return
        end
        
        -- use existing vs-code style snippets from friendly-snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        -- add some snippets to luasnip from friendly-snippets
        require'luasnip'.filetype_extend("go", {"go"})
        require'luasnip'.filetype_extend("c", {"c"})
        require'luasnip'.filetype_extend("cpp", {"cpp"})
        require'luasnip'.filetype_extend("rust", {"rust"})
        require'luasnip'.filetype_extend("html", {"html"})


        -- completeopt, for cmp, else there will have two path completion
        vim.opt.completeopt = { "menu", "menuone", "noselect" }
      
        
        cmp.setup({
          -- cmp_luasnip
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },

          mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
            ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
            ["<C-y>"] = cmp.mapping.scroll_docs(-4),
            ["<C-e>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),     -- show completion suggestions
            -- ["<C-a>"] = cmp.mapping.abort(),            -- close completion window
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end,
          }),

          -- sources for autocompletion
          sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
            -- { name = 'vsnip' }, -- For vsnip users.
            { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
            { name = 'buffer' },
            { name = 'path' },
          },
          
          -- configure lspkind for vs-code like icons
          formatting = {
            format = lspkind.cmp_format({
              maxwidth = 50,
              ellipsis_char = "...",
            }),
          },


          -- set window appearence
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          experimental = {
            ghost_text = true,
          },
        })
        
        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'path' },
            -- { name = 'cmdline' }
          }
        })
      '';
    }
  ];
}
