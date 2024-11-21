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
    "aimi@dell" = {
      system = "x86_64-linux";
      stateVersion = "24.05";
      modules = [
        ../shared/nixos/graphics/wm/river
        ../shared/nixos/graphics/apps
        ./aimi-dell
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
