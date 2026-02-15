# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  lib,
  pkgs,
  ...
}:
let
  hostName = "eon";
in
{

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hosts/${hostName}.nix
  ];

  hardware.rtl-sdr.enable = true;
  hardware.graphics.enable = true;
  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub2-theme = {
    enable = true;
    theme = "tela";
    footer = true;
    customResolution = "1600x900"; # Optional: Set a custom resolution
  };
  virtualisation.docker.enable = true;
  networking.hostName = hostName;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  services.avahi.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;

  # portals
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config = {
      common = {
        default = [ "gtk" ];
      };
      niri = {
        default = lib.mkForce [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      };
    };
  };

  # udev
  services.udev.packages = [ pkgs.stlink ];
  # Enable greetd with tuigreet
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --asterisks \
            --remember \
            --remember-user-session \
            --cmd niri
        '';
        user = "greeter";
      };
    };
  };
  services.flatpak.enable = true;
  systemd.tmpfiles.rules = [
    "d '/var/cache/tuigreet' - greeter greeter - -"
  ];

  security.pam.services.greetd.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.boyan = {
    isNormalUser = true;
    description = "Boyan";
    extraGroups = [
      "networkmanager"
      "adbusers"
      "wheel"
      "docker"
      "dialout"
      "plugdev"
      "video"
      "audio"
    ];
    shell = pkgs.zsh;
  };

  programs.adb.enable = true;
  # Install firefox.
  programs.firefox.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
      nos = "DOTFILES=~/buffer/dotfiles && git -C $DOTFILES pull && sudo nixos-rebuild switch && (cd $DOTFILES && git add -A && git diff-index --quiet HEAD || git commit -m 'NixOS: auto update' && git push)";
      hms = "DOTFILES=~/buffer/dotfiles && git -C $DOTFILES pull && home-manager switch && (cd $DOTFILES && git add -A && git diff-index --quiet HEAD || git commit -m 'HM: auto update' && git push)";
    };
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    wget
    fzf
    vim
    curl
    python3
    niri
    waybar
    gcc
    valgrind
    git
    thunar
    thunar-volman
    thunar-archive-plugin
    gvfs
    usbutils
  ];
  programs.nix-ld.enable = true;
  services.tumbler.enable = true;
  programs.waybar.enable = true;
  # This is the dumbest shit ever
  services.gvfs = {
    enable = true;
    package = pkgs.gvfs.override {
      samba = null;
    };
  };
  programs.niri.enable = true;
  programs.git = {
    enable = true;
    config = {
      user = {
        email = "boyan@confest.im";
        name = "Boyan K.";
      };
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "nvim";
      };
    };
  };
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.11"; # Did you read the comment?

}

