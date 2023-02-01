{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # LspSaga
    cmp-nvim-lsp

    lspsaga-nvim-original
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = /* lua */ ''
        -- LspSaga 
	    local status_saga_ok, lspsaga = pcall(require, "lspsaga")
	    if not status_saga_ok then
	      error("Load [lspsaga] Failed!")
	      return
	    end
        lspsaga.setup({})

        local M = {}     

        local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if not status_cmp_ok then
          error("Load [cmp_nvim_lsp] Failed!")
          return
        end

        --- ??? ---
        -- used to enable autocompletion (assign to every lsp server config)
        M.capabilities = cmp_nvim_lsp.default_capabilities()

        function lsp_keymaps(bufnr)
          local opts = { noremap = true, silent = true }
          local keymap = vim.api.nvim_buf_set_keymap
          
          -- Lspsaga keybinds
          keymap(bufnr, "n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)                       -- show definition, references
          keymap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)            -- got to declaration
          keymap(bufnr, "n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)                  -- see definition and make edits in window
          keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)         -- go to implementation
          keymap(bufnr, "n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)              -- see available code actions
          keymap(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)                   -- smart rename
          keymap(bufnr, "n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)     -- show  diagnostics for line
          keymap(bufnr, "n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)   -- show diagnostics for cursor
          keymap(bufnr, "n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)             -- jump to previous diagnostic in buffer
          keymap(bufnr, "n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)             -- jump to next diagnostic in buffer
          keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)                         -- show documentation for what is under cursor
          keymap(bufnr, "n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)                   -- see outline on right hand side
        end

        M.on_attach = function(client, bufnr)
          --- ??? ---
          if client.name == "tsserver" then
        	   client.server_capabilities.documentFormattingProvider = false
        	 end
        	 if client.name == "sumneko_lua" then
        	   client.server_capabilities.documentFormattingProvider = false
        	 end
        
          lsp_keymaps(bufnr)
        
          local status_ok, illuminate = pcall(require, "illuminate")
          if not status_ok then
            error("Load [illuminate] Failed")
            return
          end

          illuminate.on_attach(client)
        end


        -- Lspconfig
	    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
          if not lspconfig_status_ok then
	    error("Load [lspconfig] Failed")
          return
        end

        function add_lsp(binary, server, conf_opts)
          local opts = {
            on_attach = M.on_attach,
            capabilities = M.capabilities,
          }
          options = vim.tbl_deep_extend("force", conf_opts, opts)
          if vim.fn.executable(binary) == 1 then server.setup(options) end
        end

        add_lsp("bash-language-server", lspconfig.bashls, {})
        add_lsp("clangd", lspconfig.clangd, {})
        add_lsp("nil", lspconfig.nil_ls, {})
        add_lsp("pyright", lspconfig.pyright, {})
        add_lsp("gopls", lspconfig.gopls, {})
        add_lsp("rnix", lspconfig.rnix, {})

        add_lsp("lua-lsp", lspconfig.sumneko_lua, {
          cmd = { "lua-lsp" }
        })
      '';
    }
    {
      plugin = rust-tools-nvim;
      type = "lua";
      config = /* lua */ ''
        local rust_tools = require('rust-tools')
        if vim.fn.executable("rust-analyzer") == 1 then
          rust_tools.setup{ tools = { autoSetHints = true } }
        end
      '';
    }
  ];
}
