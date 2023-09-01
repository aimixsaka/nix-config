{
  inputs,
  pkgs,
  modulesPath,
  lib,
  config,
  ...
}:

{
  imports = [
    # generated by nixos-generate-config
    (modulesPath + "/installer/scan/not-detected.nix")

    # contains vaapi intel, patched kernel for surface pro, ipts ...
    #inputs.hardware.nixosModules.microsoft-surface-pro-intel

    # use self forked nixos-hardware
    inputs.hardware-self.nixosModules.microsoft-surface-pro-intel

    ../../resources/system
  ];

  ############### boot and resume config ###############
  boot = {
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [ 
        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
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
    kernelParams = [ "resume_offset=1005787" ];
    resumeDevice = "/dev/disk/by-label/${config.networking.hostName}";
  };


  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  ############ Surface Specific #############

  ## NOTE: included in hardware surface
  #hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    ## NOTE: included in hardware surface
    #extraPackages = with pkgs; [
    #  intel-media-driver
    #];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
