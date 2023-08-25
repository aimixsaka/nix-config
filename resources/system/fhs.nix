# util(env) for running fhs compotible binaries,
# just run fhs to enter fhs environment
# reference: https://nixos-and-flakes.thiscute.world/zh/best-practices/run-downloaded-binaries-on-nixos
{
  config,
  pkgs,
  lib,
  ...
}:

{
  # create a fhs environment by command `fhs`, so we can run non-nixos packages in nixos!
  environment.systemPackages = with pkgs; [
    (
      let 
        base = pkgs.appimageTools.defaultFhsEnvArgs; 
      in
        pkgs.buildFHSUserEnv (
          base // {
	    name = "fhs";
	    targetPkgs = pkgs: (
	      # pkgs.buildFHSUserEnv provides the smallest env, may lack some packages for fhs binaries.
	      # pkgs.appimageTools provide many basic packages needed by bins, so add it here
	      (base.targetPkgs pkgs) ++ (with pkgs; [
	        pkg-config
		ncurses
	      ])
	    );
	  }
        )
    )
  ];
}

