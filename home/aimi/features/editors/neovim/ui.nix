{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = alpha-nvim;
      type = "lua";
      config = /* lua */ ''
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
              "                                                     ",
              "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
              "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
              "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
              "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
              "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
              "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
              "                                                     ",
        }
        dashboard.section.header.opts.hl = "Title"

        dashboard.section.buttons.val = {
            dashboard.button( "n", " New file" , ":enew <BAR> startinsert <CR>"),
            dashboard.button( "e", " Explore", ":Explore<CR>"),
            dashboard.button( "g", " Git summary", ":Git | :only<CR>"),
            dashboard.button( "o", " Org capture" , ":cd ~/Documents/Org | :e Capture.org<CR>"),
            dashboard.button( "c", "  Nix config flake" , ":cd ~/Documents/NixConfig | :e flake.nix<CR>"),
            dashboard.button( "q", "  Quit nvim", ":qa<CR>"),
        }

        alpha.setup(dashboard.opts)
        vim.keymap.set("n", "<space>a", ":Alpha<CR>", { desc = "Open alpha dashboard" })
      '';
    }
    {
      plugin = lualine-nvim;
      type = "lua";
      config = /* lua */ ''
        local status_ok, lualine = pcall(require, "lualine")
                if not status_ok then
            error("Load [lualine] Failed!")
          return
        end
        
        local hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end
        
        local diagnostics = {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          sections = { "error", "warn" },
          symbols = { error = " ", warn = " " },
          colored = false,
          always_visible = true,
        }
        
        local diff = {
          "diff",
          colored = false,
          symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
          cond = hide_in_width,
        }
        
        local filetype = {
          "filetype",
          icons_enabled = false,
        }
        
        local location = {
          "location",
          padding = 0,
        }
        
        local spaces = function()
          return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
        end
        
        lualine.setup {
          options = {
            globalstatus = true,
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { "alpha", "dashboard" },
            always_divide_middle = true,
          },
          sections = {
            lualine_a = { "mode" },
            lualine_b = {"branch"},
            lualine_c = { diagnostics },
            lualine_x = { diff, spaces, "encoding", filetype },
            lualine_y = { location },
            lualine_z = { "progress" },
          },
        }
      '';
    }
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config = /* lua */ ''
        require('nvim-web-devicons').setup{}
      '';
    }
    {
      plugin = gitsigns-nvim;
      type = "lua";
      config = /* lua */ ''
        require('gitsigns').setup{
          signs = {
            add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
            change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
            delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          },
          signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
          watch_gitdir = {
            interval = 1000,
            follow_files = true,
          },
          attach_to_untracked = true,
          current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
          },
          sign_priority = 6,
          update_debounce = 100,
          status_formatter = nil, -- Use default
          preview_config = {
            -- Options passed to nvim_open_win
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
          },
        }
      '';
    }
  ];
}
