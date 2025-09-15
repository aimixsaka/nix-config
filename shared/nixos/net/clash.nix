{ pkgs, ... }:
{
  # proxy
  #networking.firewall.enable = false;
  networking.firewall = {
    checkReversePath = false;
    trustedInterfaces = [
      "Meta"
    ];
  };

  services.mihomo = {
    enable = true;
    tunMode = true;
    webui = pkgs.metacubexd;
    configFile = "/etc/mihomo/config.yaml";
  };

  #programs.clash-verge = {
  #  enable = true;
  #  #tunMode = true;
  #  serviceMode = true;
  #};

  #services.zerotierone = {
  #  enable = true;
  #};
}
