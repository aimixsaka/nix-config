{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # Completions
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
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
        
        -- load friendly-snippets
        require("luasnip/loaders/from_vscode").lazy_load()
        vim.opt.completeopt = "menu,menuone,noselect"
        
        cmp.setup({
            snippet = {
                expand = function(args)
                luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),     -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(),            -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            -- sources for autocompletion
            sources = cmp.config.sources({
                { name = "nvim_lsp" },                      -- lsp
                { name = "luasnip" },                       -- snippets
                { name = "buffer" },                        -- text within current buffer
                { name = "path" },                          -- file system paths
            }),
            -- configure lspkind for vs-code like icons
            formatting = {
                format = lspkind.cmp_format({
                  maxwidth = 50,
                  ellipsis_char = "...",
                }),
            },
            --- ??? ---
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
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })
      '';
    }
  ];
}
