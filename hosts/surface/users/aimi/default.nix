{ config
, outputs
, ...
}:

{
  imports = [
    # de
    ./hyprland
    #./i3

    # editor
    ../../../../resources/cli/editor

    # shell
    ../../../../resources/cli/shell/zsh
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
