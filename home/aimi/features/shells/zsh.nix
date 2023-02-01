{ lib, pkgs, config, ... }:
{
  # Default shell
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    history = {
     size = 10000;
    };

    # Set alias
    shellAliases = {
      rm = "trash";
      lst = "ls -al --time=birth";
      ws = "cd ~/workspace";
    };

    dotDir = ".config/zsh";
 
    initExtra = ''
      set -o vi
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "amuse";
    };
    
    ## Just not that support well(or may be myself's fool)
    #initExtraFirst = ''
    #  # p10k instant prompt
    #  P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
    #  [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    #  POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
    #'';
    #
    #initExtra = ''
    #  P10ZSH="$HOME/zsh/.p10k.zsh"
    #  [[ ! -f "$P10KZSH" ]] || source "$P10KZSH"
    #'';

    #zplug = {
    #  enable = true;
    #  zplugHome = "${config.home.homeDirectory}/zsh/.zplug";
    #  plugins = [
    #    { 
    #      name = "zsh-users/zsh-autosuggestions";
    #    } 
  
    #    { 
    #      name = "romkatv/powerlevel10k"; 
    #      tags = [ as:theme depth:1 ];
    #    } 
    #  ];
    #};
  };
}
