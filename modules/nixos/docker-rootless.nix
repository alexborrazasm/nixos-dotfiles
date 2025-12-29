{
  config, 
  pkgs, 
  ... 
}: {

  virtualisation.docker = {
    # Disable the system wide Docker daemon
    enable = false;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

}