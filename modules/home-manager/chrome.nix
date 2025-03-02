# modules/home-manager/chrome.nix
{ config, lib, pkgs, ... }:

with lib;
let 
  cfg = config.chrome;
in {
  options.chrome = {
    enable = mkEnableOption "Google Chrome configuration";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.google-chrome ];

    # Chrome as default nav
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
  };

  home.file.".local/share/applications/google-chrome.desktop".text = ''
    [Desktop Entry]
    Version=1.0
    Name=Google Chrome
    Exec=/usr/bin/google-chrome-stable %U --enable-features=TouchpadOverscrollHistoryNavigation
    StartupNotify=true
    Terminal=false
    Icon=google-chrome
    Type=Application
    Categories=Network;WebBrowser;
    Actions=new-window;new-private-window;

    [Desktop Action new-window]
    Name=New Window
    Exec=/usr/bin/google-chrome-stable --enable-features=TouchpadOverscrollHistoryNavigation

    [Desktop Action new-private-window]
    Name=New Incognito Window
    Exec=/usr/bin/google-chrome-stable --incognito --enable-features=TouchpadOverscrollHistoryNavigation 
    MimeType=x-scheme-handler/unknown;x-scheme-handler/about;application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/http;x-scheme-handler/https;
  '';
}