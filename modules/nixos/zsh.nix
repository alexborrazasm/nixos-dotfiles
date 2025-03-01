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
        #bat
        cat = "bat";
        catp = "bat -p";

        # lsd
        ll = "lsd -lh --group-dirs=first";
        la = "lsd -a --group-dirs=first";
        l = "lsd --group-dirs=first";
        lla = "lsd -lha --group-dirs=first";
        ls = "lsd --group-dirs=first";
        
        # NixOS
        ncg = "sudo nix-collect-garbage -d";
      };
      history.size = 10000;
    };

    environment.systemPackages = with pkgs; [
      bat
      lsd
    ];
  };
}

