{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    megatools
    compose2nix
    docker-compose
  ];
}
