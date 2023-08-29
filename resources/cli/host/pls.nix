{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    go
    python311
    gcc
    lua
    luajit
  ];
}
