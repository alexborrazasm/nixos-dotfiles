# modules/home-manager/man-pages.nix
{ config, pkgs, lib, ... }:

with lib;

let 
  cfg = config.man-pages;
in {
  options.man-pages = {
    enable = mkEnableOption "Enable man-pages configuration";
    generateCaches = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to generate a cache of man pages";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      man-db
      bat-extras.batman
    ];

    home.extraOutputsToInstall = [ "man" ];

    # man-db cache gen
    home.file = mkIf cfg.generateCaches {
      ".manpath".text =
        let
          manualPages = pkgs.buildEnv {
            name = "man-paths";
            paths = config.home.packages;
            pathsToLink = [ "/share/man" ];
            extraOutputsToInstall = [ "man" ];
            ignoreCollisions = true;
          };

          manualCache = pkgs.runCommandLocal "man-cache" {
            nativeBuildInputs = [ pkgs.man-db ];
          } ''
            echo "MANDB_MAP ${manualPages}/share/man $out" > man.conf
            mandb -C man.conf --no-straycats --create ${manualPages}/share/man
          '';
        in
        ''
          MANDB_MAP ${config.home.profileDirectory}/share/man ${manualCache}
        '';
    };
  };
}