{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "Agave Nerd Font Mono";
      size = 15;
    };

    # Use themeFile instead of theme
    themeFile = "Dracula";

    settings = {
      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;

      # Window layout
      remember_window_size = true;
      initial_window_width = 640;
      initial_window_height = 400;
      window_border_width = "0.5pt";
      window_margin_width = 0;
      window_padding_width = 0;

      # Tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "fade";

      # Cursor
      cursor_shape = "block";
      cursor_blink_interval = -1;

      # Scrollback
      scrollback_lines = 2000;

      # Mouse
      mouse_hide_wait = 3;
      url_style = "curly";
      detect_urls = true;

      # Terminal bell
      enable_audio_bell = true;
      visual_bell_duration = 0;
      window_alert_on_bell = true;

      # Advanced
      shell = ".";
      editor = ".";
      close_on_child_death = false;
      allow_remote_control = false;
      term = "xterm-kitty";
    };

    keybindings = {
      # Clipboard
      "kitty_mod+c" = "copy_to_clipboard";
      "kitty_mod+v" = "paste_from_clipboard";

      # Scrolling
      "kitty_mod+up" = "scroll_line_up";
      "kitty_mod+down" = "scroll_line_down";
      "kitty_mod+page_up" = "scroll_page_up";
      "kitty_mod+page_down" = "scroll_page_down";
      "kitty_mod+home" = "scroll_home";
      "kitty_mod+end" = "scroll_end";

      # Windows
      "kitty_mod+enter" = "new_window";
      "kitty_mod+w" = "close_window";
      "kitty_mod+]" = "next_window";
      "kitty_mod+[" = "previous_window";

      # Tabs
      "kitty_mod+right" = "next_tab";
      "kitty_mod+left" = "previous_tab";
      "kitty_mod+t" = "new_tab";
      "kitty_mod+q" = "close_tab";

      # Layouts
      "kitty_mod+l" = "next_layout";

      # Font sizes
      "kitty_mod+equal" = "change_font_size all +2.0";
      "kitty_mod+minus" = "change_font_size all -2.0";
      "kitty_mod+backspace" = "change_font_size all 0";

      # Miscellaneous
      "kitty_mod+f11" = "toggle_fullscreen";
      "kitty_mod+f5" = "load_config_file";
      "kitty_mod+delete" = "clear_terminal reset active";
    };

    extraConfig = ''
      # Modifier key
      kitty_mod ctrl+shift
    '';
  };

}
