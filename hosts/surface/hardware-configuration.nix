{ inputs
, pkgs
, modulesPath
, lib
, config
, ...
}:

{
  imports = [
    # generated by nixos-generate-config
    (modulesPath + "/installer/scan/not-detected.nix")

    inputs.hardware.nixosModules.microsoft-surface-pro-intel

    ../../resources/system/tmproot.nix
  ];

  ############### boot config ###############
  boot = {
    kernelModules = [ "kvm-intel" ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  ############ Surface Specific #############
  # set kernel version
  microsoft-surface.kernelVersion = "6.1.18";
  # disable iptsd for dependency confilct
  #microsoft-surface.ipts.enable = lib.mkForce false;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
