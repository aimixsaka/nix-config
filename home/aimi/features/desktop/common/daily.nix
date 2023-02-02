{ pkgs, ... }: {
  home.packages = with pkgs; [
    qq
    feishu
    chromium
    # telegram desktop
    tdesktop
    # change light of screen 
    light
    # office tool
    mdds # dependency for libreoffice
    libreoffice
  ];
}
