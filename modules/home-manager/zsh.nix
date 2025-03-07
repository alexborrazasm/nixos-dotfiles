# modules/home-manager/zsh.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.zsh;
in {
  options.zsh = {
    enable = mkEnableOption "ZSH configuration";
  };

  config = mkIf cfg.enable {
    # Enable zsh for the user
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "docker" "sudo"];
        theme = "agnoster";
      };
      shellAliases = {
        # bat
        cat  = "bat";
        catp = "bat -p";

        # lsd
        ll  = "lsd -lh --group-dirs=first";
        la  = "lsd -a --group-dirs=first";
        l   = "lsd --group-dirs=first";
        lla = "lsd -lha --group-dirs=first";
        ls  = "lsd --group-dirs=first";
        
        # neovim
        vi  = "nvim";
        vim = "nvim";

        ":q" = "exit";     
      };
    };

    home.packages = with pkgs; [
      bat
      lsd
    ];
 };
}
