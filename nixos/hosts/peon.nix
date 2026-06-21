{ config, lib, pkgs, ... }:

let
  # kennylevinsen's autologin, patched to grab tty7 instead of tty1.
  # Without the patch, autologin.service and getty@tty1.service fight for
  # tty1 on every `nixos-rebuild switch`. See:
  #   https://superuser.com/a/1904473
  #   https://github.com/YaLTeR/niri/discussions/1713
  autologin-tty7 = pkgs.autologin.overrideAttrs (_: {
    postPatch = ''
      substituteInPlace main.c \
        --replace-fail "setup_vt(1);" "setup_vt(7);" \
        --replace-fail "XDG_VTNR=1"   "XDG_VTNR=7"
    '';
  });
in
{
  hardware.bluetooth.enable = true;
  networking.hostName = "peon";
  boot.loader.systemd-boot.enable = true;
  virtualisation.docker.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  services.upower.enable = true;

  services.xserver.videoDrivers = [ "modesetting" ];
  networking.wireless.enable = true;
  services.libinput.enable = true;

  # No display manager — autologin straight into niri on tty7 via systemd.
  systemd.services.autologin = {
    description = "Autologin boyan and start niri-session";
    aliases = [ "display-manager.service" ];
    wantedBy = [ "multi-user.target" ];
    after = [
      "systemd-user-sessions.service"
      "plymouth-quit-wait.service"
      "getty@tty7.service"
    ];
    conflicts = [ "getty@tty7.service" ];

    restartIfChanged = lib.mkForce false;
    startLimitBurst = 5;
    startLimitIntervalSec = 30;

    serviceConfig = {
      Type = "simple";
      ExecStart = "${autologin-tty7}/bin/autologin boyan ${pkgs.niri}/bin/niri-session";
      IgnoreSIGPIPE = "no";
      SendSIGHUP = "yes";
      TimeoutStopSec = "30s";
      KeyringMode = "shared";
      Restart = "always";
      RestartSec = "10";
    };
  };
  environment.systemPackages = with pkgs; [
    blueman`
  ];
  # PAM stack so autologin can open a proper user session
  # (sets XDG_RUNTIME_DIR, registers with logind, etc.)
  security.pam.services.autologin = {
    name = "autologin";
    startSession = true;
    setLoginUid = true;
    updateWtmp = true;
  };
}
