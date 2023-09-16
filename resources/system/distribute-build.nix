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

  # NOTE: inner net when using school network
  #programs.ssh.extraConfig = ''
  #  Host taiga
  #    HostName 101.aimisaka.site
  #    Port 13505
  #'';

  # use zerotier-one
  programs.ssh.extraConfig = ''
    Host taiga
      HostName arch.apsb.cc
      Port 52842
  '';

  programs.ssh.knownHosts = {
    taiga = {
      # NOTE: inner net when using school network
      #hostNames = [ "taiga" "101.aimisaka.site" ];
      hostNames = [ "taiga" "arch.apsb.cc" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL11KIby8U00SYDP//F+lfYKUFXHf79GcdiO7s980MzW";
    };
  };
}
