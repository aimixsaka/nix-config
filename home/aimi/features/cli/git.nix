{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      graph = "log --decorate --oneline --graph";
    };
    userName = "aimisaka";
    userEmail = "aimixsaka@gmail.com";
    extraConfig = {
      core = {
        editor = "vim";
      };
      pull.rebase = true;
      feature.manyFiles = true;
      init.defaultBranch = "main";
    };
    ignores = [ ".direnv" ];
  };
}
