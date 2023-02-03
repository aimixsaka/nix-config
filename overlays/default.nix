{
  # overlay is a func, receive two params:
  # `final` and `prev` (or self and super)

  # Adds my custom packages
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # Modifies existing packages
  modifications = final: prev: {
    weechat = prev.weechat.override {
      configure = { availablePlugins, ... }: {
        scripts = with prev.weechatScripts; [
          weechat-matrix
          edit
        ];
      };
    };
    
    weechat-with-scripts = final.weechat;
  };
}

