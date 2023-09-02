{ 
  pkgs,
  ...
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
    
    # other
    git
    htop
    tree
    jq
    file
    wget

    ncdu

    cachix

    podman

    trash-cli

    # translate
    translate-shell
  ];

}
