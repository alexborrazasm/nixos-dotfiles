{ 
  config, 
  pkgs, 
  ... 
}: {

  # Launch Hyprland with greetd and tuigreet as frontend
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd 'start-hyprland >> /dev/null' --remember --remember-user-session --user-menu --user-menu-min-uid 1000 --asterisks --power-shutdown 'shutdown -P now' --power-reboot 'shutdown -r now'";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    tuigreet
  ];

  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  services.dbus.packages = [ pkgs.gnome-keyring pkgs.gcr ];

  # PAM integration for greetd/tuigreet
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.tuigreet.enableGnomeKeyring = true;
  
  # Required by power events and lid events on hyprdynamicmonitors
  services.upower.enable = true;

  programs.hyprland.enable = true; # enable Hyprland

  # Hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
