{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    plugins = with pkgs; [ ];

    extraConfig = ''
      # set screen-256color
      #set -g default-terminal "screen-256color"
      set -g default-terminal "xterm-256color"
      set-option -sa terminal-features ',xterm-256color:RGB'

      # change prefix key to C-a
      unbind C-b
      set -g prefix C-q
      bind C-q send-prefix

      # change pane split key 
      unbind %
      bind | split-window -h
      unbind '"'
      bind - split-window -v

      # set keybind to resize pane
      bind -r C-j resize-pane -D 5
      bind -r C-k resize-pane -U 5
      bind -r C-l resize-pane -R 5
      bind -r C-h resize-pane -L 5
      # back to origin layout
      bind -r C-m resize-pane -Z

      # move between panes
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R
      bind -r h select-pane -L

      set -g mouse on

      # set window vi mode 
      # (if set EDITOR or VISUAL to vi(or vim nvi), vi mode is automatically enalbed
      set-window-option -g mode-keys vi

      # use v and y to select and copy
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      # enable mouse drag to copy 
      unbind -T copy-mode-vi MouseDragEnd1Pane

      # set history limit
      set -g history-limit 99999999

      # prevent vim <ESC> delay in tmux
      set -sg escape-time 0


      # theme
      #set -g status-style bg=#585b70
      # set -g status-style bg=#3f36f5
      set -g status-style bg='#0166FF'
      # set -g status-style fg=default
      set -g mode-style "fg=#f5c2e7 bg=#585b70 bold"
      #
      # # keymap for change pane
      # bind -n C-h select-pane -L
      # bind -n C-l select-pane -R
      # bind -n C-j select-pane -D
      # bind -n C-k select-pane -U
    '';
  };
}
