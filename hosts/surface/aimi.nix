{ pkgs
, config
, inputs
, outputs
, ...
}:

let 
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

in 
{
  home-manager.users.aimi = import ./users/aimi;

  ############# user config ###################
  programs.zsh.enable = true;

  # users are all configured by config file!
  # don't allow mutation of users outside of the config
  users.mutableUsers = false;

  users.users.aimi = {
    initialPassword = "aimi";
    isNormalUser = true;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtCi7o7AdRFMiV3qa3GBD7Qa2U/fFllRJfo4Mre9Z1XSyPQe5dAHd3CVwjI+8FcU48w2BIwKitU8JC32KGFm/VoRew0mg5YiBiTBKimISpzAvS+GUwGg86q0ZX/FyuQcuEHISOFueuBR9dZd2nB6TydlZDICuuypH/lXtUFarXicNhlwGozSX2kqWedeAnd3/iKfWIXu63u0BmHoAa050Zi2TqRwzE2OQ7AvKaDbaVqVXZc0KQ8azfM7IskOk6Vu34TwMK1CmCk1Rkp0OR9I7KZ/dx9tVAc73PTx0+fefUFMiNfpdihcmYRdlRkN/QLwgrVLu/hwa4ycI5mNCIVMFi3cYF5aY7xYbR9Igi52NFTEBN0wtInajocU6KGY86oQayI6sPNFhrPFZApV0bxWjHprZfOGw+OoJTqL0BElyaqzoSbFRvtNgWgJD33UVgBJrSIduLfwtTFGPOQY5Jg2Lux+UnSQzXBRLr4DBZ1Tyynv6jUsRWHPIA2nS3GXSX5GXlhBSQuEgTBDWfWwtBoR1ljWikDb/qykJbRBrMlVunLl1/XhXY57Kjojei193sIQ7VZJA4oZJMpKOBQBIA/6mDtffZpJGZMbUmq+fr4pQddZn2J7KZIOURoWObW1n2y7soWCMX2CoZljup/seM9NplE3HN1D0OCVFT1+k1A1MuEQ== aimi@taiga"
    ];
    extraGroups = [ 
      "wheel" 
      "docker"
      "networkmanager"
    ] ++ ifTheyExist [
      "plocate"
      "audio"
    ];

    packages = [ pkgs.home-manager ];
  };



  ################# persistence ################
  environment.persistence."/persist".users.aimi = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"

      { directory = ".gnupg"; mode = "0700"; }
      { directory = ".ssh"; mode = "0700"; }

      ## XDG_DATA_HOME
      ".local/share/Steam"
      ".local/share/fcitx5"
      #{
      #  directory = ".local/share/Steam";
      #  method = "symlink";
      #}

      # workspace
      "workspace"

      # nixos config
      "nix-config"

      # dot files and dirs
      ".cache"
      ".mozilla"

      ## config dir
      ".config/zsh" 
    ];
    files = [
      "hypr.sh"

      ".zshrc"
      ".zhistory"
    ];
  };
}
