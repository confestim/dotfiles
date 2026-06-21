{ config, pkgs, ... }:
{
  imports = [
    ./programs/zed.nix
    ./programs/nvim.nix
    ./programs/kitty.nix
    ./programs/niri.nix
    ./programs/zsh.nix
    ./programs/noctalia.nix
    ./programs/swaylock.nix
    ./files.nix
  ];
  home.username = "boyan";
  home.homeDirectory = "/home/boyan";
  fonts.fontconfig.enable = true;

  home.stateVersion = "25.11";

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaLavender;
    name = "catppuccin-mocha-lavender-cursors";
    size = 24;
  };

  home.packages = with pkgs; [
    qt6.qtmultimedia
    upower
    nerd-fonts.agave
    steam-run
    localsend
    chromium
    unzip
    nerd-fonts.symbols-only
    obsidian
    ffmpeg
    obs-studio
    btop
    sdrpp
    pavucontrol
    eza
    rawtherapee
    viber
    signal-desktop
    vesktop
    (anki.overrideAttrs (old: {
      buildInputs = (old.buildInputs or []) ++ [ qt6.qtmultimedia ];
    }))

    wl-clipboard
    fastfetch
    thunderbird
    gcr
    kicad
    # Programming
    ghc
    ccls
    gnumake
    uv
    fira-code
    swaylock-effects
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

  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
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

  #obs
  nixpkgs.config.packageOverrides = pkgs: {
    obs-studio = pkgs.obs-studio.override {
      cudaSupport = true;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

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

  services.udiskie = {
    enable = true;
    settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
            # replace with your favorite file manager
            file_manager = "thunar";
        };
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
