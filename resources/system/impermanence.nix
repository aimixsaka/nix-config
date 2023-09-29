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
	# otherwise ssh host key will change every reboot
        "/etc/ssh"

        "/var/lib"
        "/var/log"
	"/var/tmp"

        "/srv" 
      ];

      files = [
        "/etc/machine-id"
        { file = "/etc/dae/config.dae"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
      ];
    };
    enableAllTerminfo = true;
  };

}
