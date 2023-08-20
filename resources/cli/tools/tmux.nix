{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          #set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
        '';
      }
    ];
   
    extraConfig = ''
      # set is a alias of set-option

      # set screen-256 color
      set -g default-terminal "screen-256color"
      
      # change prefix key to C-a
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix
      
      # change pane split key
      unbind %
      bind | split-window -h
      unbind '"'
      bind - split-window -v
      
      
      # set keybind to resize pane
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r h resize-pane -L 5
      bind -r l resize-pane -R 5
      # back to orgin layout
      bind -r m resize-pane -Z
      
      # show time
      set -g status-interval 1
      set -g status-right "#[fg=red]#(awk '{print $1, $2, $3}' /proc/loadavg) #[fg=black]%Y-%m-%d %H:%M:%S"
      
      # set pane history number
      set -g history-limit 10000
      
      # enable mouse
      set -g mouse on
      
      # set window vi mode
      set-window-option -g mode-keys vi
      
      # use v and y to select and copy
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection
      
      
      # enable mouse drag to copy instead of going to the directly
      unbind -T copy-mode-vi MouseDragEnd1Pane
    '';
  };
}
