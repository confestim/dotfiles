{ inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Dracula";
      };

      shell = {
        telemetry_enabled = false;
        avatar_path = "/home/boyan/.face";

        animation = {
          enabled = true;
          speed = 1.0;
        };

        shadow = {
          direction = "bottom_right";
          alpha = 0.55;
        };

        panel = {
          launcher_placement = "centered";
          launcher_categories = true;
          launcher_show_icons = true;
          launcher_sort_by_usage = true;
          launcher_session_search = true;
          control_center_placement = "attached";
          wallpaper_placement = "attached";
          session_placement = "attached";
        };

        session = {
          actions = [
            { action = "lock"; shortcut = "1"; }
            { action = "logout"; shortcut = "2"; }
            { action = "lock_and_suspend"; shortcut = "3"; }
            { action = "reboot"; shortcut = "4"; }
            { action = "shutdown"; shortcut = "5"; }
          ];
        };
      };

      keybinds = {
        validate = [ "return" "kp_enter" ];
        cancel = [ "escape" ];
        left = [ "left" ];
        right = [ "right" ];
        up = [ "up" ];
        down = [ "down" ];
      };

      bar = {
        order = [ "main" ];
        main = {
          position = "top";
          thickness = 34;
          background_opacity = 1.0;
          radius = 12;
          margin_edge = 4;
          widget_spacing = 9;
          padding = 12;
          border = "outline";
          border_width = 0;

          start = [
            "sysmon-cpu"
            "active_window"
            "battery"
          ];
          center = [
            "clock"
            "workspaces"
          ];
          end = [
            "tray"
            "notifications"
            "volume"
            "control-center"
            "session"
          ];
        };
      };

      widget = {
        clock = {
          format = "{:%H:%M}\n{:%a, %b %d}";
          tooltip_format = "{:%H:%M, %A %B %d}";
        };
        workspaces = {
          display = "id";
          labels_only_when_occupied = true;
          focused_color = "primary";
          occupied_color = "secondary";
          empty_color = "secondary";
        };
        sysmon-cpu = {
          type = "sysmon";
          stat = "cpu_usage";
        };
        active_window = {
          display = "icon_and_text";
          title_scroll = "on_hover";
          max_length = 145;
        };
        battery = {
          display_mode = "icon";
          show_label = true;
        };
        tray = {
          drawer = true;
          drawer_columns = 3;
        };
        notifications = {
          hide_when_no_unread = false;
        };
        volume = {
          show_label = true;
          scroll_step = 5;
        };
        control-center = {
          glyph = "noctalia";
        };
        session = {
          glyph = "shutdown";
        };
      };

      dock = {
        enabled = false;
      };

      notification = {
        enable_daemon = true;
        show_app_name = true;
        position = "top_right";
        background_opacity = 0.97;
        offset_x = 20;
        offset_y = 8;
        collapse_on_dismiss = true;
      };

      osd = {
        position = "top_right";
        orientation = "horizontal";
        background_opacity = 0.97;
        offset_x = 20;
        offset_y = 8;
        kinds = {
          volume = true;
          brightness = true;
          wifi = true;
          bluetooth = true;
          nightlight = true;
          dnd = true;
          lock_keys = true;
          keyboard_layout = true;
        };
      };

      nightlight = {
        enabled = true;
        auto_schedule = true;
        temperature_day = 6500;
        temperature_night = 4000;
      };

      location = {
        name = "Groningen";
        auto_locate = false;
        weather_enabled = true;
        weather_show_effects = true;
        use_fahrenheit = false;
        use_12hour_format = false;
        first_day_of_week = 1;
      };

      wallpaper = {
        enabled = true;
        directory = "/home/boyan/Pictures/Wallpapers";
        fill_mode = "crop";
        fill_color = "#111111";
        transition = [ "fade" "wipe" "disc" "stripes" "zoom" "honeycomb" ];
        transition_duration = 1500;
        edge_smoothness = 0.3;
      };

      system = {
        monitor = {
          cpu_warning_threshold = 80;
          cpu_critical_threshold = 90;
          gpu_warning_threshold = 80;
          gpu_critical_threshold = 90;
          mem_warning_threshold = 80;
          mem_critical_threshold = 90;
          enable_dgpu_monitoring = true;
        };
      };

      idle = {
        enabled = false;
      };

      hooks = {
        enabled = false;
      };

      brightness = {
        brightness_step = 5;
        enforce_minimum = true;
        enable_ddc_support = false;
      };
    };
  };
}
