{
  # blog
  imports = [
    ../../services/blog
  ];

  services = {
    miniflux = {
      enable = true;
      config = {
        PORT = 8081;
      };
      adminCredentialsFile = "/etc/nixos/miniflux-admin-credentials";
    };
  };

  # proxy
  services.xray = {
    enable = true;
    settingsFile = "/etc/xray/config.json";
  };

  networking.firewall.allowedTCPPorts = [
    3443 # xray
    8081 # miniflux
    # blog
    80
    443
  ];
}
