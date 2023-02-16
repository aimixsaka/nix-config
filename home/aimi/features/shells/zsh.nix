{ lib, pkgs, config, ... }:
{
  programs = {
    bash.enable = true; # make some script can load hm-sessions.

    ## fzf
    fzf = {
      enable = true;
      enableZshIntegration = true;
      changeDirWidgetCommand = "fd --type d";
      defaultCommand = "fd --type f";
      fileWidgetCommand = "fd --type f";
    };

    # Default shell
    zsh = {
      enable = true;
      ## Conflict with plugins bellow
      #enableAutosuggestions = true;
      #enableSyntaxHighlighting = true;
      enableCompletion = true;
      autocd = true;
      history = {
       extended = true;
       save = 100000;
       size = 100000;
       path = "${toString config.xdg.configHome}/zsh/zsh_history";
      };

      dotDir = ".config/zsh";

      # add *?_. etc to word chars
      localVariables = {
        WORDCHARS = "*?_-.[]~&;!#$%^(){}<>";
      };
 
      initExtra = with pkgs; '' 
        # vi mode
        set -o vi

        # env settings
        ZSH_AUTOSUGGEST_MANUAL_REBIND=1;

        # set path for cargo bin
        PATH="/home/aimi/.cargo/bin:$PATH"

        ## opts
        # Remove older cmmand from the history if a duplicate is to be adde        # Remove older cmmand from the history if a duplicate is to be added.
        setopt HIST_IGNORE_ALL_DUPS

        if [ -f "''${ZDOTDIR:-~}/.p10k.zsh" ]; then
          source ''${ZDOTDIR:-~}/.p10k.zsh
        fi
        
        source ${zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
        source ${zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
        source ${zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        source ${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        source ${zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

        # Emacs
        bindkey -M emacs "^P" history-substring-search-up
        bindkey -M emacs "^N" history-substring-search-down

        # Vi
        bindkey -M vicmd "k" history-substring-search-up
        bindkey -M vicmd "j" history-substring-search-down

        # system
        bindkey "^[[A" history-substring-search-up
        bindkey "^[[B" history-substring-search-down

        # Emacs and Vi
        for keymap in 'emacs' 'viins'; do
          bindkey "$terminfo[kcuu1]" history-substring-search-up
          bindkey "$terminfo[kcud1]" history-substring-search-down
        done
        unset keymap

      '';

     #loginExtra = ''
     #  # Execute code that does not affect the current session in the background.
     #  {
     #    # Compile the completion dump to increase startup speed.
     #    zcompdump="''${ZDOTDIR:-$HOME}/.zcompdump"
     #    if [[ -s "$zcompdump" && (! -s "''${zcompdump}.zwc" || "$zcompdump" -nt "''${zcompdump}.zwc") ]]; then
     #      zcompile "$zcompdump"
     #    fi
     #  } &!
     #'';

      # Set alias
      shellAliases = {
        cl = "clear";
        rm = "trash";

        l = "ls --color=auto -l";
        ls = "ls --color=auto";
        lst = "ls -al --time=birth";

        ws = "cd ~/workspace";
      };

      ## Too heavy
      #oh-my-zsh = {
      #  enable = true;
      #  plugins = [ "git" ];
      #  theme = "amuse";
      #};
      
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
  };

  home.packages = with pkgs; [ 
    fd
  ];
}
