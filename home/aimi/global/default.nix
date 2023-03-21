# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, pkgs, config, outputs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    ## For home.persistence
    inputs.impermanence.nixosModules.home-manager.impermanence

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    ## Overlay to use self-build packages
    overlays = builtins.attrValues outputs.overlays;

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      #allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-run"
        "steam-original"
        "qq"
        "feishu"
        #"idea-ultimate"
      ];
    };
  };


  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = [ "nix-command flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  # TODO: Set your username
  home = {
    username = lib.mkDefault "aimi";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";

    persistence = {
      "/persist/home/aimi" = {
        allowOther = true;
        directories = [
          "Documents"
          "Downloads"
          "Pictures"
          "Videos"
          "workspace"
        ];
      };
    };
  };


  # Enable home-manager 
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
