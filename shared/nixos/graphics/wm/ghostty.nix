{
  programs.ghostty = {
    enable = true;
    settings = {
      gtk-single-instance = true;
      theme = "catppuccin-latte";
      font-family = "monospace";
      font-size = 16;
      window-decoration = false;
      keybind = "ctrl+left_bracket=text:\\x1b";
    };
  };
}
