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

  cfg = config.parts.darwinConfigurations;
  configurations = builtins.mapAttrs (_: value: value._darwin) cfg;

  darwinOpts =
    { config, name, ... }:
    {
      options = {
        system = lib.mkOption {
          type = types.enum [ "x86_64-darwin" ];
          description = "System architecture for the configuration.";
        };

        stateVersion = lib.mkOption {
          type = types.int;
          description = "nix-darwin state version, See: https://daiderd.com/nix-darwin/manual/index.html#opt-system.stateVersion .";
        };

        modules = lib.mkOption {
          type = types.listOf types.unspecified;
          description = "List of nix-darwin modules to be included as configuration.";
        };

        _darwin = lib.mkOption {
          type = types.unspecified;
          readOnly = true;
          description = "Composed final nix-darwin configuration, used by config.flake.darwinConfigurations .";
        };
      };

      config._darwin = withSystem config.system (
        ctx:
        inputs.darwin.lib.darwinSystem {
          #inherit inputs;
          inherit (ctx) system;

          # inputs as sepecialArgs as we use
          # `imports = [ inputs.xxx ];`
          # see: https://github.com/NixOS/nixpkgs/blob/8a4ba48accedd56f7585ccd452a47be6f80da60e/lib/modules.nix#L135-L140
          specialArgs = {
            inherit inputs;
          };

          modules = config.modules ++ [

            ../../shared/nix-darwin
            # Shared packages over nix-darwin and nixos
            ../../shared/full-packages.nix
            (
              { pkgs, ... }:
              {
                # set nix config
                inherit (ctx) nix;
                nixpkgs = removeAttrs ctx.nixpkgs [ "hostPlatform" ];
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
  options.parts.darwinConfigurations = lib.mkOption {
    type = types.attrsOf (types.submodule darwinOpts);
  };

  config.flake.darwinConfigurations = configurations;
}
