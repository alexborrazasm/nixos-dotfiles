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
        plugins = [ "git" "docker" "sudo" ];
        custom = "../../zsh-custom-themes/";
        theme = "agnoster-nix";
      };
      plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }];
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
