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
        # PATH to custom themes
        custom = "${config.home.homeDirectory}/nix-config/zsh-custom-themes/";
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
      initExtra = ''
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
        # gcc libs HM
        export CPATH=$HOME/.nix-profile/include:$CPATH
        export LIBRARY_PATH=$HOME/.nix-profile/lib:$LIBRARY_PATH
        export LD_LIBRARY_PATH=$HOME/.nix-profile/lib:$LD_LIBRARY_PATH
        
          manf() {
            local page
            page=$(man -k . | awk '{print $1}' | sort -u | fzf)
            [ -n "$page" ] && batman "$page"
          } 

      '';
    };

    home.packages = with pkgs; [
      bat
      bat-extras.batman
      lsd
      fzf
    ];
 };
}
