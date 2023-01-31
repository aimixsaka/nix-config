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
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;

    extraConfig = {
      #viml = /* vim */ ''
      #  "Use system clipboard
      #  set clipboard=unnamedplus
      #  "Use truecolor
      #  set termguicolors

      #  "Set fold level to highest in file
      #  "so everything starts out unfolded at just the right level
      #  augroup initial_fold
      #    autocmd!
      #    autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))
      #  augroup END

      #  "Tabs
      #  set tabstop=4 "4 char-wide tab
      #  set expandtab "Use spaces
      #  set softtabstop=0 "Use same length as 'tabstop'
      #  set shiftwidth=0 "Use same length as 'tabstop'
      #  "2 char-wide overrides
      #  augroup two_space_tab
      #    autocmd!
      #    autocmd FileType json,html,htmldjango,hamlet,nix,scss,typescript,php,haskell,terraform setlocal tabstop=2
      #  augroup END

      #  "Set tera to use htmldjango syntax
      #  augroup tera_htmldjango
      #    autocmd!
      #    autocmd BufRead,BufNewFile *.tera setfiletype htmldjango
      #  augroup END

      #  "Options when composing mutt mail
      #  augroup mail_settings
      #    autocmd FileType mail set noautoindent wrapmargin=0 textwidth=0 linebreak wrap formatoptions +=w
      #  augroup END

      #  "Fix nvim size according to terminal
      #  "(https://github.com/neovim/neovim/issues/11330)
      #  augroup fix_size
      #    autocmd VimEnter * silent exec "!kill -s SIGWINCH" getpid()
      #  augroup END

      #  "Line numbers
      #  set number relativenumber

      #  "Scroll up and down
      #  nmap <C-j> <C-e>
      #  nmap <C-k> <C-y>

      #  "Buffers
      #  nmap <C-l> :bnext<CR>
      #  nmap <C-h> :bprev<CR>
      #  nmap <C-q> :bdel<CR>

      #  "Loclist
      #  nmap <space>l :lwindow<cr>
      #  nmap [l :lprev<cr>
      #  nmap ]l :lnext<cr>

      #  nmap <space>L :lhistory<cr>
      #  nmap [L :lolder<cr>
      #  nmap ]L :lnewer<cr>

      #  "Quickfix
      #  nmap <space>q :cwindow<cr>
      #  nmap [q :cprev<cr>
      #  nmap ]q :cnext<cr>

      #  nmap <space>Q :chistory<cr>
      #  nmap [Q :colder<cr>
      #  nmap ]Q :cnewer<cr>

      #  "Make
      #  nmap <space>m :make<cr>

      #  "Grep (replace with ripgrep)
      #  nmap <space>g :grep<space>
      #  if executable('rg')
      #      set grepprg=rg\ --vimgrep
      #      set grepformat=%f:%l:%c:%m
      #  endif

      #  "Close other splits
      #  nmap <space>o :only<cr>

      #  "Sudo save
      #  cmap w!! w !sudo tee > /dev/null %
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

    plugins = with pkgs.vimPlugins; [
      # Misc
      vim-surround
    ];
  };

  ## Lsp Server
  home.packages = with pkgs; [
    gopls
    rust-analyzer
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
