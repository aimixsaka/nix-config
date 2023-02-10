{ pkgs, ... }: {
  home.packages = with pkgs; [
    #cargo
    #rustc
    #rustup

    # use rust nightly for rust os development
    # contains cargo rustc rust-analyzer, ... 
    rustLatest

    go
    lua
    python39
    jdk11
    nodejs
  ];
}
