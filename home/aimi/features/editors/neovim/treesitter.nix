{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # bracket rainbow
    nvim-ts-rainbow 
    # `<div + >` -> `<div></div>` (auto close tag for html, ...)
    nvim-ts-autotag

    {
      plugin =  (nvim-treesitter.withPlugins (p: [
        p.c
        p.cpp
        p.java
        p.python
        p.go
        p.rust
        p.nix
        p.bash

        p.html
        p.markdown
        p.yaml
        p.json
        p.json5
        p.toml
      ]));

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
          -- enable rainbow
          rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
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
