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
        community_palette = "Peche";
        wallpaper_scheme = "m3-tonal-spot";
        templates = {
          builtin_ids = [ "niri" ];
          community_ids = [ "fuzzel" "discord" ];
        };
      };

      shell = {
        telemetry_enabled = false;
        avatar_path = "/home/boyan/.face";
        corner_radius_scale = 0.15;
        niri_overview_type_to_launch_enabled = true;
        password_style = "random";
        screen_time_enabled = true;
        settings_show_advanced = true;

        animation = {
          enabled = true;
          speed = 1.0;
        };

        shadow = {
          direction = "bottom_right";
          alpha = 0.55;
        };

        panel = {
          launcher_placement = "attached";
          launcher_categories = true;
          launcher_compact = true;
          launcher_show_icons = true;
          launcher_sort_by_usage = true;
          launcher_session_search = true;
          control_center_placement = "attached";
          wallpaper_placement = "attached";
          session_placement = "attached";
        };

        screen_corners = {
          enabled = true;
          size = 16;
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
          thickness = 37;
          background_opacity = 1.0;
          radius = 12;
          margin_edge = 8;
          margin_ends = 8;
          margin_opposite_edge = 3;
          widget_spacing = 18;
          padding = 33;
          border = "primary";
          border_width = 0;
          shadow = false;
          font_family = "Noto Sans Symbols";
          font_weight = 400;

          start = [
            "sysmon-cpu"
            "ram"
            "active_window"
            "battery"
          ];
          center = [
            "clock"
            "workspaces"
          ];
          end = [
            "recorder"
            "tray"
            "volume"
            "session"
            "keyboard_layout"
            "control-center"
          ];
        };
      };

      widget = {
        clock = {
          format = "{:%H:%M}";
          scale = 1.1;
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
        ram = {
          type = "sysmon";
          stat = "ram_usage";
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
          glyph = "settings";
        };
        session = {
          glyph = "shutdown";
        };
        recorder = {
          type = "noctalia/screen_recorder:recorder";
        };
        cat = {
          type = "noctalia/bongocat:cat";
        };
      };

      dock = {
        enabled = false;
        auto_hide = true;
        background_opacity = 1.0;
        radius = 0;
        reserve_space = false;
        shadow = false;
        show_dots = true;
        show_instance_count = false;
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
        address = "Groningen";
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
        fill_color = "#282a36";
        transition = [ "fade" "wipe" "disc" "stripes" "zoom" "honeycomb" ];
        transition_duration = 1500;
        transition_on_startup = true;
        edge_smoothness = 0.3;
        default = {
          path = "/home/boyan/Pictures/Wallpapers/Waves 1.png";
        };
        last = {
          path = "/home/boyan/Pictures/Wallpapers/Waves 1.png";
        };
        monitors = {
          DP-1 = {
            path = "/home/boyan/Pictures/Wallpapers/Waves 1.png";
          };
          HDMI-A-1 = {
            path = "/home/boyan/Pictures/Wallpapers/Waves 1.png";
          };
        };
      };

      plugins = {
        enabled = [ "noctalia/bongocat" "noctalia/screen_recorder" ];
      };

      plugin_settings = {
        "noctalia/screen_recorder" = {
          video_source = "region";
        };
      };

      desktop_widgets = {
        schema_version = 2;
        widget_order = [
          "desktop-widget-0000000000000001"
          "desktop-widget-0000000000000002"
          "desktop-widget-0000000000000003"
        ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        widget = {
          "desktop-widget-0000000000000001" = {
            box_height = 208.0;
            box_width = 336.0;
            cx = 1272.0;
            cy = 492.0;
            output = "HDMI-A-1";
            rotation = 0.0;
            type = "weather";
            settings = {
              background = false;
              shadow = false;
              show_forecast = true;
            };
          };
          "desktop-widget-0000000000000002" = {
            box_height = 128.0;
            box_width = 1776.0;
            cx = 984.0;
            cy = 972.0;
            output = "HDMI-A-1";
            rotation = 0.0;
            type = "audio_visualizer";
            settings = {
              background = false;
              bands = 32;
              show_when_idle = true;
            };
          };
          "desktop-widget-0000000000000003" = {
            box_height = 272.0;
            box_width = 416.0;
            cx = 656.0;
            cy = 468.0;
            output = "HDMI-A-1";
            rotation = 0.0;
            type = "clock";
            settings = {
              background = false;
              circle = true;
              clock_style = "analog";
              color = "secondary";
            };
          };
        };
      };

      lockscreen_widgets = {
        enabled = false;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@DP-1"
          "lockscreen-login-box@HDMI-A-1"
        ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        widget = {
          "lockscreen-login-box@DP-1" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 960.0;
            cy = 961.0;
            output = "DP-1";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_login_button = true;
            };
          };
          "lockscreen-login-box@HDMI-A-1" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 960.0;
            cy = 961.0;
            output = "HDMI-A-1";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_login_button = true;
            };
          };
        };
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
        behavior_order = [ "lock" "screen-off" "lock-and-suspend" ];
        behavior = {
          lock = {
            action = "lock";
            enabled = false;
            timeout = 600;
          };
          "lock-and-suspend" = {
            action = "lock_and_suspend";
            enabled = false;
            timeout = 900;
          };
          "screen-off" = {
            action = "screen_off";
            enabled = true;
            timeout = 660;
          };
        };
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
