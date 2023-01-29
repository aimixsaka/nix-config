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
      fcitx5-mozc
      fcitx5-chinese-addons
      fcitx5-rime
    ];
  };

  # fonts
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    
    fontconfig = {
      defaultFonts = {
        serif = [ "Consolas Nerd Font" ];
        sansSerif = [ "Consolas Nerd Font" ];
        monospace = [ "Consolas Nerd Font" ];
      };
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";
}
