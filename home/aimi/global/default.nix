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
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };


  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = [ "nix-command flakes" "repl-flake" ];
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


  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
