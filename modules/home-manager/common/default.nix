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

  home.packages = [
    pkgs.home-manager
  ];

  news.display = "silent";

  xdg.userDirs.enable = true;

}
