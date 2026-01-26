{ config, pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    
    settings = {
      main = {
        terminal = "${pkgs.alacritty}/bin/alacritty";
        layer = "overlay";
        font = "Agave Nerd Font:size=13";
        dpi-aware = "yes";
        icon-theme = "Papirus-Dark";
        width = 40;
        horizontal-pad = 20;
        vertical-pad = 10;
        inner-pad = 10;
      };
      
      colors = {
        # Dracula theme colors
        background = "282a36ff";
        text = "f8f8f2ff";
        match = "8be9fdff";
        selection = "44475aff";
        selection-text = "f8f8f2ff";
        selection-match = "8be9fdff";
        border = "bd93f9ff";
      };
      
      border = {
        width = 2;
        radius = 8;
      };
    };
  };
}
