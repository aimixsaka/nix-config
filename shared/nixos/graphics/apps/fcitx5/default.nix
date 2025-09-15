{
  pkgs,
  ...
}:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      # needed enable rime using configtool after installed
      fcitx5-configtool
      fcitx5-mozc
      fcitx5-rime
      fcitx5-gtk # gtk im module
    ];
  };
}
