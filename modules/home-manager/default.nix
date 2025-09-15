{
  inputs,
  ...
}:

{
  _module.args.hmLib = inputs.home.lib.hm;
  imports = [
    # wayvnc service already in official repo
    #./wayvnc.nix
  ];
}
