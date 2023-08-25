{ pkgs
, ...
}:

{
  # useful system level tools
  environment.systemPackages = with pkgs; [
    # shells
    bash 
    zsh
    
    # editor
    vim
    neovim
    
    # tools
    git
    podman

    # network
    nftables
    xray
    clash-verge

    # trash
    trash-cli
    tree
  ];

  services.dae = {
    enable = true;
  };
}
