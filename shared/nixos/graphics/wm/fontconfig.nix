{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    dejavu_fonts
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    twitter-color-emoji
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [
        "Noto Color Emoji"
      ];
      monospace = [
        "DejaVu Sans Mono"
        "DejaVuSansM Nerd Font"
      ];
      sansSerif = [
        "DejaVu Sans"
        "Noto Sans CJK SC"
      ];
      serif = [
        "DejaVu Serif"
        "Noto Serif CJK SC"
      ];
    };
  };
}
