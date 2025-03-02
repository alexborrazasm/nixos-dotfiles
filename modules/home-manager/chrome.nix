# modules/home-manager/chrome.nix
{ config, lib, pkgs, ... }:

with lib;
let 
  cfg = config.chrome;
  chromeFlags = "--enable-features=TouchpadOverscrollHistoryNavigation";
in {
  options.chrome = {
    enable = mkEnableOption "Google Chrome configuration";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.google-chrome ];

    # Chrome as default browser
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "google-chrome.desktop";
        "x-scheme-handler/http" = "google-chrome.desktop";
        "x-scheme-handler/https" = "google-chrome.desktop";
        "x-scheme-handler/about" = "google-chrome.desktop";
        "x-scheme-handler/unknown" = "google-chrome.desktop";
      };
    };

    xdg.desktopEntries.google-chrome = {
      name = "Google Chrome";
      genericName = "Web Browser";
      comment = "Access the Internet";
      exec = "${pkgs.google-chrome}/bin/google-chrome-stable %U ${chromeFlags}";
      terminal = false;
      type = "Application";
      icon = "google-chrome";
      categories = [ "Network" "WebBrowser" ];
      mimeType = [
        "x-scheme-handler/unknown" "x-scheme-handler/about" "application/pdf"
        "application/rdf+xml" "application/rss+xml" "application/xhtml+xml"
        "application/xhtml_xml" "application/xml" "image/gif" "image/jpeg"
        "image/png" "image/webp" "text/html" "text/xml" "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
      actions = {
        "new-window" = {
          name = "New Window";
          exec = "${pkgs.google-chrome}/bin/google-chrome-stable ${chromeFlags}";
        };
        "new-private-window" = {
          name = "New Incognito Window";
          exec = "${pkgs.google-chrome}/bin/google-chrome-stable --incognito ${chromeFlags}";
        };
      };
    };
  };
}