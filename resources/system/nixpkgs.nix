{
  lib,
  ...
}:

{
  nixpkgs = {
    config = {
      #allowUnfreePredicate = 
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam-original"
      ];
    };
  };
}
