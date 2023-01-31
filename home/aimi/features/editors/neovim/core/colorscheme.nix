{ pkgs, ... }:
{
  #programs.neovim.plugins = with pkgs.vimPlugins; [
  #  {
  #    plugin = papercolor-theme;
  #    type = "lua";
  #    config = /* lua */ ''
  #      vim.cmd("colorscheme PaperColor")
  #    '';
  #  }
  #];

  home.packages = with pkgs; [ darkplus ];
  programs.neovim.extraConfig = {
    lua = /* lua */ ''
      vim.cmd("colorscheme darkplus")
    '';
  };
}
