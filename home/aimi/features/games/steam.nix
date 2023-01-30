{ pkgs, lib, ... }:
let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs: with pkgs; [
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
    ];
  };
in
{
  home.packages = with pkgs; [
    steam-with-pkgs
    gamescope
    protontricks
    winetricks
  ];

  home.persistence = {
    "/persist/games/aimi" = {
      allowOther = true;
      directories = [
        "SerenBanka"
        #{
        #  directory = ".local/share/Steam";
        #  method = "symlink";
        #}
      ];
    };
  };
}
