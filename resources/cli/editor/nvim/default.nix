{ 
  pkgs,
  inputs,
  ...
}:

{
  #xdg.configFile."nvim".source = inputs.mynvim;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
