{
  self,
  ...
}:
let
  npins-sources = (import ../npins);
in
{
  flake.overlays = {
    my-pkgs =
      final: prev:
      let
        pkgs = (import npins-sources.nixpkgs-release-24-11 { system = prev.stdenv.hostPlatform.system; });
      in
      import ../pkgs { inherit pkgs; };

    my-rime-data = (
      final: prev: {
        rime-data = prev.rime-shuangpin-fuzhuma;
      }
    );

    default =
      let
        overlays = [
          self.overlays.my-pkgs
          self.overlays.my-rime-data
        ];
      in
      (final: prev: prev.lib.composeManyExtensions overlays self prev);
  };
}
