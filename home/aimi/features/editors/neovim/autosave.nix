{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = auto-save-nvim;
      type = "lua";
      config = /* lua */ ''
        local status, auto_save = pcall(require, "auto-save")
        if not status then
          error("Load [auto-save] Failed!")
          return
        end
        
        -- configure auto-save-nvim
        auto_save.setup({
        })
      '';
    }
  ];
}
