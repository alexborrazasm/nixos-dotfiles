{ 
  config, 
  pkgs, 
  ... 
}: {
  environment.loginShellInit = ''
    if uwsm check may-start; then
      exec uwsm start hyprland-uwsm.desktop
    fi
  '';

  programs.uwsm.enable = true;

  programs.hyprland.enable = true; # enable Hyprland
  programs.hyprland.withUWSM = true;

  # Hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}



