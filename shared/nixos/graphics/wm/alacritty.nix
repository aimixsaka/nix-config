{
  lib,
  ...
}:
{
  programs.alacritty = {
    enable = true;
    #theme = "catppuccin_latte";

    settings = {
      window = {
        dynamic_padding = true;
        opacity = 1.0;
      };

      scrolling = {
        history = 10000;
        multiplier = 10;
      };

      font = {
        #normal.family = "monospace";
        size = lib.mkOverride 70 16;
      };

      selection = {
        semantic_escape_chars = '',│`|:"' ()[]{}<>	'';
        save_to_clipboard = true;
      };

      general = {
        live_config_reload = true;
      };

      keyboard.bindings = [
        {
          key = "[";
          mods = "Control";
          chars = "\\u001b";
        }
      ];
    };
  };
}
