{ 
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # network
    nftables
    xray
    v2ray
    dae
    v2raya

    # inner net
    zerotierone
  ];

  services.zerotierone.enable = true;

  #networking.nftables.enable = true;

  services.dae = {
    #enable = true;
  };

  services.v2raya = {
    enable = true;
  };

  # v2raya
  # FIXME: use xray core OR pack v2raya myself
  # nixpkgs v2raya version too old
  #virtualisation.oci-containers.containers = {
  #  v2raya = {
  #    image = "mzz2017/v2raya";
  #    extraOptions = [
  #      "--privileged"
  #      "--network=host"
  #    ];
  #    environment = {
  #      V2RAYA_LOG_FILE = "/tmp/v2raya.log";
  #    };
  #    volumes = [
  #      # FIXME: not that good code!
  #      "/run/current-system/kernel-modules/lib/modules:/lib/modules:ro"
  #      "/etc/resolv.conf:/etc/resolv.conf"
  #      "/etc/v2raya:/etc/v2raya"
  #    ];
  #  };
  #};
}
