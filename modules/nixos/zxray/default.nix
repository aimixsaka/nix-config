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
      serviceConfig = let
	setIpRule = pkgs.writeShellScript "set-ip-rule" ''
	  ${pkgs.iproute2}/bin/ip rule add fwmark 0x40/0xc0 table 100
	  ${pkgs.iproute2}/bin/ip route add local 0.0.0.0/0 dev lo table 100
	'';

	rmIpRule = pkgs.writeShellScript "remoev-ip-rule" ''
	  ${pkgs.iproute2}/bin/ip rule del fwmark 0x40/0xc0 table 100
	  ${pkgs.iproute2}/bin/ip route del local 0.0.0.0/0 dev lo table 100
	'';

	startServices = pkgs.writeShellScript "start-services" ''
	  systemctl start xray.service nftables.service
	'';
	restartServices = pkgs.writeShellScript "restart-services" ''
	  systemctl restart xray.service nftables.service
	'';
	stopServices = pkgs.writeShellScript "stop-services" ''
	  systemctl stop xray.service nftables.service
	'';
      in {
	Type = "oneshot";
	RemainAfterExit = true;
	ExecStartPre = startServices;
        ExecStart = setIpRule;
        ExecReload = restartServices;
        ExecStop = rmIpRule;
        ExecStopPost = stopServices;
	StateDirectory = "zxray";
      };
    };
  };
}
