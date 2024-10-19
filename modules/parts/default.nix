{ self, inputs, ... }:

{
  imports = [
    ./home-manager.nix
    ./nix-darwin.nix
    ./nixos.nix
  ];

  perSystem =
    {
      lib,
      pkgs,
      system,
      inputs',
      ...
    }:
    {
      # options sent to child modules
      _module.args = rec {
        nix = import ../../shared/nix-settings.nix { inherit inputs; };

        nixpkgs = {
          config = lib.mkForce {
            allowBroken = true;
            allowUnfree = true;
          };

          hostPlatform = system;

          overlays = lib.mkForce [ self.overlays.default ];
        };

        # Extra arguments passed to the module system for nix-darwin, NixOS, and home-manager
        # later will set `_module.args = ctx.extraModules` for nix-darwin, NixOS module...
        extraModuleArgs = {
          inherit inputs' system;
          inputs = lib.mkForce inputs;

          /*
            One can access these nixpkgs branches in the following form:

            `branches.stable.mpd'
            `branches.master.linuxPackages_xanmod'
          */
          branches =
            let
              pkgsFrom =
                branch: system:
                import branch {
                  inherit system;
                  inherit (nixpkgs) config overlays;
                };
            in
            {
              master = pkgsFrom inputs.master system;
              unstable = pkgsFrom inputs.unstable system;
              stable = pkgsFrom inputs.stable system;
            };
        };

        # NixOS and nix-darwin base environment.systemPackages
        basePackagesFor =
          pkgs:
          lib.attrValues {
            inherit (pkgs)
              curl
              fd
              ripgrep
              man-pages-posix
              wget
              git
              vim
              ;

            home-manager = inputs'.home.packages.home-manager.override { path = "${inputs.home}"; };

            man-pages =
              if pkgs.stdenv.isLinux then pkgs.man-pages else inputs'.nixpkgs-f2k.packages.man-pages-xnu;

            gnu-coreutils = if pkgs.stdenv.isLinux then pkgs.coreutils else pkgs.coreutils-prefixed;
          };
      };

      formatter = pkgs.nixfmt-rfc-style;
    };
}
