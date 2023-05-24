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
    ./gonvim.nix
    ./autosave.nix
    ./markdown-preview.nix
  ];

  programs.neovim = {
    enable = true;

    # use nvim as default editor
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # Misc
      vim-surround
      vim-tmux-navigator
    ];

    extraConfig = {
      #viml = /* vim */ ''
      #'';

      lua = /* lua */ ''
        local signs = {
          { name = "DiagnosticSignError", text = " " },
          { name = "DiagnosticSignWarn", text = " " },
          { name = "DiagnosticSignHint", text = " " },
          { name = "DiagnosticSignInfo", text = " " },
        }

        -- use iparis to ensure the order is right
	    for _, sign in ipairs(signs) do
	      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	    end

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


  xdg.mimeApps.defaultApplications = {
    "text/english" = [ "nvim.desktop" ];
    "text/plain" = [ "nvim.desktop" ];
    "text/x-makefile" = [ "nvim.desktop" ];
    "text/x-c++hdr" = [ "nvim.desktop" ];
    "text/x-c++src" = [ "nvim.desktop" ];
    "text/x-chdr" = [ "nvim.desktop" ];
    "text/x-csrc" = [ "nvim.desktop" ];
    "text/x-java" = [ "nvim.desktop" ];
    "text/x-moc" = [ "nvim.desktop" ];
    "text/x-pascal" = [ "nvim.desktop" ];
    "text/x-tcl" = [ "nvim.desktop" ];
    "text/x-tex" = [ "nvim.desktop" ];
    "application/x-shellscript" = [ "nvim.desktop" ];
    "text/x-c" = [ "nvim.desktop" ];
    "text/x-c++" = [ "nvim.desktop" ];
  };
} 
