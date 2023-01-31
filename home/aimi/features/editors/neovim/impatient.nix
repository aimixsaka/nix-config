{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = impatient-nvim;
      type = "lua";
      config = /* lua */ ''
        local status_ok, impatient = pcall(require, "impatient")
        if not status_ok then
          error("Load [impatient] Failed!")
          return
        end

        impatient.enable_profile()
      '';
    }
  ];
}
