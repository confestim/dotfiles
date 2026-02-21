{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    zplug = {
      enable = true;
      plugins = [
        {
          name = "dracula/zsh";
          tags = [ "as:theme" ];
        }
      ];
    };

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
    zprof.enable = true;
    initExtraFirst = ''
      DISABLE_AUTO_UPDATE="true"
      DISABLE_MAGIC_FUNCTIONS="true"
      DISABLE_COMPFIX="true"
    '';
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
