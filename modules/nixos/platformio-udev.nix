# modules/nixos/platformio-udev.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.platformio-udev;
in {
  options.platformio-udev = {
    enable = mkEnableOption "platformio-udev configuration";
  };
  
  config = mkIf cfg.enable {
      
    services.udev.packages = [
      (pkgs.stdenv.mkDerivation {
        pname = "platformio-udev-rules";
        version = "1.0";
        src = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/platformio/platformio-core/develop/platformio/assets/system/99-platformio-udev.rules";
          sha256 = "CfOs4g5GoNXeRUmkKY7Kw9KdgOqX5iRLMvmP+u3mqx8=";
        };
        phases = [ "installPhase" ];
        installPhase = ''
          mkdir -p $out/lib/udev/rules.d
          cp $src $out/lib/udev/rules.d/99-platformio-udev.rules
        '';
      })
    ]; 

  };
}
