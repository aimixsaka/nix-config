{
  pkgs ? import <nixpkgs> { }
}:

{
  ## as overlay
  v2raya = pkgs.callPackage ./v2raya {};
}
