{ config, pkgs, inputs, ... }:

{
  # Home Manager configuration
  home.username = "alex";
  home.homeDirectory = "/home/alex";
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Allow unfree packages in home-manager
  nixpkgs.config.allowUnfree = true;

  # Packages to install
  home.packages = with pkgs; [
    # Development tools
    vscode
    gcc
    python3
    valgrind
    gdb

    discord

    # Applications
    spotify
    vlc
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nix-config/#z3phyrus";
      hms = "home-manager switch --flake ~/nix-config/#alex@z3phyrus";
    };
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "alexborrazasm";
    userEmail = "alexborrazasm@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Direnv for per-directory environment variables
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}