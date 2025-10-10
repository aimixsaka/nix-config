{ lib, pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    extraConfig = ''
  '';
    shellAliases = {
      vi = "hx";
      vim = "hx";
      nano = "hx";
    };
  };
}
