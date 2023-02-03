{ pkgs, ... }: {
  home.packages = with pkgs; [
    #cargo
    #rustc
    rustup
    go
    lua
    python39
    jdk11
    nodejs
  ];
}
