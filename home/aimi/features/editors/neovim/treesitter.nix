{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin =  (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars));
      type = "lua";
      config = /* lua */ ''
        local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    error("Load [treesitter] Failed!")
    return
end

-- configure treesitter
treesitter.setup({
    -- enable syntax highlighting
    highlight = {
        enable = true,
    },
    -- enable indentation
    indent = { enable = true },
    -- enable autotagging (w/ nvim-ts-autotag plugin)
    autotag = { enable = true },
})
      '';
    }
  ];
}
