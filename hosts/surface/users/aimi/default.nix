{ config
, inputs
, outputs
, ...
}:

{
  imports = [
    ## de
    ./hyprland
    #./i3

    ## editor
    ../../../../resources/cli/user/editor

    ## shell
    ../../../../resources/cli/user/shell/zsh

    ## tmux
    ../../../../resources/cli/user/base
    ## tools
    ./tools

    ## nixpkgs config
    ../../../../resources/system/nixpkgs.nix

    ## gtk and qt theme
    ../../../../resources/desktop/base/system/theme.nix

    ## optional applications
    ../../../../resources/applications-optional

  ] ++ (builtins.attrValues outputs.homeManagerModules);

  home = {
    username = "aimi";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
