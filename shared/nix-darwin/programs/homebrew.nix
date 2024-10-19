{ lib, ... }:
let
  flattenValues = vars: lib.flatten (lib.attrValues vars);
in
{
  homebrew = {
    enable = true;

    taps = [ "railwaycat/emacsmacport" ];

    brews = flattenValues {
      system = [
        "mysql"
        #{ 
        #  name = "emacs-mac";
        #  args = [ 
        #    "with-modules"
        #    "with-librsvg"
        #    "with-imagemagick"
        #    "with-natural-title-bar"
        #  ];
        #}
      ];
    };

    casks = flattenValues {
      system = [
        "raycast"
        "zerotier-one"
      ];

      fonts = [
        "font-dejavu"
        "font-dejavu-sans-mono-nerd-font"
        "font-inconsolata"
        "font-inconsolata-nerd-font"
      ];
    };
  };
}
