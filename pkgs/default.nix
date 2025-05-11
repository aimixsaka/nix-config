{
  pkgs ? import <nixpkgs> { },
}:
rec {
  pydle = pkgs.python312Packages.callPackage ./pydle { };
  pure-sasl = pkgs.python312Packages.callPackage ./pure-sasl { };
  telegramirc = pkgs.callPackage ./telegramirc.nix { inherit pydle pure-sasl; };
}
