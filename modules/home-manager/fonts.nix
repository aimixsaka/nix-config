{ lib, config, ... }:
with lib;

let
  cfg = fonts.fontconfig.userConfig;
in {
  options = {
      fonts.fontconfig.userConfig = mkOption {
        type = types.lines;
        default = '''';
        description = ''
          fontconfig user level config
        '';
      };
    };
  };

  config = {
    xdg.configFile."fontconfig/conf.d/user.conf".text = cfg
  };
}
