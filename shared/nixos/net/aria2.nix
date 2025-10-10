{
  pkgs,
  config,
  domain ? "",
}:

{
  services.aria2 = {
    enable = true;
    rpcSecretFile = "/etc/aria2/rpc-secret.txt";
    settings = {
      rpc-listen-all = true;
    };
    openPorts = true;
  };

  #services.caddy.enable = true;
  #services.caddy.virtualHosts = {
  #  ${domain} = {
  #    extraConfig = ''
  #      file_server {
  #          root ${pkgs.ariang}/share/ariang
  #      }
  #      reverse_proxy /jsonrpc localhost:${toString config.services.aria2.settings.rpc-listen-port}
  #    '';
  #  };
  #};

}
