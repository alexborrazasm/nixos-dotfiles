{
  pkgs,
  lib,
  username,
  ...
}: {

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      # lsd
      l   = "lsd --group-dirs=first";
      ll  = "lsd -lh --group-dirs=first";
      la  = "lsd -a --group-dirs=first";
      lla = "lsd -lha --group-dirs=first";
      ls  = "lsd --group-dirs=first";
      
      # bat
      cat = "bat -pP";
      
      # nvim
      vi  = "nvim";
      vim = "nvim";
      
      # nixos
      ncg  = "nix-collect-garbage -d";
      ncgk = "sudo nix-collect-garbage -d";
      nfu  = "nix flake update";
      nrs  = "sudo nixos-rebuild switch";
      nsh  = "nix shell";
      nsp  = "nix-shell -p "; # <package>
      nrun = "nix run";
      ndev = "nix develop";

      neofetch = "fastfetch";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  users.users.root = {
    shell = pkgs.zsh;
  };

  # Enable the dynamic library loader for unpatched binaries
  programs.nix-ld.enable = true;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalization properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "alt-intl";
  };

  # Configure console keymap
  console.keyMap = "us";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    lm_sensors # for `sensors` command
    fastfetch
    lsd
    bat
  ];

  # Set the default editor to vim
  environment.variables.EDITOR = "nvim";

  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  services.dbus.packages = [ pkgs.gnome-keyring pkgs.gcr ];
}
