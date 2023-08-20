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

    ../../resources/system
  ];

  ############### boot and resume config ###############
  boot = {
    kernelModules = [ "kvm-intel" ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    ## systemd-boot
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };

    ## grub
    # Use the GRUB 2 boot loader (Both EFI and legacy boot supported).
    #loader = {
    #  grub = {
    #    enable = true;

    #    # This is for GRUB in EFI mode
    #    efiSupport = true;
    #    device = "nodev";
    #  
    #    # This is for GRUB for legacy boot
    #    #device = "/dev/disk/by-label/ESP";
    #  };
    #};

    # resume
    kernelParams = [ "resume_offset=1193275" ];
    resumeDevice = "/dev/disk/by-label/${config.networking.hostName}";
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
