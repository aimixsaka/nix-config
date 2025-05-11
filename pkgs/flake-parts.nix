{
  perSystem =
    { system, ... }:
    let
      npins-sources = (import ../npins);
      pkgs-24-11 = (import npins-sources.nixpkgs-release-24-11 { inherit system; });
    in
    {
      packages = import ./. { pkgs = pkgs-24-11; };
    };
}
