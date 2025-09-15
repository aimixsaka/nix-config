{ pkgs, ... }:

{
  home.packages = with pkgs; [
    trash-cli
  ];

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      nv = "nvim";
      ws = "cd ~/workspace";
      rm = "trash";
      del = "/usr/bin/rm";

      l = "ls -l";
      lst = "ls -al --time birth";
      lh = "ls -alh";

      # gdb
      gdb = "gdb -q";

      # del = "/usr/bin/env rm";
      # sdel = "sudo rm";

      # systemd
      sss = "sudo systemctl start ";
      sdr = "sudo systemctl daemon-reload";
      ssr = "sudo systemctl restart ";
      ssa = "systemctl status ";
      sse = "sudo systemctl enable ";
      ssd = "sudo systemctl disable";
      ssen = "sudo systemctl enable --now";
      ssdn = "sudo systemctl disable --now";
      sst = "sudo systemctl stop ";
      blc = "bluetoothctl connect ";
      sch = "systemctl hibernate";
      scs = "systemctl suspend";
      sct = "systemctl cat";

      sua = "systemctl --user status";
      suss = "systemctl --user start";
      sust = "systemctl --user stop";
      sur = "systemctl --user restart";
      sudr = "systemctl --user daemon-reload";
      sue = "systemctl --user enable";
      suen = "systemctl --user enable --now";
      #vim "vim -u ~/.vimrc_bak"

      # docker
      drm = "docker rm";
      drmi = "docker rmi";
      dst = "docker stop";
      dss = "docker start";
      drs = "docker restart";
      di = "docker info";
      db = "docker build";
      dp = "docker ps";
      dpa = "docker ps -a ";
      dil = "docker image ls";

      # NetworkManager
      nwc = "nmcli device wifi connect";
      nwr = "nmcli device wifi rescan";
      nwl = "nmcli device wifi list";
    };

    functions = {
      append_env = {
        description = "Append a new value to a PATH like environment variable if not exists";
        argumentNames = "env values";
        body = ''
          if test (count $env) -gt 0
              for value in $values
                  if not contains $value $$env
                      set -gx --path -a $env $value
                  end
              end
          else
              set -gx --path $env $values
          end
        '';
      };
      append_path = {
        description = "Append given args to PATH environment variable";
        body = "append_env PATH $argv";
      };
    };

    shellAbbrs = {
    };
    interactiveShellInit = ''
      ## disable greeting
      set -g fish_greeting ""

      function multicd
          echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
      end
      abbr --add dotdot --regex '^\.\.+$' --function multicd

      ### Promt
      function fish_prompt
          set_color --bold 00AFFC
          ## Don't need path abbr...
          printf '%s' (string replace '/home/aimi' '~' (pwd))
          #printf '%s' (prompt_pwd)
          set_color --bold EA76CB
          printf '%s' (fish_git_prompt)
          set_color --bold 5FD700
          printf '\n%sλ ' $level_prefix
          set_color normal
      end

      function fish_right_prompt
          set_color --bold B9AD87
          printf '%s@%s ' "$USER" "$hostname"
          set_color --bold 425D5D
          printf '%s' (date '+%H:%M:%S')
          set_color normal
      end
    '';
  };

  programs.autojump = {
    enable = true;
    enableFishIntegration = true;
  };
}
