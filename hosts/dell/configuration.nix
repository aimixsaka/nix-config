{
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  #boot.loader = {
  #  systemd-boot.enable = true;
  #  efi.canTouchEfiVariables = true;
  #};

  # enable btrfs support
  boot.supportedFilesystems = [ "btrfs" ];
  ## see https://nixos.org/manual/nixos/stable/#sec-installation-manual-installing UEFI section
  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    #useOSProber = true;
  };

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "vmd"
    "nvme"
    "uas"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  nix.sshServe = {
    enable = true;
    protocol = "ssh-ng";
    keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtCi7o7AdRFMiV3qa3GBD7Qa2U/fFllRJfo4Mre9Z1XSyPQe5dAHd3CVwjI+8FcU48w2BIwKitU8JC32KGFm/VoRew0mg5YiBiTBKimISpzAvS+GUwGg86q0ZX/FyuQcuEHISOFueuBR9dZd2nB6TydlZDICuuypH/lXtUFarXicNhlwGozSX2kqWedeAnd3/iKfWIXu63u0BmHoAa050Zi2TqRwzE2OQ7AvKaDbaVqVXZc0KQ8azfM7IskOk6Vu34TwMK1CmCk1Rkp0OR9I7KZ/dx9tVAc73PTx0+fefUFMiNfpdihcmYRdlRkN/QLwgrVLu/hwa4ycI5mNCIVMFi3cYF5aY7xYbR9Igi52NFTEBN0wtInajocU6KGY86oQayI6sPNFhrPFZApV0bxWjHprZfOGw+OoJTqL0BElyaqzoSbFRvtNgWgJD33UVgBJrSIduLfwtTFGPOQY5Jg2Lux+UnSQzXBRLr4DBZ1Tyynv6jUsRWHPIA2nS3GXSX5GXlhBSQuEgTBDWfWwtBoR1ljWikDb/qykJbRBrMlVunLl1/XhXY57Kjojei193sIQ7VZJA4oZJMpKOBQBIA/6mDtffZpJGZMbUmq+fr4pQddZn2J7KZIOURoWObW1n2y7soWCMX2CoZljup/seM9NplE3HN1D0OCVFT1+k1A1MuEQ== aimi@taiga"
    ];
  };

  facter.reportPath =
    if builtins.pathExists ./facter.json then
      ./facter.json
    else
      throw "Have you forgotten to run nixos-facter -o ./facter.json`?";

  ## dell nvidia special case
  # needed for finegrained
  hardware.nvidia = {
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;
  };
  ## Lid settings
  services.logind = {
    lidSwitch = "suspend";
    #lidSwitchExternalPower = "lock";
    lidSwitchExternalPower = "ignore";
  };
  ## network
  networking.firewall.allowedTCPPorts = [
    5901
  ];
  networking.networkmanager.enable = true;
}
