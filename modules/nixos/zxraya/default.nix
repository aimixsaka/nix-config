{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

{
  ##
  # interface
  ##
  options = {
    services.zxraya = {
      enable = options.mkEnableOption (mkDoc "transparent proxy based on v2raya and xray");
    };
  };

  
  ##
  # implementation
  ##
  config = mkIf config.services.zxraya.enable {
    environment.systemPackages = [ pkgs.xray ];
  };
}
