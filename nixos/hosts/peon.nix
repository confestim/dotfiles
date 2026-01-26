{ config, pkgs, ... }:

{
  # Use Intel/AMD drivers (default)
  services.xserver.videoDrivers = [ "modesetting" ];
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  services.xserver.libinput.enable = true;
}
