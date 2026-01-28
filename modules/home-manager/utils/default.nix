{ 
  config, 
  pkgs,
  ... 
}: {

  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      numpy
      dbus-python
    ]))
    
    # system info
    fastfetch

    # archives
    zip
    xz
    unzip
    p7zip
    unrar

    # networking tools
    dnsutils  # `dig` + `nslookup`
    nmap
    traceroute
    net-tools
    tcpdump
    inetutils

    # misc
    tree
    bat
    rlwrap
    lsd        # ls replacement
    bat        # cat replacement
    fd         # find replacement
    ripgrep    # grep replacement
    dust       # du replacement

    htop
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
    numactl
    
    # TUI for imaging disks.
    caligula
  ];

}

