{
  lib,
  ...
}:

{
  nixpkgs = {
    config = {
      #allowUnfree = true;

      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        # Add additional package names here
	"qq"
	"steam"
	"steam-original"
	"steam-run"
	"obsidian"
      ];
    };
  };
}
