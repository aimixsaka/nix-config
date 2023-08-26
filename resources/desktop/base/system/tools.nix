{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    pamixer
    intel-gpu-tools
    libva-utils
  ];
}
