{ pkgs, lib, inputs, ... }:

let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in
{
  #programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;
    extensions = with addons; [
      darkreader
      octotree
      vimium
    ];
  };

  home = {
    sessionVariables.BROWSER = "firefox";
    persistence = {
      "/persist/home/aimi".directories = [ ".mozilla/firefox" ];
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
