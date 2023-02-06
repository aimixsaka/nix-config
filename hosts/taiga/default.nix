# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, pkgs, outputs, ... }:
{
  # You can import other NixOS modules here
  imports = [
    # microsoft-surface-pro-intel specific hardware 
    inputs.hardware.nixosModules.microsoft-surface-pro-intel

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    ../common/global
    ../common/users/aimi

    ../common/optional/gamemode.nix
  ];



  # FIXME: Add the rest of your current configuration

  # TODO: Set your hostname
  networking = {
    hostName = "taiga";

    nameservers = [ "1.1.1.1" "9.9.9.9" "8.8.8.8" ];
    timeServers = [ "0.cn.pool.ntp.org" "1.cn.pool.ntp.org" "2.cn.pool.ntp.org" "3.cn.pool.ntp.org" ]; 

    #proxy.default = 
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain"; # set proxy

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };

  # For impermanence's allowOther = true;
  programs.fuse.userAllowOther = true;

  # TODO: This is just an example, be sure to use whatever bootloader you prefer
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # use surface hardware specific
    #kernelPackages = pkgs.linuxPackages_zen;
  };

  # auto updae
  #system.autoUpgrade.enable = true;
  #system.autoUpgrade.allowReboot = true;

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    #lidSwitchExternalPower = "lock";
    lidSwitchExternalPower = "suspend";
  };

  # Resume (hibernate) hook
  powerManagement.resumeCommands = ''
    systemctl restart systemd-timesyncd.service
    echo "HOOK: Restarted systemd-timesyncd.service!"
  '';

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus.enable = true;  
  xdg.portal = {
    enable = true;
    wlr.enable = true; # xdg-desktop-portal-wlr
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable docker
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  #services.openssh = {
  #  enable = true;
  #  # Forbid root login through SSH.
  #  permitRootLogin = "no";
  #  # Use keys only. Remove if you want to SSH using password (not recommended)
  #  passwordAuthentication = false;
  #};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    unzip
    lsof
    htop
    ## trash cli
    # not that good for zsh completion 
    #trashy
    trash-cli
    ## for nix-shello development
    traceroute
    gdb
    file
    ## vaapi info
    libva-utils
    ## intel gpu tools
    intel-gpu-tools
    ### system monitor
    ## sar
    sysstat
    plocate 
    gcc
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
