{ pkgs
, ...
}:

{
  imports = [
    ../../resources/cli/host
  ];
  environment.systemPackages = with pkgs; [
  ## other tools specific to this host
  ];

}
