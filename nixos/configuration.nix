# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  lib,
  pkgs,
  ...
}:
{
  hardware.keyboard.qmk.enable = true;

  hardware.rtl-sdr.enable = true;
  hardware.graphics.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";
  programs.zsh.enable = true;
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

 programs.nix-ld.libraries = with pkgs; [
    libsecret
    glib
  ];
  #usb
  services.udisks2.enable = true;
  # services.devmon.enable = true;
  services.gvfs.enable = true;

  programs.appimage = {
  enable = true;
  binfmt = true;  # lets you run AppImages directly without appimage-run
  package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [
      pkgs.glfw
      pkgs.libGL
      pkgs.gcc-unwrapped.lib
    ];
  };
};

  # udev
  services.udev.packages = [ 
    pkgs.stlink
    pkgs.libmtp.out
    pkgs.qmk-udev-rules
    pkgs.via
    pkgs.platformio-core
    pkgs.openocd
  ];

  services.flatpak.enable = true;

  security.pam.services.greetd.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

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
      "uinput"
      "audio"
    ];
    shell = pkgs.zsh;
  };

  # Install firefox.
  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = [ "root" "boyan" ];

  environment.systemPackages = with pkgs; [
    wget
    qmk
    via
    qmk-udev-rules
    fzf
    nix-ld
    vim
    curl
    python3
    niri
    xwayland-satellite
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
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;


  # hall of shame
  services.udev.extraRules = ''
  SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", MODE="0666", GROUP="plugdev"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000a", MODE="0666", GROUP="plugdev"
'';

  systemd.services.dbus.stopIfChanged = false;

  system.stateVersion = "25.11"; # Did you read the comment?

}
