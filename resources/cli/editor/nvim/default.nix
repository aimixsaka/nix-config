{ 
  pkgs,
  inputs,
  config,
  ...
}:

{
  # personal symlink managed by home-manaber
  #xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/${config.home.username}/nix-config/resources/cli/editor/nvim/myconfig";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
