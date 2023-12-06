{ lib
, pkgs
, config
, ...
}:

{
  programs = {
    ## fzf
    fzf = {
      enable = true;
      #enableZshIntegration = true;
      #changeDirWidgetCommand = "fd --type d";
      #defaultCommand = "fd --type f";
      #fileWidgetCommand = "fd --type f";
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
        bindkey -v
	setopt interactivecomments

        # env settings
        #ZSH_AUTOSUGGEST_MANUAL_REBIND=1;

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
        #bindkey -M emacs "^P" history-substring-search-up
        #bindkey -M emacs "^N" history-substring-search-down

        ## Vi
        #bindkey -M vicmd "k" history-substring-search-up
        #bindkey -M vicmd "j" history-substring-search-down

        ## system
        #bindkey "^[[A" history-substring-search-up
        #bindkey "^[[B" history-substring-search-down

        ## Emacs and Vi
        #for keymap in 'emacs' 'viins'; do
        #  bindkey "$terminfo[kcuu1]" history-substring-search-up
        #  bindkey "$terminfo[kcud1]" history-substring-search-down
        #done
        #unset keymap

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
        cl = "clear -x";
        ws = "cd ~/workspace";

        l = "ls --color=auto -l";
        ls = "ls --color=auto";
        lst = "ls -al --time=birth";

        del = "/usr/bin/env rm";
        sdel = "sudo del";

        # pacman;
        pas = "sudo pacman -S";
        pasi = "pacman -Si";
        pass = "pacman -Ss";
        passq = "sudo pacman -Ssq";
        paq = "pacman -Q";
        paqi = "pacman -Qi";
        paql = "pacman -Qil";
        paqs = "pacman -Qs";
        paqqs = "pacman -Qqs";
        paqo = "pacman -Qo";
        paqqo = "pacman -Qqo";
        paqqdt = "pacman -Qqdt";
        paqk = "pacman -Qk";
        paqkk = "pacman -Qkk";
        paclear = "sudo pacman -Rns \$(pacman -Qqdt)";
        paf = "sudo pacman -F";
        pau = "sudo pacman -Syu";
        par = "sudo pacman -Rns";

        # paru;
        prs = "paru -S";
        prss = "paru -Ss";
        prssq = "paru -Ssq";
        prsi = "paru -Si";
        prq = "paru -Q";
        prqi = "paru -Qi";
        prqs = "paru -Qs";
        prqqs = "paru -Qqs";
        prr = "paru -Rns";

        # systemd;
        sss = "sudo systemctl start ";
        sdr = "sudo systemctl daemon-reload";
        ssr = "sudo systemctl restart ";
        ssa = "systemctl status ";
        sse = "sudo systemctl enable ";
        sst = "sudo systemctl stop ";
        blc = "bluetoothctl connect ";
        sch = "systemctl hibernate";

        sua = "systemctl --user status";
        suss = "systemctl --user start";
        sust = "systemctl --user stop";
        sur = "systemctl --user restart";
        sudr = "systemctl --user daemon-reload";
        sue = "systemctl --user enable";
        suen = "systemctl --user enable --now";
        #vim = "vim -u ~/.vimrc_bak";

        # docker;
        drm = "docker rm";
        drmi = "docker rmi";
        dst = "docker stop";
        dss = "docker start";
        drs = "docker restart";
        di = "docker info";
        db = "docker build";
        dp = "docker ps";
        dpa = "docker ps -a ";
        dil = "docker image ls";

        # xray;
        xsr = "ssr xray.service nftables.service";
        #xst = "sst xray.service nftables.service";
        vre = "sudo $WORKDIR/xray/xray_tool.sh vre";
        vtp = "sudo $WORKDIR/xray/xray_tool.sh vtp";
        xre = "sudo $WORKDIR/xray/xray_tool.sh xre";
        xtp = "sudo $WORKDIR/xray/xray_tool.sh xtp";
        xinfo = "sudo $WORKDIR/xray/xray_tool.sh info";
        xst = "sudo $WORKDIR/xray/xray_tool.sh stop";
        xtohk = "sudo $WORKDIR/xray/xray_tool.sh xtohk";
        xtojp = "sudo $WORKDIR/xray/xray_tool.sh xtojp";

        # NetworkManager
        nwc = "nmcli device wifi connect";
        nwr = "nmcli device wifi rescan";
        nwl = "nmcli device wifi list";

	wineenv = "DISPLAY= WAYLAND_DISPLAY=wayland-1 WINE_PREFIX=/home/aimi/.local/share/wineprefixes/game";
      };
    };
  };
}
