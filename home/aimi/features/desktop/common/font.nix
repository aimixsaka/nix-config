{ pkgs, ... }: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Inconsolata Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; };
    };
    regular = {
      family = "Source Code Pro Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ]; };
    };
  };
}
