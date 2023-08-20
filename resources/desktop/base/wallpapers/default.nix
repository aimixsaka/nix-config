builtins.listToAttrs (map
  (wallpaper: {
    inherit (wallpaper) name;
    value = builtins.fetchurl {
      inherit (wallpaper) sha256;
      url = "raw.githubusercontent.com/aimixsaka/wallpapers/main/${wallpaper.name}.${wallpaper.ext}";
    };
  })
  (builtins.fromJSON (builtins.readFile ./list.json)))
