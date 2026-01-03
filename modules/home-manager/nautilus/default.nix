{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nautilus
  ];

  services.udiskie = {
    enable = true;
    settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
          file_manager = "${pkgs.nautilus}/bin/nautilus";
        };
    };
  };

}