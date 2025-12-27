{ 
  config, 
  pkgs,
  ... 
}: {

  home.packages = with pkgs; [
    # system info
    fastfetch

    # archives
    zip
    xz
    unzip
    p7zip

    # networking tools
    dnsutils  # `dig` + `nslookup`
    nmap

    # misc
    tree
    bat
    lsd # A modern replacement for ‘ls’

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

}

