{
  config,
  pkgs,
  inputs,
  ...
}: {

  home.packages = with pkgs; [
    inputs.sunsetr.packages.${pkgs.system}.sunsetr
  ];
  
  home.file.".config/sunsetr/sunsetr.toml" = {
    source = ./sunsetr.toml;
    force = true;
  };
  
}