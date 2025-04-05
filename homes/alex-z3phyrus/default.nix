# homes/alex-z3phyrus/default.nix
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
      papi
      numactl
      gnuplot
      texworks
      linuxPackages_latest.perf

    
      # Utils
      rlwrap
      zip
      unzip
      xz
      unrar
      
      # Communication applications
      discord

      # Multimedia applications
      spotify
      vlc

      # Networking tools
      nmap
      dnsutils
      traceroute
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
      fic = "cd /home/alex/Documents/fic/2_curso/q_2";
      lsi = "cd /home/alex/Documents/fic/2_curso/q_1/LSI";
      so  = "cd /home/alex/Documents/fic/2_curso/q_1/SO";
      ds  = "cd /home/alex/Documents/fic/2_curso/q_1/DS";
      md  = "cd /home/alex/Documents/fic/2_curso/q_1/MD";
      ec  = "cd /home/alex/Documents/fic/2_curso/q_1/EC";
      xp  = "cd /home/alex/Documents/fic/2_curso/q_1/XP";
      ac  = "cd /home/alex/Documents/fic/2_curso/q_2/AC";
      cpf = "cd /home/alex/Documents/fic/2_curso/q_2/CP";
      sc  = "cd /home/alex/Documents/fic/2_curso/q_2/SC";
      si  = "cd /home/alex/Documents/fic/2_curso/q_2/SI";
      dhi = "cd /home/alex/Documents/fic/2_curso/q_2/DHI"; 
    };
    initExtra = ''
      # for ssh
      export TERM=xterm-256color
    '';
  };
 
  # Direnv configuration for per-directory environment variables
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
