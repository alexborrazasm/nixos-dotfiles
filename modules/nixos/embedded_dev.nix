{ 
  pkgs,
  username,
  ...
}: {
  # For embedded dev
  # dialout allows access to /dev/ttyUSB* and /dev/ttyACM* without sudo
  # plugdev needed to OpenOCD without root
  users = {
    extraGroups.plugdev = { };
    users.${username}.extraGroups = [ "dialout" "plugdev" ];
  };

  # udev rules for embedded dev
  services.udev.packages = [
    pkgs.platformio-core
    pkgs.openocd
  ];

}