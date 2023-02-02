{ lib, pkgs, ... }:
{
  # Select internationalisation properties.
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = lib.mkDefault "zh_CN.UTF-8";
    LC_IDENTIFICATION = lib.mkDefault "zh_CN.UTF-8";
    LC_MEASUREMENT = lib.mkDefault "zh_CN.UTF-8";
    LC_MONETARY = lib.mkDefault "zh_CN.UTF-8";
    LC_NAME = lib.mkDefault "zh_CN.UTF-8";
    LC_NUMERIC = lib.mkDefault "zh_CN.UTF-8";
    LC_PAPER = lib.mkDefault "zh_CN.UTF-8";
    LC_TELEPHONE = lib.mkDefault "zh_CN.UTF-8";
    LC_TIME = lib.mkDefault "zh_CN.UTF-8";
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-qt
      fcitx5-mozc
      fcitx5-chinese-addons
      fcitx5-rime
    ];
  };

  # FIXME: system-wide font configuration is bad habit!
  # fonts
  fonts = {
    enableDefaultFonts = true;
    ## Use fonts installed in home-manager instead
    fontconfig = {
      defaultFonts = {
        serif = [ 
          "Noto Serif"
          "Noto Color Emoji" 
        ];
        sansSerif = [
          "SauceCodePro Nerd Font" 
          "Noto Sans CJK SC"
          "WenQuanYi Micro Hei"
          "Noto Sans Mono CJK JP" 
          "Noto Color Emoji" 
        ];
        monospace = [
          "SauceCodePro Nerd Font Mono" 
          "Inconsolata Nerd Font Mono"
          "Noto Sans Mono CJK SC"
          "WenQuanYi Micro Hei Mono"
          "Noto Sans Mono CJK JP"
          "Noto Color Emoji" 
        ];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";
}
