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
        #{
	#  inherit sshUser sshKey systems supportedFeatures;
	#  hostName = "ming";
	#  maxJobs = 32;
        #  speedFactor = 5;
	#}
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
    #Host ming
    #  HostName ming.apsb.cc
    #  Port 22
    Host github.com
      HostName github.com
      User aimixsaka
      PreferredAuthentications publickey
      IdentityFile /home/aimi/.ssh/github_id_rsa
  '';

  programs.ssh.knownHosts = {
    taiga = {
      # NOTE: inner net when using school network
      hostNames = [ "arch.apsb.cc" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJn7bhyW/e8UKTI5HjJoEwrJbQ7trX6thzXSvU3OY9dZ";
    };
    #ming = {
    #  hostNames = [ "ming.apsb.cc" ];
    #  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMH2flR7FZ47wFbln/VpRCag12wZSKmtZitymlVdmvY0";
    #};
  };
}
