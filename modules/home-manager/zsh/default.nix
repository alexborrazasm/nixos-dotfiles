{ 
  config, 
  pkgs, 
  ... 
}: {

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    completionInit="autoload -Uz compinit && compinit";
    dotDir = "${config.xdg.configHome}/zsh";

    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    plugins = [
      {
        name = "zsh-colored-man-pages";
	file = "plugins/colored-man-pages/colored-man-pages.plugin.zsh";
        src = builtins.fetchGit {
          url = "https://github.com/ohmyzsh/ohmyzsh/";
          rev = "6bc4c80c7db072a0d2d265eb3589bbe52e0d2737";
        };
      }
      {
        name = "zsh-extract";
	file = "plugins/extract/extract.plugin.zsh";
        src = builtins.fetchGit {
          url = "https://github.com/ohmyzsh/ohmyzsh/";
          rev = "92aed2e93624124182ba977a91efa5bbe1e76d5f";
        };
      }
      {
        name = "zsh-sudo";
	file = "plugins/sudo/sudo.plugin.zsh";
	src = builtins.fetchGit {
	  url = "https://github.com/ohmyzsh/ohmyzsh/";
	  rev = "f8bf8f0029a475831ebfba0799975ede20e08742";
	};
      }
    ];

    shellAliases = {
      # lsd
      l   = "lsd --group-dirs=first";
      ll  = "lsd -lh --group-dirs=first";
      la  = "lsd -a --group-dirs=first";
      lla = "lsd -lha --group-dirs=first";
      ls  = "lsd --group-dirs=first";
      
      # bat
      cat = "bat -pP";
      
      # nvim
      vi  = "nvim";
      vim = "nvim";
      
      # nixos
      ncg  = "nix-collect-garbage -d";
      ncgk = "sudo nix-collect-garbage -d";
      nfu  = "nix flake update";
      nrs  = "sudo nixos-rebuild switch";
      nsh  = "nix shell";
      nsp  = "nix-shell -p "; # <package>
      nrun = "nix run";
      ndev = "nix develop";

      neofetch = "fastfetch";
    };

    initContent = ''
      # Menu select
      zstyle ':completion:*' menu select
      zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      # Apply colors to completion menu
      zstyle ':completion:*:default' list-colors "''${(s.:.)LS_COLORS}"

      # Skip works
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      # Reduce Zsh startup delay
      setopt NO_BEEP

      # Don't consider certain characters part of the word
      WORDCHARS=''${WORDCHARS//\/[&.;]}
    '';

  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

}

