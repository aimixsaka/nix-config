{
  lib,
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
  boot.loader.grub = {
    device = "nodev";
    default = "saved";
    efiSupport = true;
  };

  # enable btrfs support
  boot.supportedFilesystems = [ "btrfs" ];

  boot.initrd.availableKernelModules = [
    "uas"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # we need to vendor this firmware if using nix flake
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  # enable GPU support
  hardware.graphics.enable = true;
  hardware.asahi.useExperimentalGPUDriver = true;

  nix.sshServe = {
    enable = true;
    protocol = "ssh-ng";
    keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtCi7o7AdRFMiV3qa3GBD7Qa2U/fFllRJfo4Mre9Z1XSyPQe5dAHd3CVwjI+8FcU48w2BIwKitU8JC32KGFm/VoRew0mg5YiBiTBKimISpzAvS+GUwGg86q0ZX/FyuQcuEHISOFueuBR9dZd2nB6TydlZDICuuypH/lXtUFarXicNhlwGozSX2kqWedeAnd3/iKfWIXu63u0BmHoAa050Zi2TqRwzE2OQ7AvKaDbaVqVXZc0KQ8azfM7IskOk6Vu34TwMK1CmCk1Rkp0OR9I7KZ/dx9tVAc73PTx0+fefUFMiNfpdihcmYRdlRkN/QLwgrVLu/hwa4ycI5mNCIVMFi3cYF5aY7xYbR9Igi52NFTEBN0wtInajocU6KGY86oQayI6sPNFhrPFZApV0bxWjHprZfOGw+OoJTqL0BElyaqzoSbFRvtNgWgJD33UVgBJrSIduLfwtTFGPOQY5Jg2Lux+UnSQzXBRLr4DBZ1Tyynv6jUsRWHPIA2nS3GXSX5GXlhBSQuEgTBDWfWwtBoR1ljWikDb/qykJbRBrMlVunLl1/XhXY57Kjojei193sIQ7VZJA4oZJMpKOBQBIA/6mDtffZpJGZMbUmq+fr4pQddZn2J7KZIOURoWObW1n2y7soWCMX2CoZljup/seM9NplE3HN1D0OCVFT1+k1A1MuEQ== aimi@taiga"
    ];
  };

  ## network
  networking.firewall.allowedTCPPorts = [
    5901
  ];
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Shanghai";

  ## remap key
  services.keyd = {
    enable = true;
    keyboards.default = {
      settings = {
        main = {
          leftalt = "layer(meta)";
          leftmeta = "layer(alt)";
          rightalt = "layer(meta)";
          rightmeta = "layer(altgr)";
          capslock = "layer(control)";
        };
      };
    };
  };

  ## HiDPI
  # Set scaling factor for xserver (used for xwayland)
  services.xserver = {
    # enable = true;    # should be set in configuration.nix
    dpi = 116; # change depending on resolution
  };

  ## Kernel Patch for dae ebpf
  boot.kernelPatches = [
    {
      name = "dae-ebpf";
      patch = null;
      extraStructuredConfig = {
        DEBUG_INFO = lib.kernel.yes;
        DEBUG_INFO_BTF = lib.kernel.yes;
        KPROBE_EVENTS = lib.kernel.yes;
        BPF_EVENTS = lib.kernel.yes;
      };
    }
  ];

}
