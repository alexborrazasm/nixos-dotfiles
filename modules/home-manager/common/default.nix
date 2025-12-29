{ 
  config,
  pkgs, 
  username,
  ... 
}: {
  home.username = username;
  home.homeDirectory = "/home/${username}";

  nixpkgs.config.allowUnfree = true;

  programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
  };

  xdg.userDirs.enable = true;

}

