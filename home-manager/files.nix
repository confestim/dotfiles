{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    imv
    mpv
    xdg-utils
  ];

  # Thunar uses the XFCE exo-open helper system to launch a terminal emulator.
  # Define kitty as an XFCE TerminalEmulator helper and set it as the default.
  home.file.".local/share/xfce4/helpers/kitty.desktop".text = ''
    [Desktop Entry]
    NoDisplay=true
    Version=0.9.0
    Encoding=UTF-8
    Type=X-XFCE-Helper
    X-XFCE-Category=TerminalEmulator
    X-XFCE-CommandsWithParameter=kitty %s
    Icon=kitty
    X-XFCE-Commands=kitty
    Name=kitty
  '';

  home.file.".config/xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
  '';

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Directories and archives
      "inode/directory" = "thunar.desktop";
      "application/zip" = "xarchiver.desktop";
      "application/x-zip-compressed" = "xarchiver.desktop";
      "application/x-zip" = "xarchiver.desktop";
      "application/x-tar" = "xarchiver.desktop";
      "application/gzip" = "xarchiver.desktop";
      "application/x-bzip2" = "xarchiver.desktop";
      "application/x-xz" = "xarchiver.desktop";
      "application/x-7z-compressed" = "xarchiver.desktop";
      "application/x-rar" = "xarchiver.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/ftp" = "firefox.desktop";

      # Images
      "image/png" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/svg+xml" = "imv.desktop";
      "image/bmp" = "imv.desktop";
      "image/tiff" = "imv.desktop";
      "image/x-icon" = "imv.desktop";

      # Video
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/x-msvideo" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";
      "video/mpeg" = "mpv.desktop";
      "video/ogg" = "mpv.desktop";
      "video/x-flv" = "mpv.desktop";

      # Audio
      "audio/mpeg" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/x-wav" = "mpv.desktop";
      "audio/aac" = "mpv.desktop";
      "audio/mp4" = "mpv.desktop";
      "audio/x-m4a" = "mpv.desktop";

      # Text
      "text/plain" = "nvim.desktop";
      "text/x-python" = "nvim.desktop";
      "text/x-shellscript" = "nvim.desktop";
      "text/x-csrc" = "nvim.desktop";
      "text/x-chdr" = "nvim.desktop";
      "text/x-c++src" = "nvim.desktop";
      "text/x-c++hdr" = "nvim.desktop";
      "text/x-java" = "nvim.desktop";
      "text/javascript" = "nvim.desktop";
      "text/css" = "nvim.desktop";
      "text/html" = "firefox.desktop";
      "text/xml" = "nvim.desktop";
      "text/x-makefile" = "nvim.desktop";
      "text/markdown" = "nvim.desktop";
      "text/x-rust" = "nvim.desktop";
      "application/json" = "nvim.desktop";
      "application/x-yaml" = "nvim.desktop";
      "application/toml" = "nvim.desktop";
      "application/x-shellscript" = "nvim.desktop";

      # PDF
      "application/pdf" = "firefox.desktop";
    };
  };
  programs.mpv = {
  config = {
    keepaspect-window = true;
  };
};

}
