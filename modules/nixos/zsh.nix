{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.zsh;
in {
  options.zsh = {
    enable = mkEnableOption "ZSH configuration";
  };

  config = mkIf cfg.enable {
    # Enable zsh for the system
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "docker" "sudo" ];
        theme = "agnoster";
      };
      shellAliases = {
        cat = "bat";
        ls = "lsd";
        ll = "ls -l";
        la = "ls -la";
      };
    };

    environment.systemPackages = with pkgs; [
      bat
      lsd
    ];
  };
}

