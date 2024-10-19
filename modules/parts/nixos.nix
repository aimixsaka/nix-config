{
  config,
  lib,
  inputs,
  withSystem,
  ...
}:

let
  inherit lib;
  inherit (lib) types;

  cfg = config.parts.nixosConfigurations;
  configurations = builtins.mapAttrs (_: value: value._nixos) cfg;

  nixosOpts =
    { config, name, ... }:
    {
      options = {
        server = lib.mkEnableOption "Host is a headless server configuration.";

        system = lib.mkOption {
          type = types.enum [
            "x86_64-linux"
            "x86_64-darwin"
          ];
          description = "System architecture for the configuration.";
        };

        stateVersion = lib.mkOption {
          type = types.str;
          description = "NixOS state version, changing this value DOES NOT update your system.";
        };

        modules = lib.mkOption {
          type = types.listOf types.unspecified;
          description = "List of NixOS modules to be included as configuration.";
        };

        _nixos = lib.mkOption {
          type = types.unspecified;
          readOnly = true;
          description = "Composed final NixOS configuration, used by config.flake.darwinConfigurations .";
        };
      };

      config._nixos = withSystem config.system (
        ctx:
        inputs.nixpkgs.lib.nixosSystem {
          #inherit inputs;
          inherit (ctx) system;

          # inputs as sepecialArgs as we use
          # `imports = [ inputs.xxx ];`
          # see: https://github.com/NixOS/nixpkgs/blob/8a4ba48accedd56f7585ccd452a47be6f80da60e/lib/modules.nix#L135-L140
          specialArgs = {
            inherit inputs;
          };

          modules = config.modules ++ [
            ../nixos

            ../../shared/nixos
            (
              { pkgs, ... }:
              {
                # set nix config
                inherit (ctx) nix nixpkgs;
                _module.args = ctx.extraModuleArgs;
                networking.hostName = name;
                system.stateVersion = config.stateVersion;
                environment.systemPackages = ctx.basePackagesFor pkgs;
              }
            )
          ];
        }
      );
    };
in
{
  # it seems submodule's `config` arg is isolated from upper module's config arg :-/
  options.parts.nixosConfigurations = lib.mkOption {
    type = types.attrsOf (types.submodule nixosOpts);
  };

  config.flake.nixosConfigurations = configurations;
}
