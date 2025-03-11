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
      vscode
      gcc
      gnumake
      python3
      valgrind
      gdb
      jetbrains.idea-ultimate
      openmpi 
      openmpi.dev
      erlang
      jdk
      rlwrap
      
      # Alacritty
      alacritty

      # Communication applications
      discord

      # Multimedia applications
      spotify
      vlc

      # Networking tools
      nmap
      dnslookup
      wireguard-tools
    ];
  };

  # Zsh local configuration
  programs.zsh = {
    enable = true;
    shellAliases = {
        # Aliases for NixOS and Home Manager management
        nrs = "sudo nixos-rebuild switch --flake ~/nix-config/#z3phyrus";
        hms = "home-manager switch --flake ~/nix-config/#alex@z3phyrus";
        nfu = "(cd ~/nix-config && nix flake update && git add flake.lock && git commit -m 'Update flake.lock' && git push)";
        ncg = "sudo nix-collect-garbage -d";

      # Aliases for university course directories
      fic = "cd /mnt/data/Documents/fic/2_curso/q_2";
      lsi = "cd /mnt/data/Documents/fic/2_curso/q_1/LSI";
      so  = "cd /mnt/data/Documents/fic/2_curso/q_1/SO";
      ds  = "cd /mnt/data/Documents/fic/2_curso/q_1/DS";
      md  = "cd /mnt/data/Documents/fic/2_curso/q_1/MD";
      ec  = "cd /mnt/data/Documents/fic/2_curso/q_1/EC";
      xp  = "cd /mnt/data/Documents/fic/2_curso/q_1/XP";
      ac  = "cd /mnt/data/Documents/fic/2_curso/q_2/AC";
      cpf = "cd /mnt/data/Documents/fic/2_curso/q_2/CP";
      sc  = "cd /mnt/data/Documents/fic/2_curso/q_2/SC";
      si  = "cd /mnt/data/Documents/fic/2_curso/q_2/SI";
      dhi = "cd /mnt/data/Documents/fic/2_curso/q_2/DHI";
    };
  };

  # Direnv configuration for per-directory environment variables
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
