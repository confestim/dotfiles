from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.config import ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import datetime

mod = "mod4"
terminal = "terminology"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod, "shift", "control"], "Return", lazy.spawn("cool-retro-term"), desc="Launch *COOOL* terminal"),    


    Key([mod], "f", lazy.spawn("firefox"), desc="Launch firefox"),
    Key([mod], "n", lazy.spawn("nautilus"), desc="Launch visual file explorer"),
    Key([mod], "e", lazy.spawn("codium"), desc="Launch VSCodium"),
    Key([mod], "m", lazy.spawn("claws-mail"), desc="Launch Mail Client"),
    Key([mod], "d", lazy.spawn("discord"), desc="Launch Discord  "),
    Key([mod], "q", lazy.spawn("joplin-desktop"), desc="Joplin"),
    Key([mod], "t", lazy.spawn("authy"), desc="Authy"),
    Key([mod, "control"], "w", lazy.spawn("walc"), desc="Whatsapp"),
    Key([mod], "p", lazy.spawn("screengrab"), desc="Screenshot"),
    Key([mod], "c", lazy.spawn("terminator -e calcurse"), desc="Calendar"),
# Func control
#	XF86AudioLowerVolume
    Key([],"XF86AudioMicMute", lazy.spawn("amixer sset Capture toggle")), 
    Key([],"XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 5%+")), 
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 5%-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer sset Master toggle")), 
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 10%-")), 
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s 10%+")), 
    Key([mod], "l", lazy.spawn("xscreensaver-command -lock")),
    Key([],"XF86Calculator", lazy.spawn("speedcrunch")), 


    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # mod1 + shift + letter of group = move focused window to group
            Key([mod, "control"], i.name, lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name)),
        ]
    )
# Scratchpad section
groups.append(ScratchPad("scratchpad", [
    DropDown("term", terminal, width=0.4, height=0.5, x=0.3, y=0.3, opacity=1),
    DropDown("authy", "authy", width=0.4, height=0.5, x=0.4, y=0.2, opacity=1),
    DropDown("alsa", "terminology -e alsamixer", width=0.4, height=0.5, x=0.3, y=0.3, opacity=1),
    DropDown("quick", f"terminology -e nvim ~/Documents/Notes/{datetime.datetime.now().strftime('%d%m%y%H')}.md",width=0.4, height=0.5, x=0.3, y=0.3, opacity=1),
    DropDown("vifm", "terminology -e vifm", width=0.4, height=0.5, x=0.3, y=0.3, opacity=1),
    DropDown("nautilus", "nautilus", width=0.4, height=0.5, x=0.3, y=0.3, opacity=1),
    DropDown("calcurse", "terminology -e calcurse", width=0.4, height=0.5, x=0.3, y=0.3, opacity=1),
    DropDown("lxrandr", "lxrandr", width=0.4, height=0.5, x=0.3, y=0.3, opacity=1),

]))
keys.extend([
    Key(["control"],"1", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key(["control"],"2", lazy.group["scratchpad"].dropdown_toggle("authy")),
    Key(["control"],"3", lazy.group["scratchpad"].dropdown_toggle("alsa")),
    Key(["control"],"4", lazy.group["scratchpad"].dropdown_toggle("quick")),
    Key(["control"],"5", lazy.group["scratchpad"].dropdown_toggle("vifm")),
    Key(["control"],"6", lazy.group["scratchpad"].dropdown_toggle("nautilus")),
    Key([],"F2", lazy.group["scratchpad"].dropdown_toggle("calcurse")),
    Key([],"F3", lazy.group["scratchpad"].dropdown_toggle("lxrandr")),


])


layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=0),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="ProFontWindows Nerd Font Mono",
    fontsize=14,
    padding=5,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox(text="🔊"),
                widget.Volume(
                            mouse_callbacks={'Button1': lambda: lazy.spawn("terminology -e alsamixer")}
                            ),
        	    widget.Sep(),
        	    widget.TextBox(text="🖥️"),
                widget.CPU(
                            mouse_callbacks={'Button1': lambda: lazy.spawn("terminology -e htop")}
                            ),
        		widget.Memory(
                            mouse_callbacks={'Button1': lambda: lazy.spawn("terminology -e htop")}
                            ),
        		widget.Sep(),
        		widget.BatteryIcon(),
        		widget.Sep(),
        		widget.TextBox(text="🛰"),
        		widget.Net(),
        		widget.Sep(),
        		widget.TextBox(
        		            text="🌡",  
        		            ),
        		widget.ThermalSensor(
        		            threshold=90, fmt='{}'
        		            ),
        		widget.Sep(),
        		widget.TextBox(text="⏳"),
                widget.Clock(
                        timezone="Europe/Amsterdam",
                        format="%Y-%m-%d %a %I:%M %p"
                        )
            ],
            32,
            border_width=[1, 2, 1, 2],  # Draw top and bottom borders
            border_color=["5C2727", "000000", "5C2727", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
