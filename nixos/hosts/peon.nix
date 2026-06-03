{ config, pkgs, lib, ... }:

{
  networking.hostName = "peon";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  services.upower.enable = true;

  # Use Intel/AMD drivers (default)
  services.xserver.videoDrivers = [ "modesetting" ];
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  services.xserver.libinput.enable = true;

  # Auto-login directly into niri (no greeter on laptop)
  services.greetd.settings = lib.mkForce {
    initial_session = {
      command = "${pkgs.niri}/bin/niri-session";
      user = "boyan";
    };
    default_session = {
      command = "${pkgs.niri}/bin/niri-session";
      user = "boyan";
    };
  };
}
