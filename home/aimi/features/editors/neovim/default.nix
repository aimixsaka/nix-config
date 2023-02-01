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

    plugins = with pkgs.vimPlugins; [
      ## VIM
      # show registers info
      vim-peekaboo
      # undo tree viewer
      vim-mundo


      ## NEOVIM
      # Misc
      vim-surround
    ];

    extraConfig = {
      viml = /* vim */ ''
        """"""""""""""""
        """ comm set """
        """"""""""""""""
        " To enabel netrw
        " set nocompatible
        set nocp 
        
        set hidden    " hide warn when change unsaved buffer
        
        set relativenumber
        set number
        
        " set indent
        filetype indent on
        set tabstop=4
        set shiftwidth=4
        set expandtab " transfer tab to space
        set autoindent
        
        " set nowrap
        set nowrap
        
        " set default split window position
        set splitright
        set splitbelow
        
        syntax enable " enalbe syntax hightlight
        
        " enable built-in plugin on filetype
        
        set showcmd
        
        " set times `u` can to undo changes
        set undolevels=1000
        filetype plugin on 
        
        " use ripgrep when using `:vim` or `:grep`
        set grepprg=rg\ --vimgrep\ --smart-case\ --follow
        
        " set undodir(where save the .undo file)
        " and set undofile(means starting undo func on the file you save and quit,
        " while not get 'Already at oldest change'
        " normally you can use `wundo! xxx.undo` to create an undo file and `rundo
        " xxx.undo` to read undo history when reopen a closed 
        " and the folloing will automatically do this
        set undodir=~/.vim/undo_dir
        set undofile
        
        " all smallcase -> ignorecase
        " one char is upercase -> noignorecase
        set ignorecase smartcase
        
        " set foldmethod 
        set foldmethod=syntax
        
        " set keymap timeout
        set timeoutlen=400
        
        
        " paste mode (can prevent indent wrong when paste)
        set pastetoggle=<F3>
        
        
        """""""""""""""""
        """ key map """
        """""""""""""""""
        let mapleader = " "
        noremap <silent> <leader> <Nop>
        
        " convinient save and quit
        nnoremap <silent> <leader>w :w<CR>     
        nnoremap <silent> <leader>wq :wq<CR>
        nnoremap <silent> <leader>q :q<CR>
        nnoremap <silent> <leader>qa :wqall<CR>
        
        nnoremap <silent> <leader>b :Buffers<CR>
        nnoremap <silent> <C-f> :Files<CR>
        nnoremap <silent> <leader>f :Rg<CR>
        nnoremap <silent> <leader>/ :BLines<CR>
        nnoremap <silent> <leader>' :Marks<CR>
        nnoremap <silent> <leader>g :Commits<CR>
        nnoremap <silent> <leader>H :Helptags<CR>
        nnoremap <silent> <leader>hh :History<CR>
        nnoremap <silent> <leader>h: :History:<CR>
        nnoremap <silent> <leader>h/ :History/<CR>
        
        " set undo savepoint before truly use <C-u> and <C-w>
        inoremap <C-u> <C-g>u<C-u>
        inoremap <C-w> <C-g>u<C-w>
        
        " resize window
        nnoremap <leader>h :vertical resize +3<CR>
        nnoremap <leader>l :vertical resize -3<CR>
        nnoremap <leader>j :resize -3<CR>
        nnoremap <leader>k :resize +3<CR>
        
        
        """""""""""""""
        """ autocmd """
        """""""""""""""
        " auto update ctags after `w`
        autocmd BufWritePost *.[rs|py|go|java] silent !ctags -R 
      '';
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
