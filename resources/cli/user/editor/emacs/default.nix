{ 
  pkgs,
  config,
  ...
}:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;

    extraPackages = epkgs: with epkgs; [
      # scheme      
      geiser-guile
    ];

    extraConfig = builtins.readFile ./init.el;
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    #defaultEditor = true;
    socketActivation.enable = true;
  };
}
