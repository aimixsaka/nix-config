{
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  facter.reportPath =
    if builtins.pathExists ./facter.json then
      ./facter.json
    else
      throw "Have you forgotten to run nixos-facter -o ./facter.json`?";

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    (import ../../shared/nixos/disko/btrfs-server.nix { })
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC0yCakm4zhPe9MVxlu7ulUPx8OesW283taCnz3cwzCKPiPQ+XoTy/uQg5w872iTpn2tlCyQTDWqy9RxM6J0xCDq5/y0SSu5IP4JuDxeo0Bvtka5mIhFhTxC+pT2DeGV07mYNOn79WsF+jA09AUOq0lX9jbfAiuQLPHPlIctt9OABU4bwSzSLzJzNtL/4GssyDKDcWYoU84aa6g7bjEuGmPpEPDOoK6zTPlfGwyx9wk0pTlME23yw5wh0nZ5qzeNONHWJtIDIEMA8K56lBY9pf11L4EiAI/9UnXqktHYBDLhuRRz5ZFmhqvFiwDbEoNTtwgeAjG+WLzYMeMzjt6Jd9wmisuhU5aejVTStiPjwSPXh29b11IA6+V0UpCsIzdoRp8oFtsAiSg3Dhr41qAh8jUkU5kYuLE897/iQjFIJQZgTOaKu3+DPAA2fTB1fCHktlfs9AvcnbN/woqL4uO56AbZ/jvLcPdQvxxuIZp7fj3muMOJ9XosaqfSM+6OmIXZNGZE416iS9dcz14n4K9IBkI8zWh5TWWfyPwEC4+seIOWT0lNx9h/7CYtmLWrJAlIqC6DeSj8plWCWCTssukMId7rZ6fQSRTDNzHfuKdxsc7myHzx0QjMfVle8zFJQ6aQrZLmgT3ckupYrqaAi0GvYyXIshJxxun2KJlQCgn3cPfww== aimixsaka@gmail.com"
  ];

  # proxy
  services.xray = {
    enable = true;
    settingsFile = "/etc/xray/config.json";
  };
  networking.firewall.allowedTCPPorts = [
    3443
  ];

  system.stateVersion = "24.11";
}
