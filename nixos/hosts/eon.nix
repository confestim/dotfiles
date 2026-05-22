{ config, lib, pkgs, ... }:
{
  networking.hostName = "eon";

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = lib.mkForce false; # lanzaboote overrides this
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  virtualisation.docker.enable = true;

  services.samba = {
    enable = true;
    settings.global.security = "user";
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # CIFS/SMB network mounts
  fileSystems."/mnt/AtmoSphere" = {
    device = "//192.168.178.69/AtmoSphere";
    fsType = "cifs";
    options = [
      "username=nobody" "password=" "uid=65534" "gid=65534"
      "file_mode=0777" "dir_mode=0777"
      "x-systemd.automount" "noauto"
      "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s"
    ];
  };

  fileSystems."/mnt/FATmoSphere" = {
    device = "//192.168.178.69/FATmoSphere";
    fsType = "cifs";
    options = [
      "username=nobody" "password=" "uid=65534" "gid=65534"
      "file_mode=0777" "dir_mode=0777"
      "x-systemd.automount" "noauto"
      "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s"
    ];
  };

  fileSystems."/mnt/ssd" = {
    device = "//192.168.178.69/ssd";
    fsType = "cifs";
    options = [
      "username=nobody" "password=" "uid=65534" "gid=65534"
      "file_mode=0777" "dir_mode=0777"
      "x-systemd.automount" "noauto"
      "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s"
    ];
  };
}
