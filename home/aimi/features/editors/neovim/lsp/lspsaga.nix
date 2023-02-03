{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # LspSaga
    {
      plugin = lspsaga-nvim-original;
      type = "lua";
      config = /* lua */ ''
        -- LspSaga 
	    local status_saga_ok, lspsaga = pcall(require, "lspsaga")
	    if not status_saga_ok then
	      error("Load [lspsaga] Failed!")
	      return
	    end
        lspsaga.setup({})


        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }
        
        -- Lspsaga keybinds
        keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)                       -- show definition, references
        keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)            -- got to declaration
        keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>", opts)
        keymap("n", "pd", "<cmd>Lspsaga peek_definition<CR>", opts)                  -- see definition and make edits in window
        keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)         -- go to implementation
        keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)              -- see available code actions
        keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)                   -- smart rename
        keymap("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)     -- show  diagnostics for line
        keymap("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)   -- show diagnostics for cursor
        keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)             -- jump to previous diagnostic in buffer
        keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)             -- jump to next diagnostic in buffer
        keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)                         -- show documentation for what is under cursor
        keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)                   -- see outline on right hand side
        keymap({"n", "t"}, "<leader>ft", "<cmd>Lspsaga term_toggle<CR>", opts)
      '';
    }
  ];
}
