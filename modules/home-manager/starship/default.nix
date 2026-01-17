{ 
  config,
  lib, 
  ... 
}:

let
  # Load layout
  design = builtins.fromTOML (builtins.readFile ./layout.toml);

  # Add stylix palette
  stylixPalette = {
    palette = "stylix";
    palettes.stylix = {
      base      = "#${config.lib.stylix.colors.base00}";
      mantle    = "#${config.lib.stylix.colors.base01}";
      crust     = "#${config.lib.stylix.colors.base01}";
      surface0  = "#${config.lib.stylix.colors.base02}";
      surface1  = "#${config.lib.stylix.colors.base03}";
      text      = "#${config.lib.stylix.colors.base05}";
      rosewater = "#${config.lib.stylix.colors.base06}";
      lavender  = "#${config.lib.stylix.colors.base07}";
      red       = "#${config.lib.stylix.colors.base08}";
      peach     = "#${config.lib.stylix.colors.base09}";
      yellow    = "#${config.lib.stylix.colors.base0A}";
      green     = "#${config.lib.stylix.colors.base0B}";
      teal      = "#${config.lib.stylix.colors.base0C}";
      sapphire  = "#${config.lib.stylix.colors.base0C}";
      blue      = "#${config.lib.stylix.colors.base0D}";
      mauve     = "#${config.lib.stylix.colors.base0E}";
      flamingo  = "#${config.lib.stylix.colors.base0F}";
    };
  };
in
{
  imports =
  [
    ../stylix
  ];

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    settings = lib.recursiveUpdate design stylixPalette;
  };

  stylix.targets.starship.enable = false;
}
