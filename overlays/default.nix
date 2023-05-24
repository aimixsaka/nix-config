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

    #nvim-treesitter-tmp = prev.vimPlugins.nvim-treesitter.overrideAttrs (_: rec {
    #  version = "2023-4-26";
    #  src = prev.fetchFromGitHub {
    #   owner = "nvim-treesitter";
    #   repo = "nvim-treesitter";
    #   rev = "82bcd8483e0b802bd5f639046c88aecfddbab508";
    #   sha256 = "";
    #  }; 
    #});
  };
}

