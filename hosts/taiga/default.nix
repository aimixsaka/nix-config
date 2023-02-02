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

    timeServers = [ "0.cn.pool.ntp.org" "1.cn.pool.ntp.org" "2.cn.pool.ntp.org" "3.cn.pool.ntp.org" ]; 

    proxy.noProxy = "127.0.0.1,localhost,internal.domain"; # set proxy

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };

  # Enable network manager applet
  programs.nm-applet.enable = true;
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
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
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
    direnv
    libnotify
    traceroute
    gdb
    gnupg
    file
    mpv
    ranger
    ## vaapi info
    libva-utils
    ## intel gpu tools
    intel-gpu-tools
    ## image viewer
    geeqie
    ## markdown viewer
    marktext

    ## use appimage-run to run .AppImage file
    appimage-run

    ### system monitor
    ## sar
    sysstat
    #
    plocate 

    gcc
    cargo
    rustc
    rustup
    go
    lua
    python39
    jdk11
    nodejs
    # use swaybg instead
    #hyprpaper
    ## bar
    ##eww-wayland
    ## light control
    wlsunset
    xdg-desktop-portal-wlr
    ## screen recording
    ## for acceses for seat
    #polkit

    ### Wine
    wineWowPackages.stable
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
    driSupport = true;
    driSupport32Bit = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
