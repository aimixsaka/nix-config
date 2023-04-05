{ pkgs ? null }:
let
  rustNightly = pkgs.callPackage ./rust-nightly { };
in
{
  rustLatest = rustNightly.rust {
    date = "2023-02-08";
    hash = "koHGgQ5c8tYm+3gyAIWuKZwQnKeq3mmVGtm2RvNVBik=";
  };
  #rustStd = rustNightly.rust-std {
  #  date = "2023-02-08";
  #  hash = "dgWKoRdrtdLpjZ+OK+fmrKIwnkg+X+g7atLjR3i5CpY=";
  #};
  #rustLatest = rustNightly.rust { }; 
  darkplus = pkgs.callPackage ./vim-plugins/darkplus { };
  #v2raya-x = pkgs.callPackage ./v2rayax { };
}
