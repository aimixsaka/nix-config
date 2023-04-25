{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji

      source-code-pro
      source-han-mono
      source-han-sans
      source-han-serif
      #inconsolata
      wqy_zenhei
      # wqy_microhei
      # twitter-emoji
      twitter-color-emoji
      # Nerd Fonts
      #nerdfonts
      (nerdfonts.override { fonts = [ "Inconsolata" "SourceCodePro" ]; })
  ];
}
