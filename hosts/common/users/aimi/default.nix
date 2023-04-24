{ pkgs, config, lib, outputs, ...}:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  # FIXME: Replace with your username
  users.users.aimi = {
    # TODO: You can set an initial password for your user.
    # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
    # Be sure to change it (using passwd) after rebooting!
    initialPassword = "aimi";
    isNormalUser = true;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtCi7o7AdRFMiV3qa3GBD7Qa2U/fFllRJfo4Mre9Z1XSyPQe5dAHd3CVwjI+8FcU48w2BIwKitU8JC32KGFm/VoRew0mg5YiBiTBKimISpzAvS+GUwGg86q0ZX/FyuQcuEHISOFueuBR9dZd2nB6TydlZDICuuypH/lXtUFarXicNhlwGozSX2kqWedeAnd3/iKfWIXu63u0BmHoAa050Zi2TqRwzE2OQ7AvKaDbaVqVXZc0KQ8azfM7IskOk6Vu34TwMK1CmCk1Rkp0OR9I7KZ/dx9tVAc73PTx0+fefUFMiNfpdihcmYRdlRkN/QLwgrVLu/hwa4ycI5mNCIVMFi3cYF5aY7xYbR9Igi52NFTEBN0wtInajocU6KGY86oQayI6sPNFhrPFZApV0bxWjHprZfOGw+OoJTqL0BElyaqzoSbFRvtNgWgJD33UVgBJrSIduLfwtTFGPOQY5Jg2Lux+UnSQzXBRLr4DBZ1Tyynv6jUsRWHPIA2nS3GXSX5GXlhBSQuEgTBDWfWwtBoR1ljWikDb/qykJbRBrMlVunLl1/XhXY57Kjojei193sIQ7VZJA4oZJMpKOBQBIA/6mDtffZpJGZMbUmq+fr4pQddZn2J7KZIOURoWObW1n2y7soWCMX2CoZljup/seM9NplE3HN1D0OCVFT1+k1A1MuEQ== aimi@taiga"
    ];
    # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
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

  # FIXME: zsh config should not be here
  programs.zsh.enable = true;

  home-manager.users.aimi = import home/${config.networking.hostName}.nix;

   ## Whether to enable GeoClue 2 daemon, a DBus service that provides location information for accessing.
   #services.geoclue2.enable = true;
   ## For geoclue2
   #services.avahi.enable = true;
}
