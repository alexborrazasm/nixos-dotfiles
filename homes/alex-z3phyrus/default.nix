# homes/alex-z3phyrus/default.nix
{ config, pkgs, pkgsUnstable, inputs, ... }:

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
      pkgsUnstable.vscode
      gcc
      gnumake
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
      linuxPackages_latest.perf
      (python3.withPackages (ps: with ps; [ numpy ]))

      # latex
      texlive.combined.scheme-full

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

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
  };

  dconf.settings = {
    "org.gnome.desktop.interface" = {
      cursor-theme = "Adwaita";
      cursor-size = 24;
    };
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
      xp  = "cd /home/alex/Documents/fic/2_curso/q_1/XP";
      ac  = "cd /home/alex/uni/AC";
      cpf = "cd /home/alex/uni/CP";
      sc  = "cd /home/alex/uni/SC";
      si  = "cd /home/alex/uni/SI";
      dhi = "cd /home/alex/uni/DHI"; 
      
      # python with numpy
      npy = ''python3 -q -c 'import numpy as np; import code; code.interact(local=locals())' '';

      # some_command | copy
      copy = "wl-copy";
    };
    initExtra = ''
      eval "$(direnv hook zsh)"
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
