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
  ];
}
