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
      # NixOS
      nrs = "sudo nixos-rebuild switch --flake ~/nix-config/#z3phyrus";
      hms = "home-manager switch --flake ~/nix-config/#alex@z3phyrus";
      nfu = "(cd ~/nix-config && nix flake update && git add flake.lock && git commit -m 'Update flake.lock' && git push)";

      # fic dirs
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
      si  = "cd /mnt/media/data/Documents/fic/2_curso/q_2/SI";
      dhi = "cd /mnt/data/Documents/fic/2_curso/q_2/DHI";
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