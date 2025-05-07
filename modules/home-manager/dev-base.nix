# modules/home-manager/dev-base.nix
{ config, pkgs, pkgsUnstable, lib, ... }:

with lib;

let 
  cfg = config.dev-base;
in {
  options.dev-base = {
    enable = mkEnableOption "Dev base tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ 
      # C
      gcc
      gnumake
      valgrind
      gdb
      openmpi 
      openmpi.dev
      
      erlang
      
      # java
      jdk

      # performance tools
      numactl
      papi
      gnuplot
      
      # python
      (python3.withPackages (ps: with ps; [ numpy ]))

      # latex
      texlive.combined.scheme-small
    ];
  };
}
