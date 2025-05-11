{
  pkgs,
  config,
  ...
}:
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

  services = {
    # proxy
    xray = {
      enable = true;
      settingsFile = "/etc/xray/config.json";
    };
    # downloader
    aria2 = {
      enable = true;
      rpcSecretFile = "/root/secret/aria2-rpc.txt";
    };
  };

  # caddy
  services.caddy.virtualHosts = {
    "aria2.amx.moe" = {
      extraConfig = ''
        file_server {
            root ${pkgs.ariang}/share/ariang
        }
        reverse_proxy /jsonrpc localhost:${toString config.services.aria2.settings.rpc-listen-port}
      '';
    };
    "rss.amx.moe" = {
      extraConfig = ''
        reverse_proxy :${toString config.services.miniflux.config.PORT}
      '';
    };
  };

  # telegramirc
  services.telegramirc = {
    enable = true;
    configFilePath = "/root/secret/telegramirc.toml";
  };

  networking.firewall.allowedTCPPorts = [
    3443 # xray
    # blog
    80
    443
  ];
}
