{ pkgs
, config
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
}
