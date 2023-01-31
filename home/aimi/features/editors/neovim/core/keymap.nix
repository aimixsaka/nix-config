{ config, lib, ... }:
{
  programs.neovim.extraConfig = {
    lua = /* lua */ ''
      -- Shorten function name
      local keymap = vim.keymap.set
      -- Silent keymap option
      local opts = { silent = true }
      
      keymap("", "<Space>", "<Nop>", opts)
      vim.g.mapleader = " "
      
      -- Modes
      --   normal_mode = "n",
      --   insert_mode = "i",
      --   visual_mode = "v",
      --   visual_block_mode = "x",
      --   term_mode = "t",
      --   command_mode = "c",
      
      
      -------------------------
      ---  general keympas ---
      -------------------------
      keymap("n", "<leader>nh", ":nohl<CR>", opts)   -- use space+nh to un highlight search
      
      keymap("n", "x", '"_x', opts)                  -- use "_x to replace x (means use "_ register)
                                               -- "_ is the `blackhole` register, then p will not paste deleted char
      
      keymap("n", "<leader>+", "<C-a>", opts)        -- self-increment
      keymap("n", "<leader>-", "<C-x>", opts)        -- self-decrement
      
      keymap("n", "<leader>w", ":w<CR>", opts)       -- convinient save and quit
      keymap("n", "<leader>wq", ":wq<CR>", opts)
      keymap("n", "<leader>q", ":q<CR>", opts)
      keymap("n", "<leader>qa", ":wqall<CR>", opts)
      
      -------------------------
      --- window management ---
      -------------------------
      keymap("n", "<leader>sv", "<C-w>v", opts)      -- split window vertically
      keymap("n", "<leader>sh", "<C-w>s", opts)      -- split window horizontally
      keymap("n", "<leader>se", "<C-w>=", opts)      -- split window equal width
      keymap("n", "<leader>sx", ":close<CR>", opts)  -- close current split window
      
      
      -------------------------
      ---  tab management   ---
      -------------------------
      keymap("n", "<leader>to", ":tabnew<CR>", opts)   -- open new tab
      keymap("n", "<leader>tx", ":tabclose<CR>", opts, opts) -- close new tab
      keymap("n", "<leader>tn", ":tabn<CR>", opts)     -- go to next tab
      keymap("n", "<leader>tp", ":tabp<CR>", opts)     -- go to previous tab
      
      -------------------------
      ---  plugin keymaps  ----
      -------------------------
      keymap("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- maximize current window and come back
      
      -- nvim-tree
      keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts) -- toggle file explorer
      
      -- restart lsp server
      keymap("n", "<leader>rs", ":LspRestart<CR>", opts)    -- mapping to restart lsp if necessary
      
      -- Comment
      keymap("n", "<leader>/", "<cmd>lua require('Comment.api', opts).toggle.linewise.current()<CR>", opts)
      keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api", opts).toggle.linewise(vim.fn.visualmode())<CR>', opts)
      
      -- md preview
      keymap("n", "<leader>m", ":MarkdownPreviewToggle<CR>", opts)
    '';
  };
}
