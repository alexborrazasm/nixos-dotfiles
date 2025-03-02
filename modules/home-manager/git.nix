# modules/home-manager/git.nix
{ config, pkgs, lib, ... }:

with lib;
let 
  cfg = config.git;
in {
  options.git = {
    enable = mkEnableOption "Git configuration";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "alexborrazasm";
      userEmail = "alexborrazasm@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}