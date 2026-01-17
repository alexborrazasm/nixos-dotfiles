{ 
  config, 
  pkgs,
  username,
  ... 
}: {
  imports = [
    ../../modules/home-manager/common
    ../../modules/home-manager/stylix
    ../../modules/home-manager/zsh
    ../../modules/home-manager/starship
    ../../modules/home-manager/utils
  ];
  
  home.packages = with pkgs; [
  ];

  # basic configuration of git
  programs.git = {
    enable = true;
    settings.user = {
      name = "alexborrazasm";
      email = "alexborrazasm@gmail.com";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
