{ config, pkgs, ... }:

{
  # Starship - an customizable prompt for any shell
  programs.starship.enable = true;

  home.file.".config/starship.toml" = {
    source = ./starship.toml;
    force = true;
  };

}

