{ 
  config, 
  pkgs, 
  ... 
}: {
    # Install HeadsetControl
    environment.systemPackages = with pkgs; [
      headsetcontrol
    ];

    # Add udev rules for HeadsetControl
    services.udev.packages = [ pkgs.headsetcontrol ];
}

