{
  pkgs ?
    import <nixpkgs> {
      config.android_sdk.accept_license = true;
    },
}: let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [
      "33"
      "34"
      "35"
    ];
    abiVersions = ["armeabi-v7a" "arm64-v8a"];
    includeNDK = true;
  };

  androidSdk = androidComposition.androidsdk;
in
  pkgs.mkShell rec {
    name = "android-dev-env";
    packages = [androidSdk pkgs.android-studio];

    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
    ANDROID_NDK_ROOT = "${ANDROID_SDK_ROOT}/ndk-bundle";
  }
