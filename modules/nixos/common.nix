{
  pkgs,
  lib,
  username,
  ...
}: {

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nix.settings = {
    trusted-users = [ username ];
    substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://eden-flake.cachix.org"
    ];
    trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://eden-flake.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "eden-flake.cachix.org-1:9orwA5vFfBgb67pnnpsxBqILQlb2UI2grWt4zHHAxs8="
    ];

  };

  users.users.root = {
    shell = pkgs.bash;
  };

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
    nano # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.

    # core
    curl
    wget
    gitMinimal
    rsync
    tree

    # monitoring
    htop
    btop
    iotop
    iftop
    strace
    ltrace
    lsof

    # modern replacements
    eza        # ls replacement
    bat        # cat replacement
    fd         # find replacement
    ripgrep    # grep replacement
    dust       # du replacement

    # archives
    zip
    xz
    unzip
    p7zip
    unrar

    # networking tools
    dnsutils  # `dig` + `nslookup`
    nmap
    traceroute
    net-tools
    tcpdump
    socat
    inetutils

    # misc
    rlwrap
    fastfetch
    lm_sensors # for `sensors` command
    fio

    tmux
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.shellAliases = {
    l   = "eza --group-directories-first -g";
    ll  = "eza -l --group-directories-first -g";
    la  = "eza -a --group-directories-first -g";
    lla = "eza -la --group-directories-first -g";
    ls  = "eza --group-directories-first -g";
    cat = "bat -pP";
    neofetch = "fastfetch";
    ncg  = "nix-collect-garbage -d";
    ncgk = "sudo nix-collect-garbage -d";
    nfu  = "nix flake update";
    nrs  = "sudo nixos-rebuild switch";
  };

}
