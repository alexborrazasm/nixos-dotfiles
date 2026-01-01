{ 
  pkgs, 
  ... 
}: {

    environment.systemPackages = with pkgs; [
      solaar
    ];

    # Add udev rules
    services.udev.packages = [ pkgs.logitech-udev-rules ];
}
