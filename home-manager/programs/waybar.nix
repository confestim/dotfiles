{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 0;

        modules-left = [
          "niri/workspaces"
        ];

        modules-center = [ "clock" ];

        modules-right = [
          "wireplumber"
          "battery"
          "backlight"
          "idle_inhibitor"
          "network"
          "bluetooth"
          "tray"
        ];

        clock = {
          format = "{:%a %d.%m.%Y | %H:%M}";
        };

        wireplumber = {
          format = "󰕾 {volume}%";
          format-muted = "󰖁  Muted";
          max-volume = 100;
          scroll-step = 5;
          on-click = "pavucontrol";
        };

        memory = {
          interval = 30;
          format = "  {used:0.1f}G";
        };

        temperature = {
          format = " | {temperatureC}°C |";
        };

        network = {
          format = "";
          format-ethernet = "󰈀";
          format-wifi = "{icon}";
          format-disconnected = "󰈂";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname}";
          tooltip-format-disconnected = "Disconnected";
        };

        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };

        battery = {
          format = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "󰂄  {capacity}%";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        backlight = {
          format = "{icon}  {percent}%";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
        };
      };
    };

    style = ''
      * {
        font-family: "Agave Nerd Font", "Symbols Nerd Font", sans-serif;
        font-size: 13px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: #282a36;
        color: #f8f8f2;
      }

      #workspaces button,
      #clock,
      #battery,
      #backlight,
      #temperature,
      #idle_inhibitor,
      #network,
      #wireplumber,
      #bluetooth,
      #tray,
      #custom-platform-profile {
        padding: 0 15px;
        color: #f8f8f2;
        background: transparent;
      }

      #workspaces button.active {
        color: #f8f8f2;
        text-decoration: underline;
      }
    '';
  };
}
