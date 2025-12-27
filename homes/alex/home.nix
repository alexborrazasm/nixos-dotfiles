{ 
  config, 
  pkgs,
  username,
  ... 
}: {
  imports = [
    ../../modules/home-manager/common
    ../../modules/home-manager/hypr
    ../../modules/home-manager/zsh
    ../../modules/home-manager/starship
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # temp
    firefox

    neofetch

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    bat
    lsd # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    dnsutils  # `dig` + `nslookup`
    nmap # A utility for network discovery and security auditing

    # misc
    tree

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  # basic configuration of git
  programs.git = {
    enable = true;
    settings.user = {
      name = "alexborrazasm";
      email = "alexborrazasm@gmail.com";
    };
  };

 # programs.bash = {
 #   enable = true;
 #   enableCompletion = true;
 # };

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
