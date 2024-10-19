_:

{
  # nix-darwin configurations
  parts.darwinConfigurations.mt = {
    system = "x86_64-darwin";
    stateVersion = 4;
    modules = [ ];
  };
  parts.nixosConfigurations = {
    dell = {
      system = "x86_64-linux";
      stateVersion = "24.11";
      modules = [
        ./dell
      ];
    };
  };
}
