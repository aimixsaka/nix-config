{
  pkgs,
  lib,
  system,
  nixos-generators,
}:

{
  installer-xfce = nixos-generators.nixosGenerate {
    inherit system;
    # cannot run if using nixpkgs unstable
    inherit pkgs lib;
 
    modules = [
      ./iso/xfce.nix
    ];
    #format = "raw-efi";
    format = "install-iso";
    #format = "iso";
  };
}
