{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.file.".config/niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "us,bg"
                variant ",phonetic"
                options "grp:alt_shift_toggle"
            }
        }

        touchpad {
            tap
            natural-scroll
        }

        mouse {
                accel-speed -0.2
                accel-profile "flat" // Optional: disables acceleration
            }

        trackpoint {
        }

        warp-mouse-to-focus
        focus-follows-mouse max-scroll-amount="0%"
    }
    debug {
       render-drm-device "/dev/dri/card1"
    }

    output "DP-1" {
        mode "1920x1080@143.855"
        scale 1
        focus-at-startup
        transform "normal"
        position x=0 y=0
    }

    output "HDMI-A-1" {
        mode "1920x1080@74.986"
        scale 1
        position x=1920 y=0
        background-color "#282A36"
    }

    cursor {
        xcursor-theme "catppuccin-mocha-lavender-cursors"
        xcursor-size 24
    }

    layer-rule {
        match namespace="^swww-daemon$"
        place-within-backdrop true
    }

    layout {
        gaps 8
        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        focus-ring {
            width 4
            active-color "#6272a4"
        }

        border {
            off
        }

        shadow {
            softness 30
            spread 5
            offset x=0 y=5
            color "#0007"
        }

        struts {
        }
    }

    spawn-at-startup "noctalia"

    screenshot-path null

    animations {
        slowdown 1.0

        window-open {
            duration-ms 120
            curve "linear"

            custom-shader r"
float easeInExpo(float t) {
    return t == 0.0 ? 0.0 : pow(2.0, 10.0 * (t - 1.0));
}

float easeOutExpo(float t) {
    return t == 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * t);
}

float easeOutQuad(float t) {
    return 1.0 - (1.0 - t) * (1.0 - t);
}

float easeInQuad(float t) {
    return t * t;
}

float easeOutCubic(float t) {
    float f = t - 1.0;
    return f * f * f + 1.0;
}

float easeInCubic(float t) {
    return t * t * t;
}

float centerGradient(float x) {
    x = x * 2.0;
    return x < 1.0 ? x : 2.0 - x;
}

vec2 scaleUV(vec2 uv, vec2 scale) {
    return (uv - 0.5) / scale + 0.5;
}

vec4 open_color(vec3 coords_geo, vec3 size_geo) {
    vec2 uv = (niri_geo_to_tex * coords_geo).xy;

    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        return vec4(0.0);
    }

    float t = easeOutQuad(niri_clamped_progress);

    float x = mix(0.1, 1.0, easeOutCubic(niri_clamped_progress));
    float y = easeInQuad(niri_clamped_progress);

    vec2 suv = scaleUV(uv, vec2(x, y));

    if (suv.x < 0.0 || suv.x > 1.0 || suv.y < 0.0 || suv.y > 1.0) {
        return vec4(0.0);
    }

    float tb = centerGradient(suv.y);
    float lr = centerGradient(suv.x);

    float tbMask = smoothstep(0.0, 0.10, tb);
    float lrMask = smoothstep(0.0, 0.10, lr);

    float mask = tbMask * lrMask;

    vec3 tint = vec3(0.55, 0.82, 1.0);
    vec3 color = mix(tint, vec3(1.0), t);

    float tintAmt = smoothstep(0.0, 0.8, t);

    vec3 rgb = mix(tint, color, tintAmt);
    float alpha = mask * t;

    vec4 wColor = texture2D(niri_tex, suv);

    return mix(vec4(rgb, alpha * wColor.a), wColor, easeInExpo(niri_clamped_progress));
}
            "
        }

        window-close {
            duration-ms 100
            curve "linear"

            custom-shader r"
float easeInExpo(float t) {
    return t == 0.0 ? 0.0 : pow(2.0, 10.0 * (t - 1.0));
}

float easeOutExpo(float t) {
    return t == 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * t);
}

float easeOutQuad(float t) {
    return 1.0 - (1.0 - t) * (1.0 - t);
}

float easeInQuad(float t) {
    return t * t;
}

float easeOutCubic(float t) {
    float f = t - 1.0;
    return f * f * f + 1.0;
}

float easeInCubic(float t) {
    return t * t * t;
}

float centerGradient(float x) {
    x = x * 2.0;
    return x < 1.0 ? x : 2.0 - x;
}

vec2 scaleUV(vec2 uv, vec2 scale) {
    return (uv - 0.5) / scale + 0.5;
}

vec4 close_color(vec3 coords_geo, vec3 size_geo) {
    if (coords_geo.x < 0.0 || coords_geo.x > 1.0 ||
        coords_geo.y < 0.0 || coords_geo.y > 1.0) {
        return vec4(0.0);
    }

    vec2 uv = (niri_geo_to_tex * coords_geo).xy;

    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        return vec4(0.0);
    }

    float t = easeOutQuad(1.0 - niri_clamped_progress);

    float x = mix(0.1, 1.0, easeOutCubic(1.0 - niri_clamped_progress));
    float y = easeInQuad(1.0 - niri_clamped_progress);

    vec2 suv = scaleUV(uv, vec2(x, y));

    if (suv.x < 0.0 || suv.x > 1.0 || suv.y < 0.0 || suv.y > 1.0) {
        return vec4(0.0);
    }

    float tb = centerGradient(suv.y);
    float lr = centerGradient(suv.x);

    float tbMask = smoothstep(0.0, 0.10, tb);
    float lrMask = smoothstep(0.0, 0.10, lr);

    float mask = tbMask * lrMask;

    vec3 tint = vec3(0.55, 0.82, 1.0);
    vec3 color = mix(tint, vec3(1.0), t);

    float tintAmt = smoothstep(0.0, 0.8, t);

    vec3 rgb = mix(tint, color, tintAmt);
    float alpha = mask * t;

    vec4 wColor = texture2D(niri_tex, suv);

    return mix(vec4(rgb, alpha * wColor.a), wColor, easeInExpo(1.0 - niri_clamped_progress));
}
            "
        }

        window-resize {
            duration-ms 80
            curve "linear"

            custom-shader r"
const float PI = 3.141592653589793;

float hash21(vec2 p) {
    p = fract(p * vec2(127.1, 311.7));
    p += dot(p, p + 34.345);
    return fract(p.x * p.y);
}

float noise2(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);

    float a = hash21(i);
    float b = hash21(i + vec2(1.0, 0.0));
    float c = hash21(i + vec2(0.0, 1.0));
    float d = hash21(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x)
        + (c - a) * u.y * (1.0 - u.x)
        + (d - b) * u.x * u.y;
}

vec3 randomRGB(vec2 uv, float t) {
    float r = noise2(uv * 1.3 + vec2(13.0, 71.0) + t * 120.0);
    float g = noise2(uv * 1.7 + vec2(37.0, 19.0) + t * 90.0);
    float b = noise2(uv * 1.1 + vec2(91.0, 53.0) + t * 140.0);
    return vec3(r, g, b);
}

vec4 resize_color(vec3 coords_geo, vec3 size_geo) {
    if (coords_geo.x < 0.0 || coords_geo.x > 1.0 ||
        coords_geo.y < 0.0 || coords_geo.y > 1.0) {
        return vec4(0.0);
    }

    vec2 uv = coords_geo.xy;
    float t = niri_clamped_progress;

    float pulse = sin(t * PI);

    vec2 base = uv * size_geo.xy;

    vec3 coarse = randomRGB(floor(base * 0.12), t);
    vec3 mid    = randomRGB(base * 0.35, t);
    vec3 fine   = randomRGB(base * 0.9,  t);

    vec3 snow = mix(coarse, mid, 0.5);
    snow = mix(snow, fine, 0.35);

    snow -= 0.5;

    float streak = sin(uv.y * size_geo.y * 0.6 + t * 80.0) * 0.15;
    snow += vec3(streak);

    vec3 tint = vec3(
        sin(t * 37.0) * 0.2,
        sin(t * 53.0) * 0.2,
        sin(t * 29.0) * 0.2
    );

    snow += tint;

    float strength = 0.55;
    vec4 color = vec4(snow, 1.0) * strength * pulse;
    color.a = 1.0;

    float alpha = length(color) * 1.2;

    vec3 coords_tex_next = niri_geo_to_tex_next * coords_geo;
    vec4 wColor = texture2D(niri_tex_next, coords_tex_next.st);

    return mix(wColor, color, pulse * 0.5);
}
            "
        }
    }
    window-rule {
        match app-id="scrcpy"
        open-floating true
    }

    window-rule {
        match app-id=r#"^org\.wezfurlong\.wezterm$"#
        default-column-width {}
    }

    window-rule {
        match app-id="VirtualBox"
        open-floating true
    }

    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        open-floating true
    }

    window-rule {
        clip-to-geometry true
    }
    clipboard {
      disable-primary
    }
    hotkey-overlay {
      skip-at-startup
    }

    binds {
        Mod+Shift+Slash { show-hotkey-overlay; }

        Mod+Return hotkey-overlay-title="Open a Terminal: kitty" { spawn "kitty"; }
        Mod+Shift+Return { spawn "kitten quick-access-terminal";}
        Mod+Space hotkey-overlay-title="Open Launcher: noctalia" { spawn "noctalia" "msg" "panel-toggle" "launcher"; }
        Mod+A hotkey-overlay-title="Open Launcher: noctalia" { spawn "noctalia" "msg" "panel-toggle" "launcher"; }
        Super+Shift+L hotkey-overlay-title="Lock the Screen: swaylock" { spawn "swaylock"; }
        Mod+F hotkey-overlay-title="Open a Firefox" { spawn "firefox"; }
        Mod+M hotkey-overlay-title="Open a Thunderbird" { spawn "thunderbird"; }
        Mod+D hotkey-overlay-title="Open a Desktop Environment: vesktop" { spawn "env" "ELECTRON_OZONE_PLATFORM_HINT=wayland" "vesktop"; }
        Mod+E hotkey-overlay-title="Open a Code Editor: codium" { spawn "env" "ELECTRON_OZONE_PLATFORM_HINT=wayland" "codium"; }
        Mod+Shift+E hotkey-overlay-title="Open a Sublime Text: subl" { spawn "subl"; }
        Mod+Shift+F hotkey-overlay-title="Open a File Manager: nautilus" { spawn "nautilus"; }
        Mod+Shift+S hotkey-overlay-title="Session Menu: noctalia" { spawn "noctalia" "msg" "panel-toggle" "session"; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
        XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl" "set" "10%+"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "10%-"; }

        Mod+O repeat=false { toggle-overview; }
        Mod+W { close-window; }

        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }

        Mod+Ctrl+Left  { move-column-left; }
        Mod+Ctrl+Down  { move-window-down; }
        Mod+Ctrl+Up    { move-window-up; }
        Mod+Ctrl+Right { move-column-right; }
        Mod+Ctrl+H     { move-column-left; }
        Mod+Ctrl+J     { move-window-down; }
        Mod+Ctrl+K     { move-window-up; }
        Mod+Ctrl+L     { move-column-right; }

        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        Mod+Shift+Left  { focus-monitor-left; }
        Mod+Shift+Down  { focus-monitor-down; }
        Mod+Shift+Up    { focus-monitor-up; }
        Mod+Shift+Right { focus-monitor-right; }
        Mod+Shift+H     { focus-monitor-left; }
        Mod+Shift+J     { focus-monitor-down; }
        Mod+Shift+K     { focus-monitor-up; }
        Mod+Shift+L     { focus-monitor-right; }

        Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

        Mod+Page_Down      { focus-workspace-down; }
        Mod+Page_Up        { focus-workspace-up; }
        Mod+U              { focus-workspace-down; }
        Mod+I              { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
        Mod+Ctrl+U         { move-column-to-workspace-down; }
        Mod+Ctrl+I         { move-column-to-workspace-up; }

        Mod+Shift+Page_Down { move-workspace-down; }
        Mod+Shift+Page_Up   { move-workspace-up; }
        Mod+Shift+U         { move-workspace-down; }
        Mod+Shift+I         { move-workspace-up; }

        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

        Mod+WheelScrollRight      { focus-column-right; }
        Mod+WheelScrollLeft       { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft  { move-column-left; }

        Mod+Shift+WheelScrollDown      { focus-column-right; }
        Mod+Shift+WheelScrollUp        { focus-column-left; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }

        Mod+Tab { focus-workspace-previous; }

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }

        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }
        Mod+B { maximize-column; }
        Mod+Shift+B { fullscreen-window; }

        Mod+Ctrl+F { expand-column-to-available-width; }
        Mod+C { center-column; }
        Mod+Ctrl+C { center-visible-columns; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }

        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Mod+V       { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }

        Mod+Q { toggle-column-tabbed-display; }

        Mod+S { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }

        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

        Mod+Shift+Q { quit; }
        Ctrl+Alt+Delete { quit; }

        Mod+Shift+P { power-off-monitors; }
    }

    overview {
        workspace-shadow {
            off
        }
    }

    environment {
        ELECTRON_OZONE_PLATFORM_HINT "wayland"
        QT_STYLE_OVERRIDE "kvantum-dark"
        WAYLAND_DISPLAY "wayland-1"
        XDG_SESSION_TYPE "wayland"
        XDG_CURRENT_DESKTOP "niri"
        GDK_BACKEND "wayland"
    }

    spawn-at-startup "dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP" "XDG_SESSION_TYPE"
    spawn-at-startup "bash" "-c" "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE && systemctl --user start graphical-session.target"
    spawn-at-startup "systemctl" "--user" "import-environment" "PATH" "XDG_DATA_DIRS"
    '';
}
