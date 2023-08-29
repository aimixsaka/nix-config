{ 
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # network
    nftables
    xray
    clash-verge
    dae
  ];

  services.dae = {
    enable = true;
  };
}
