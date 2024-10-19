{
  inputs,
  ...
}:

{
  _module.args.hmLib = inputs.home.lib.hm;
  imports = [
    ./wayvnc.nix
  ];
}
