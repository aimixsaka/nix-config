{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let 
  cfg = config.services.zxray;
in
{
  ##
  # interface
  ##
  options = {
    services.zxray = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mkDoc ''
          whether to enable zxray, a transparent proxy service based on xray and nftables
        '';
      };
      nftRuleset = mkOption {
        type = types.lines;
        default = "";
        description = mkDoc ''
          ruleset set to `networking.nftables.ruleset`
        '';
      };
      xrayConfigFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        example = "/etc/xray/config.json";
        description = mkDoc ''
          xray config file path set to `services.xray.settingsFile`
        '';
      };
    };
  };

  
  ##
  # implementation
  ##
  config = mkIf cfg.enable {
    services.xray = {
      enable = true;
      settingsFile = cfg.xrayConfigFile;
    };
    networking.nftables = {
      enable = true;
      ruleset = cfg.nftRuleset;
    };

    systemd.services.zxray = {
      description = "zxray service(transparent proxy service based on xray and tproxy)";
      requires = [ "xray.service" "nftables.service" ];
      after = [ "xray.service" "nftables.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "ip rule add fwmark 0x40/0xc0 table 100 && ip route add local 0.0.0.0/0 dev lo table 100 && systemctl start xray.service nftables.service"; 
        ExecReload = "systemctl restart xray.service nftables.service";
        ExecStop = "ip rule del fwmark 0x40/0xc0 table 100 && ip route del local 0.0.0.0/0 dev lo table 100 && systemctl stop xray.service nftables.service";
      };
    };
  };
}
