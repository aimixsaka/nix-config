{ lib
, ...
}:

{
  imports = [
    ./hardware-configuration.nix

    ./packages.nix
    ../../resources/system

    ./home-manager.nix
    # users
    ./aimi.nix
  ];

  ############## Network ############
  networking = {
    hostName = "taiga";

    useDHCP = lib.mkDefault true;

    nameservers = [ "1.1.1.1" "9.9.9.9" "8.8.8.8" ];

    networkmanager.enable = true;
  };

  ############# systemd logind ##########
  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    #lidSwitchExternalPower = "lock";
    lidSwitchExternalPower = "suspend";
  };

  services.dbus.enable = true;  
  #xdg.portal = {
  #  enable = true;
  #};

}
