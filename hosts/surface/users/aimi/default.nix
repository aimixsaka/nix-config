{ config
, inputs
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

    # tools
    ../../../../resources/cli/tools

    # persist
    inputs.impermanence.nixosModules.home-manager.impermanence
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  home = {
    username = "aimi";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";


  ################# persistence ################
  home.persistence."/nix/persist/home/aimi" = {
	directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ## it seems mode in home-manager modules not implemented yet?
      #{ directory = ".gnupg"; mode = "0700"; }
      #{ directory = ".ssh"; mode = "0700"; }
      ".gnupg"
      ".ssh" 
      ## XDG_DATA_HOME
	  ".local/share/Steam"
      ".local/share/fcitx5"
      #{
      #  directory = ".local/share/Steam";
      #  method = "symlink";
      #}

      # nixos config
      "nix-config"

      ## config dir
      ".config/zsh" 
    ];
    files = [
      ## also not implemented !
      #{ file = "hypr.sh"; mode = "0755"; }
      "hypr.sh"
    ];

    allowOther = true;
  };
}
