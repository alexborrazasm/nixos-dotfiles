{ 
  config, 
  pkgs, 
  ... 
}: {
  # To launch Hyprland without greetd and tuigreet
  #environment.loginShellInit = ''
  #  if uwsm check may-start; then
  #    exec uwsm start hyprland-uwsm.desktop
  #  fi
  #'';

  # Launch Hyprland with greetd and tuigreet as frontend
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd 'uwsm start hyprland-uwsm.desktop' --remember --remember-user-session --user-menu --user-menu-min-uid 1000 --asterisks --power-shutdown 'shutdown -P now' --power-reboot 'shutdown -r now'";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    tuigreet
  ];
  
  # Required by power events and lid events on hyprdynamicmonitors
  services.upower.enable = true;

  programs.uwsm.enable = true;

  programs.hyprland.enable = true; # enable Hyprland
  programs.hyprland.withUWSM = true;

  # Hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}



