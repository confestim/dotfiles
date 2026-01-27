{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    imv
    mpv
    xdg-utils
  ];

 xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        # thunar for folders and zips
        "inode/directory" = "thunar.desktop";
        "application/zip" = "thunar.desktop";
        "application/x-tar" = "thunar.desktop";
        "application/gzip" = "thunar.desktop";
        
        "image/*" = "imv.desktop";
        "video/*" = "mpv.desktop";
        "audio/*" = "mpv.desktop";

        "application/pdf" = "firefox.desktop";
        "text/*" = "nvim.desktop";
      };
  };
 };
  programs.mpv = {
  config = {
    keepaspect-window = true;
  };
};

}
