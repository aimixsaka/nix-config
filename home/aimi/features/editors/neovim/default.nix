{ config, pkgs, lib, ... }:
{
  imports = [
    ./core
    ./ui.nix
    ./comment.nix
    ./nvim-tree.nix
    ./treesitter.nix
    ./autopairs.nix
    ./illuminate.nix
    ./impatient.nix
    ./lsp
  ];

  programs.neovim = {
    enable = true;

    # use nvim as default editor
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # Misc
      vim-surround
    ];

    extraConfig = {
      #viml = /* vim */ ''
      #'';

      lua = /* lua */ ''
        function add_sign(name, text)
          vim.fn.sign_define(name, { text = text, texthl = name, numhl = name})
        end

        add_sign("DiagnosticSignError", " ")
        add_sign("DiagnosticSignWarn", " ")
        add_sign("DiagnosticSignHint", "ﴞ ")
        add_sign("DiagnosticSignInfo", " ")

        local config = {
          virtual_text = false, -- disable virtual text
          signs = {
            active = signs, -- show signs
          },
          update_in_insert = true,
          underline = true,
          severity_sort = true,
          float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
          },
        }
	    vim.diagnostic.config(config)

	    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
              border = "rounded",
	    })
	    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	      border = "rounded",
	    })
      '';
    };
  };

  ## Lsp Server use pkgs
  home.packages = with pkgs; [
    gopls
    rnix-lsp
    rust-analyzer
    sumneko-lua-language-server

    ## Lsp Server use pkgs.nodePackages
    nodePackages.bash-language-server
    nodePackages.pyright
  ];

  #xdg.configFile."nvim/init.lua".onChange = ''
  #  XDG_RUNTIME_DIR=''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
  #  for server in $XDG_RUNTIME_DIR/nvim.*; do
  #    nvim --server $server --remote-send ':source $MYVIMRC<CR>' &
  #  done
  #'';

  xdg.desktopEntries = {
    nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "nvim %F";
      icon = "nvim";
      mimeType = [
        "text/english"
        "text/plain"
        "text/x-makefile"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-java"
        "text/x-moc"
        "text/x-pascal"
        "text/x-tcl"
        "text/x-tex"
        "application/x-shellscript"
        "text/x-c"
        "text/x-c++"
      ];
      terminal = true;
      type = "Application";
      categories = [ "Utility" "TextEditor" ];
    };
  };
}
