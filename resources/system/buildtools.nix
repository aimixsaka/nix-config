{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    gnumake
    ninja
    meson
    #python311Packages.meson
  ];
}
