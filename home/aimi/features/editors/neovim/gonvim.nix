{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = go-nvim;
      type = "lua";
      config = /* lua */ ''
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.go",
          callback = function()
           require('go.format').goimport()
          end,
          group = format_sync_grp,
        })
        require('go').setup()
      '';
    }
  ];
}
