{ config, pkgs, ... }:
{
  services.samba = {
    enable = true;
    securityType = "user";
  };
  
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;
    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;
    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  fileSystems."/mnt/data" = {
    device = "/dev/nvme0n1p2";
    fsType = "exfat";
    options = [ "noauto" "x-systemd.automount" "defaults" ];
  };
  
  # CIFS/SMB network mounts
fileSystems."/mnt/AtmoSphere" = {
  device = "//192.168.178.69/AtmoSphere";
  fsType = "cifs";
  options = [
    "username=nobody"
    "password="
    "uid=65534"
    "gid=65534"
    "file_mode=0777"
    "dir_mode=0777"
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
  ];
};

fileSystems."/mnt/FATmoSphere" = {
  device = "//192.168.178.69/FATmoSphere";
  fsType = "cifs";
  options = [
    "username=nobody"
    "password="
    "uid=65534"
    "gid=65534"
    "file_mode=0777"
    "dir_mode=0777"
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
  ];
};

fileSystems."/mnt/ssd" = {
  device = "//192.168.178.69/ssd";
  fsType = "cifs";
  options = [
    "username=nobody"
    "password="
    "uid=65534"
    "gid=65534"
    "file_mode=0777"
    "dir_mode=0777"
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
  ];
};
}
