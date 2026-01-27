{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    imv
    mpv
    xdg-utils
  ];

 xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # thunar for folders and zips
      "inode/directory" = "thunar.desktop";
      "application/zip" = "thunar.desktop";
      "application/x-tar" = "thunar.desktop";
      "application/gzip" = "thunar.desktop";
      
      "image/png" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/jpg" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/svg+xml" = "imv.desktop";
      "image/bmp" = "imv.desktop";
      "image/tiff" = "imv.desktop";
      
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/x-msvideo" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";   # .mov
      "video/x-flv" = "mpv.desktop";
      "video/mpeg" = "mpv.desktop";
      "video/ogg" = "mpv.desktop";
      
      "audio/mpeg" = "mpv.desktop";        # .mp3
      "audio/ogg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/x-wav" = "mpv.desktop";
      "audio/aac" = "mpv.desktop";

      "application/pdf" = "firefox.desktop";
      # markdown
      "text/markdown" = "nvim.desktop";
      "text/*" = "nvim.desktop";
    };
  };
  programs.mpv = {
  config = {
    keepaspect-window = true;
  };
};

}
