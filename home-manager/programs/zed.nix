{ config, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "dracula"
      "nix"
      "haskell"
      "toml"
      "markdown-oxide"
    ];

    userSettings = {
      theme = {
        mode = "dark";
        dark = "Dracula";
        light = "One Light";
      };

      buffer_font_family = "Fira Code";
      buffer_font_size = 18;
      buffer_font_features = { calt = true; };

      ui_font_size = 16;

      autosave = { after_delay = { milliseconds = 1000; }; };
      format_on_save = "off";
      show_whitespaces = "all";
      wrap_guides = [ 80 100 120 ];

      git = {
        inline_blame = { enabled = true; };
      };

      terminal = {
        font_family = "Agave Nerd Font";
        font_size = 19;
        shell = { program = "zsh"; };
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      languages = {
        Python = {
          language_servers = [ "pyright" "!pylsp" ];
        };
        Nix = {
          language_servers = [ "nil" "!nixd" ];
        };
        Haskell = {
          language_servers = [ "haskell-language-server" ];
        };
      };
    };
  };
}
