{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    # shells
    bash 
    zsh
    
    # editor
    vim
    neovim
    
    # tools
    git

    # network
    nftables
    xray
    v2raya

    # trash
    trash-cli
  ];
}
