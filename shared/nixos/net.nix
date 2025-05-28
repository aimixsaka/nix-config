{
  ## proxy
  networking.firewall.trustedInterfaces = [
    "Meta"
  ];
  services.mihomo = {
    enable = true;
    tunMode = true;
    configFile = "/etc/mihomo/config.yaml";
  };

  services.zerotierone = {
    enable = true;
  };
}
