{ 
  config, 
  pkgs,
  username,
  ... 
}: {
  imports = [
    ../../modules/home-manager/common
    ../../modules/home-manager/stylix
    ../../modules/home-manager/hypr
    ../../modules/home-manager/zsh
    ../../modules/home-manager/starship
    ../../modules/home-manager/firefox
    ../../modules/home-manager/utils
    ../../modules/home-manager/eden-emu
  ];
  
  # Set default terminal and browser
  home.sessionVariables = {
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };
  
  home.packages = with pkgs; [
    discord
    spotify
    vscode
    evince
  ];
  
  programs.chromium = {
    enable = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = [ "org.gnome.TextEditor.desktop" ];
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "video/mp4" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
  };

  # basic configuration of git
  programs.git = {
    enable = true;
    settings.user = {
      name = "alexborrazasm";
      email = "alexborrazasm@gmail.com";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
