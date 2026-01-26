{ config, pkgs, ... }:
{
  imports = [
    ./programs/vscodium.nix
    ./programs/nvim.nix
    ./programs/kitty.nix
    ./programs/niri.nix
    ./programs/fuzzel.nix
    ./programs/zsh.nix
    ./programs/waybar.nix
    ./programs/swaylock.nix
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [
      "wlr"
      "gtk"
    ];
  };

  home.username = "boyan";
  home.homeDirectory = "/home/boyan";
  fonts.fontconfig.enable = true;

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    nerd-fonts.agave
    nerd-fonts.symbols-only
    obsidian
    mpv
    obs-studio
    btop
    sdrpp
    pavucontrol
    eza
    viber
    signal-desktop
    vesktop
    anki
    wl-clipboard
    neofetch
    thunderbird
    nwg-bar
    kicad
    # Programming
    ghc
    ccls
    gnumake
    uv
    fira-code
    fuzzel
    swaylock-effects
    swaybg
    feh
    brightnessctl
    wireplumber
    nodejs
    yarn
    ripgrep
    fd
    texlive.combined.scheme-full
    libnotify
  ];

  nixpkgs.config.allowUnfree = true;

  # Notification daemon
  services.mako = {
    enable = true;
    settings = {
      background-color = "#282a36";
      text-color = "#f8f8f2";
      border-color = "#bd93f9";
      border-radius = 8;
      border-size = 2;
      default-timeout = 5000;
      layer = "overlay";
      font = "Agave Nerd Font 11";
    };
    extraConfig = ''
      [urgency=high]
      border-color=#ff5555
    '';
  };

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
  '';

  programs.git = {
    enable = true;
    settings = {
      user.email = "boyan@confest.im";
      user.name = "Boyan K.";
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "nvim";
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
    GSK_RENDERER = "gl";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "thunar.desktop";
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/mpeg" = "mpv.desktop";
      "video/x-msvideo" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";
      "video/x-flv" = "mpv.desktop";
    };

  };

  programs.home-manager.enable = true;

  # wakatime
  home.file.".wakatime.cfg".text = ''
    [settings]
    api_url = https://track.confest.im/api
    api_key = 7652da41-06a1-4645-a3ce-3f8dc724e74e
  '';
}
