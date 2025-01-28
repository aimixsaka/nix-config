{
  services.caddy.enable = true;
  services.caddy.virtualHosts = {
    "amx.moe" = {
      extraConfig = ''
        root * ${./src}
        encode gzip
        file_server
      '';
    };
  };
}
