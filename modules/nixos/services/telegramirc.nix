{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.telegramirc;
in
{
  ### interface
  options = {
    services.telegramirc = {
      enable = lib.mkEnableOption "Telegram as your IRC client";
      configFilePath = lib.mkOption {
        type = lib.types.str;
        description = ''
          Path to telegramirc.toml configuration file.
        '';
      };
    };
  };

  ### implementation
  config = lib.mkIf cfg.enable {
    systemd.services.telegramirc = {
      description = "Telegram as your IRC client";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${lib.getExe pkgs.telegramirc} ${cfg.configFilePath}";
        Restart = "on-abort";
      };
    };
  };
}
