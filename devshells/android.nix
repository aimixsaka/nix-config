{ inputs, ... }:

{
  perSystem =
    {
      config,
      system,
      pkgs,
      ...
    }:
    {
      _module.args.pkgs = import inputs.unstable {
        inherit system;
        config = {
          android_sdk.accept_license = true;
          allowUnfree = true;
        };
      };

      devShells.android =
        with pkgs;
        mkShell {
          ANDROID_SDK_ROOT = "${androidenv.androidPkgs.androidsdk}/libexec/android-sdk";
          buildInputs = [
            flutter324
            androidenv.androidPkgs.androidsdk
            jdk17
          ];
        };
    };

}
