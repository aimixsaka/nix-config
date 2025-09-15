{
  pkgs-stable ? (
    import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-24.11.tar.gz") { }
  ),
  pkgs ? import <nixpkgs> { },
}:
rec {
  pydle = pkgs-stable.python312Packages.callPackage ./pydle { };
  pure-sasl = pkgs-stable.python312Packages.callPackage ./pure-sasl { };
  telegramirc = pkgs-stable.callPackage ./telegramirc.nix { inherit pydle pure-sasl; };
  rime-shuangpin-fuzhuma = pkgs.callPackage ./rime-shuangpin-fuzhuma.nix { };
}
