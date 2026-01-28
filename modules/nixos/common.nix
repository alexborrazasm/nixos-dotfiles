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
    promptInit = ''
      autoload -U colors && colors
      autoload -U promptinit && promptinit

      if [ "$UID" -eq 0 ]; then
        # [root@host ~]# 
        PROMPT="%B%{$fg[red]%}[%n@%m:%~]#%{$reset_color%}%b "
      fi
    '';
    shellAliases = {
      l   = "eza --group-directories-first";
      ll  = "eza -lh --group-directories-first";
      la  = "eza -a --group-directories-first";
      lla = "eza -lha --group-directories-first";
      ls  = "eza --group-directories-first";
      
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
    eza        # ls replacement
    fd         # find replacement
    ripgrep    # grep replacement
    bat
  ];

  # Set the default editor to vim
  environment.variables.EDITOR = "nvim";

}
