{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    mesa-demos
    xterm
  ];
}
