# homes/alex-z3phyrus/home.nix
{ config, pkgs, inputs, ... }:

{
  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;

  # Basic Home Manager configuration
  home = {
    username = "alex";
    homeDirectory = "/home/alex";
    stateVersion = "24.11";
    
    # Packages to install
    packages = with pkgs; [
      # Development tools
      git
      gcc
      gnumake
      python3
      valgrind
      gdb
      openmpi 
      openmpi.dev
      erlang

      # Networking tools
      nmap
      dnslookup
    ];
  };

  # Zsh local configuration
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Source nix profile
      source ~/.nix-profile/etc/profile.d/nix.sh
    '';
    shellAliases = {
        # Aliases for NixOS and Home Manager management
        hms = "nix run home-manager/release-24.11 -- switch --flake ~/nix-config/#wsl";
        nfu = "(cd ~/nix-config && nix flake update && git add flake.lock && git commit -m 'Update flake.lock' && git push)";
        ncg = "sudo nix-collect-garbage -d";
    };
  };

  # Direnv configuration for per-directory environment variables
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}