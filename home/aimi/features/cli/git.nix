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
      feature.manyFiles = true;
      init.defaultBranch = "main";
    };
    ignores = [ ".direnv" ];
  };
}
