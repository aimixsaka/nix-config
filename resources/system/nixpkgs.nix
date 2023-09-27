{
  lib,
  outputs,
  ...
}:

{
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      #allowUnfree = true;

      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        # Add additional package names here
	"qq"
	"steam"
	"steam-original"
	"steam-run"
	"obsidian"
	"zerotierone"
      ];
    };
  };
}
