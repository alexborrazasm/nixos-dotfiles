{ 
  config, 
  pkgs,
  lib,
  ... 
}: {
  imports = 
  [
    ../waybar
    ../kitty
    ../alacritty
    ../wofi
    ../swaync
    ../nautilus
  ];

  wayland.windowManager.hyprland.enable = true;

  # Avoid conflicts with UWSM
  wayland.windowManager.hyprland.systemd.enable = false;

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  services.hyprpaper.enable = true;
  services.hyprpaper.settings.splash = false;

  home.packages = with pkgs; [
    hyprshot
    cliphist
    wl-clipboard
    jq # for workspace script
    networkmanagerapplet
    blueman
    brightnessctl
    playerctl
    pavucontrol
    pamixer
    nwg-displays
  ];

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  # Style using stylix colors
  home.file.".config/hypr/theme.conf".text = ''
    # Stylix theme
    # Font config
    $font = ${config.stylix.fonts.sansSerif.name}
    $font_mono = ${config.stylix.fonts.monospace.name}

    # Base colors
    $base     = rgb(${config.lib.stylix.colors.base00})
    $mantle   = rgb(${config.lib.stylix.colors.base01})

    # Surface colors
    $surface0 = rgb(${config.lib.stylix.colors.base02})
    $surface1 = rgb(${config.lib.stylix.colors.base03})

    # Text colors
    $text     = rgb(${config.lib.stylix.colors.base05})

    # Accent colors
    $rosewater = rgb(${config.lib.stylix.colors.base06})
    $lavender  = rgb(${config.lib.stylix.colors.base07})
    $red       = rgb(${config.lib.stylix.colors.base08})
    $peach     = rgb(${config.lib.stylix.colors.base09})
    $yellow    = rgb(${config.lib.stylix.colors.base0A})
    $green     = rgb(${config.lib.stylix.colors.base0B})
    $sapphire  = rgb(${config.lib.stylix.colors.base0C})
    $blue      = rgb(${config.lib.stylix.colors.base0D})
    $mauve     = rgb(${config.lib.stylix.colors.base0E})
    $flamingo  = rgb(${config.lib.stylix.colors.base0F})
  '';

  home.file.".config/hypr" = {
    source = ./config;
    recursive = true;
    force = true;
  };

}
