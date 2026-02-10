{ 
  config, 
  pkgs, 
  lib,
  ... 
}: {

  # Required by power events and lid events on hyprdynamicmonitors
  services.upower.enable = true;

  programs.hyprland.enable = true; # enable Hyprland

  # Hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

}
