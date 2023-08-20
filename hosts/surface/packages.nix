{ pkgs
, ...
}:

{
  imports = [
    ../../resources/system/tools.nix
  ];
  environment.systemPackages = with pkgs; [
  ## other tools specific to this host
    ## search tool
    ripgrep
  ];

}
