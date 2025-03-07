# modules/nixos/zsh.nix
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
        enable  = true;
        plugins = [ "git" ];
        theme   = "agnoster";
      };
      shellAliases = {
        ":q" = "exit";     
      };
    };
  };
}

