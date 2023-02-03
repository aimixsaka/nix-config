{ config, ... }:
{
  imports = [
    ./cmp.nix
    ./lspconfig.nix
    ./lspsaga.nix
  ];
}
