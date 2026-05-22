{ config, pkgs, lib, ... }: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    completionInit = ''
      autoload -Uz compinit
      fpath=(''${(ou)fpath})
      compinit -C
      if [[ ! -s ''${ZDOTDIR:-$HOME}/.zcompdump || \
            /run/current-system/sw -nt ''${ZDOTDIR:-$HOME}/.zcompdump ]]; then
        (compinit && zcompile ''${ZDOTDIR:-$HOME}/.zcompdump 2>/dev/null &)
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

    shellAliases = {
      ls = "eza";
      ll = "eza -la";
      la = "eza -a";
      lt = "eza --tree";
      update = "home-manager switch";
      # git aliases (previously from oh-my-zsh git plugin)
      g = "git";
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gd = "git diff";
      gl = "git pull";
      gp = "git push";
      gst = "git status";
      glog = "git log --oneline --graph --decorate";
    };

    initContent = ''
      # fzf integration
      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

      # sudo plugin: Esc-Esc to prepend sudo
      sudo-command-line() {
        [[ -z $BUFFER ]] && zle up-history
        if [[ $BUFFER == sudo\ * ]]; then
          LBUFFER="''${LBUFFER#sudo }"
        else
          LBUFFER="sudo $LBUFFER"
        fi
      }
      zle -N sudo-command-line
      bindkey '\e\e' sudo-command-line

      # Show nix-shell packages in prompt
      if [[ -n "$IN_NIX_SHELL" ]]; then
        nix_pkgs="''${NIX_SHELL_PACKAGES:-$name}"
        RPROMPT="%F{6}[nix: ''${nix_pkgs}]%f''${RPROMPT:+ $RPROMPT}"
      fi

      # Random ASCII art of hostname
      if command -v figlet &>/dev/null; then
        fontdir="$(figlet -I2)"
        hostname="$(hostname)"
        while IFS= read -r fontpath; do
          font="$(basename "$fontpath" .flf)"
          out="$(figlet -f "$font" -w 80 "$hostname" 2>/dev/null)"
          lines="$(echo "$out" | wc -l)"
          if [[ -n "$out" && $lines -le 7 && $lines -ge 3 ]]; then
            echo "$out"
            break
          fi
        done < <(find "$fontdir" -name "*.flf" ! -name "demo_*" ! -name "chart*" ! -name "clb*" ! -name "clr*" | shuf)
      fi
    '';
  };
}
