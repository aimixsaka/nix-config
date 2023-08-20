{ pkgs
, ...
}:

{
  i18n.inputMethod = {
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      libsForQt5.fcitx5-qt
      fcitx5-mozc
      fcitx5-chinese-addons
      fcitx5-rime
    ];
  };
}
