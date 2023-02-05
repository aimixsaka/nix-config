{ config, pkgs, lib, ... }:
{
  programs.neovim.extraConfig = {
    lua = /* lua */ ''
      local opt = vim.opt 

      -- line numbers
      opt.relativenumber = true 
      opt.number = true
      
      -- tabs & indent
      opt.tabstop = 4
      opt.shiftwidth = 4
      opt.expandtab = true
      opt.autoindent = true
      
      -- line wrapping
      opt.wrap = false
      
      -- search settings 
      opt.ignorecase = true
      opt.smartcase = true
      
      -- cusor line
      opt.cursorline = true
      
      -- appearance
      opt.termguicolors = true
      opt.background = "dark"
      opt.signcolumn = "yes"
      
      -- backspace
      opt.backspace = { "indent", "eol", "start" }

      -- connect to systemc clipboard
      opt.clipboard:append { "unnamedplus"} 
      
      -- original window position will be when split windows
      opt.splitright = true
      opt.splitbelow = true
      
      -- make `-` to be a part of a word in neovim
      -- means `some-test` is a `w` in neovim
      opt.iskeyword:append { "-" }
      
      -- time to wait for a mapped sequence to complete (in milliseconds)
      opt.timeoutlen = 600
      
      -- enable persistent undo
      opt.undofile = true
    '';  
  };
}
