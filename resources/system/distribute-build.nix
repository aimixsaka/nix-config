{
  ## configuration for distributed build
  nix.distributedBuilds = true;
  nix.buildMachines = 
    let
      sshUser = "aimi";
      sshKey = "/home/aimi/.ssh/101_rsa";
      systems = [
        "x86_64-linux"
      ];
      supportedFeatures = [
        "benchmark"
	"big-parallel"
	"kvm"
      ];
    in
      [
        {
	  inherit sshUser sshKey systems supportedFeatures;
	  hostName = "taiga";
	  maxJobs = 32;
          speedFactor = 1;
	}
      ];

  nix.extraOptions = ''
    builders-use-substitutes = true
  '';

  programs.ssh.extraConfig = ''
    Host taiga
      HostName 192.168.0.13
      Port 60022
  '';

  programs.ssh.knownHosts = {
    taiga = {
      hostNames = [ "taiga" "192.168.0.13" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAD0Iszx+SxrXOIOlXS7MESrM1LAgRmFUvTUcJU00FJ6";
    };
  };
}
