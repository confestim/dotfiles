{ config, pkgs, ... }:
{
  imports = [
    ./programs/vscodium.nix
    ./programs/nvim.nix
    ./programs/kitty.nix
    ./programs/niri.nix
    ./programs/zsh.nix
    ./programs/waybar.nix
    ./programs/swaylock.nix
    ./programs/rofi.nix
    ./files.nix
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

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "codium";
    GSK_RENDERER = "gl";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
  };

  xdg.desktopEntries.nvim = {
    name = "Neovim";
    genericName = "Text Editor";
    exec = "kitty -e nvim %F";
    terminal = true;
  };


  programs.home-manager.enable = true;

  # wakatime
  home.file.".wakatime.cfg".text = ''
    [settings]
    api_url = https://track.confest.im/api
    api_key = 7652da41-06a1-4645-a3ce-3f8dc724e74e
  '';
}
