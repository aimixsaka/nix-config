{
  inputs,
  ...
}:

{
  parts.homeConfigurations = {
    "aimi@mt" = {
      system = "x86_64-darwin";
      stateVersion = "24.05";
      modules = [ ];
    };
    "aimi@dell" = rec {
      system = "x86_64-linux";
      stateVersion = "24.05";
      modules = [
        { home.packages = [ inputs.nixvim.packages.${system}.full ]; }
        ../shared/nixos/graphics/wm/river
        ../shared/nixos/graphics/apps
        ../shared/nixos/graphics/dev
        ./aimi-dell
      ];
    };
    "aimi@lecoo" = {
      system = "x86_64-linux";
      stateVersion = "24.05";
      modules = [
        ../shared/nixos/graphics/wm/niri
        ../shared/nixos/graphics/apps
        ../shared/nixos/graphics/dev
        ../shared/nixos/graphics/theme.nix
        ../shared/home-manager/shells/fish.nix
        ../shared/home-manager/editors/helix.nix
        ./aimi-lecoo
      ];
    };
    "aimi@m2-air" = rec {
      system = "aarch64-linux";
      stateVersion = "25.05";
      modules = [
        { home.packages = [ inputs.nixvim.packages.${system}.full ]; }
        ../shared/nixos/graphics/wm/river
        ../shared/nixos/graphics/wm/river/hidpi.nix
        ../shared/nixos/graphics/apps
        ../shared/nixos/graphics/dev
        ../shared/home-manager/shells/fish.nix
        ./aimi-m2-air
      ];
    };
    "aimi@host" = rec {
      system = "x86_64-linux";
      stateVersion = "24.05";
      modules = [
        { home.packages = [ inputs.nixvim.packages.${system}.full ]; }
      ];
    };
  };
}
