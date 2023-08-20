{ inputs
, ...
}:

{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  # For impermanence's allowOther = true;
  programs.fuse.userAllowOther = true;

  environment = {
    persistence."/nix/persist" = {
      directories = [ 
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"

        "/var/lib/systemd"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/var/log"

        "/srv" 
      ];
    };
    enableAllTerminfo = true;
  };

}
