{ pkgs
, ...
}:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      libsForQt5.fcitx5-qt
      # needed enable rime using configtool after installed
      fcitx5-configtool
      fcitx5-chinese-addons
      fcitx5-mozc
      fcitx5-rime
      fcitx5-gtk # gtk im module
    ];
  };
  home.file.".local/share/fcitx5/themes".source = ./themes;
  xdg.configFile."fcitx5/conf/classicui.conf".text = ''
    Theme=Nord-Dark
  '';
}
