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
    persistence."/persist" = {
      directories = [ 
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
        "/etc/v2raya"

        "/var/lib"
        "/var/log"

        "/srv" 
      ];

      files = [
        "/etc/machine-id"
      ];
    };
    enableAllTerminfo = true;
  };

}
