{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    compose2nix
    docker-compose
  ];
}
