{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = /* lua */ ''
        -- cmp_nvim_lsp and lspconfig
        local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if not status_cmp_ok then
          error("Load [cmp_nvim_lsp] Failed!")
          return
        end

	    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
          if not lspconfig_status_ok then
	    error("Load [lspconfig] Failed!")
          return
        end

        function add_lsp(binary, server, conf_opts)
          local opts = {
            capabilities = cmp_nvim_lsp.default_capabilities()
          }
          options = vim.tbl_deep_extend("force", conf_opts, opts)
          if vim.fn.executable(binary) == 1 then server.setup(options) end
        end

        add_lsp("bash-language-server", lspconfig.bashls, {})
        add_lsp("clangd", lspconfig.clangd, {})
        add_lsp("nil", lspconfig.nil_ls, {})
        add_lsp("pyright", lspconfig.pyright, {})
        add_lsp("gopls", lspconfig.gopls, {})
        add_lsp("rnix-lsp", lspconfig.rnix, {})

        add_lsp("lua-language-server", lspconfig.sumneko_lua, {
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                -- library = {
                --   "/nix/store/7nhgzslbhhg1f53r8y36pb7gpc0q2d3z-neovim-0.8.3/share/nvim/runtime/lua", 
                --   "/nix/store/7nhgzslbhhg1f53r8y36pb7gpc0q2d3z-neovim-0.8.3/share/nvim/runtime/lua/vim",
                --   "/nix/store/7nhgzslbhhg1f53r8y36pb7gpc0q2d3z-neovim-0.8.3/share/nvim/runtime/lua/vim/lsp",
                -- },
                library = vim.api.nvim_get_runtime_file("", true),
              },
            },
          },
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

    ## Lsp Server use pkgs
  home.packages = with pkgs; [
    gopls
    rnix-lsp
    # use rust nightly to supply
    #rust-analyzer
    lua-language-server

    ## Lsp Server use pkgs.nodePackages
    nodePackages.bash-language-server
    nodePackages.pyright
  ];
}
