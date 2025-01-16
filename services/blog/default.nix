{ pkgs, ... }:
{
  services.caddy = {
    enable = true;
    configFile = pkgs.writeText "Caddyfile" ''
      amx.moe {
        root * ${./src}
        encode gzip
        file_server
      }
    '';
  };
}
