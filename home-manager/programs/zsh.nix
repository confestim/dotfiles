{ config, pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    completionInit = ''
  autoload -Uz compinit
  fpath=(''${(ou)fpath}) # Stable fpath order hence consistent cache hit.
  if [[ ! -s ''${ZDOTDIR:-$HOME}/.zcompdump || \
        /run/current-system/sw -nt ''${ZDOTDIR:-$HOME}/.zcompdump ]]; then
    compinit
    zcompile ''${ZDOTDIR:-$HOME}/.zcompdump 2>/dev/null
  else
    compinit -C
  fi
'';

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
      {
        name = "dracula";
        file = "dracula.zsh-theme";
        src = pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "zsh";
          rev = "master";
          sha256 = "1si457c4x11bz54lhpqlgzkd29pvwm8bzr6gizs03xpwf0gx8wxs";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "z" ];
    };

    shellAliases = {
      ls = "eza";
      ll = "eza -la";
      la = "eza -a";
      lt = "eza --tree";
      update = "home-manager switch";
    };

    initContent = ''
      # fzf integration
      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

      echo "⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
      echo "⠀⠀⠀⠀⢰⣿⡿⠗⠀⠠⠄⡀⠀⠀⠀⠀"
      echo "⠀⠀⠀⠀⡜⠁⠀⠀⠀⠀⠀⠈⠑⢶⣶⡄"
      echo "⢀⣶⣦⣸⠀⢼⣟⡇⠀⠀⢀⣀⠀⠘⡿⠃"
      echo "⠀⢿⣿⣿⣄⠒⠀⠠⢶⡂⢫⣿⢇⢀⠃⠀"
      echo "⠀⠈⠻⣿⣿⣿⣶⣤⣀⣀⣀⣂⡠⠊⠀⠀"
      echo "⠀⠀⠀⠃⠀⠀⠉⠙⠛⠿⣿⣿⣧⠀⠀⠀"
      echo "⠀⠀⠘⡀⠀⠀⠀⠀⠀⠀⠘⣿⣿⡇⠀⠀"
      echo "⠀⠀⠀⣷⣄⡀⠀⠀⠀⢀⣴⡟⠿⠃⠀⠀"
      echo "⠀⠀⠀⢻⣿⣿⠉⠉⢹⣿⣿⠁⠀⠀⠀⠀"
      echo "⠀⠀⠀⠀⠉⠁⠀⠀⠀⠉⠁⠀⠀⠀⠀⠀"
    '';
  };
}
