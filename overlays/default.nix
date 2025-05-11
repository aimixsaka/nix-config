{
  self,
  ...
}:
let
  npins-sources = (import ../npins);
in
{
  flake.overlays = {
    pkgs =
      final: prev:
      let
        pkgs = (import npins-sources.nixpkgs-release-24-11 { system = prev.stdenv.hostPlatform.system; });
      in
      import ../pkgs { inherit pkgs; };

    default =
      let
        overlays = [
          self.overlays.pkgs
        ];
      in
      (final: prev: prev.lib.composeManyExtensions overlays self prev);
  };
}
