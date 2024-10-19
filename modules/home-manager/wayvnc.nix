{
  config,
  lib,
  pkgs,
  hmLib,
  ...
}:

let
  cfg = config.services.wayvnc;

  settingsFormat = pkgs.formats.ini { };

  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    mkPackageOption
    ;
in
{
  ###### interface
  options = {
    services.wayvnc = {
      enable = mkEnableOption null // {
        description = ''
          wl-roots based wayland compositor vnc server.
          (NOTE: need to add port to `networking.firewall.allowedTCPPorts`)
        '';
      };
      headless = mkEnableOption null // {
        description = ''
          set env WAYLAND_HEADLESS=1 WAYLAND_DISPLAY=wayland-1
        '';
      };
      package = mkPackageOption pkgs "wayvnc" { };
      settings = mkOption {
        type = settingsFormat.type;
        default = { };
        description = ''
          wayvnnc configrations
        '';
      };
    };
  };

  ###### implementation
  config = mkIf cfg.enable (
    lib.mkMerge [
      {
        assertions = [
          (hmLib.assertions.assertPlatform "services.wayvnc" pkgs lib.platforms.linux)
        ];
      }

      {
        home.packages = [ cfg.package ];
        systemd.user.services.wayvnc = {
          Unit = {
            Description = "Run headless wayland in backgroud with wayvnc";
            PartOf = [ "graphical-session.target" ];
          };
          Service = {
            Type = "simple";
            ExecStart = "${cfg.package}/bin/wayvnc";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
          Install.WantedBy = [ "graphical-session.target" ];
        };
      }

      (lib.mkIf (cfg.settings != { }) {
        xdg.configFile."wayvnc/config".source =
          if lib.isPath cfg.settings then cfg.settings else settingsFormat.generate "wayvnc.ini" cfg.settings;
      })
    ]
  );
}
