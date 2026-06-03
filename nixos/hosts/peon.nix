{ config, pkgs, ... }:

{
  networking.hostName = "peon";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use Intel/AMD drivers (default)
  services.xserver.videoDrivers = [ "modesetting" ];
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  services.xserver.libinput.enable = true;
}
