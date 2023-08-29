{ 
  pkgs,
  ...
}:

{
  # useful system level tools
  environment.systemPackages = with pkgs; [
    fd
    ripgrep
  ];
}
