{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      # Chinese Specified
      wqy_zenhei
      wqy_microhei
      # Nerd Fonts
      (nerdfonts.override { fonts = [ "Inconsolata" "SourceCodePro" ]; })
  ];
}
