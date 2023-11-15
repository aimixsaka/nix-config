{ 
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    qq
    feishu
    telegram-desktop
  ];
}
