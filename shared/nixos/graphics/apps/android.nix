{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    android-studio
    flutter324
    jdk17
  ];

}
