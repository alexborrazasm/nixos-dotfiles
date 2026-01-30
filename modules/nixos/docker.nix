{ 
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation.docker = {
    enable = true;
  };

  users.users = {
    docker = {
      isNormalUser = true;
      group = "docker";
      extraGroups = [
        "docker" # docker access
      ];
      uid = 1000;
      home = "/srv/docker";
      createHome = false;
    };
  };
  
  systemd.tmpfiles.rules = [
    # Root directory for Docker Compose projects and service configs
    "d /srv/docker 0775 docker docker -"
    # Web Assets: Persistent storage for static websites and public assets
    "d /srv/www    0775 docker docker -"
  ];
  
  environment.shellAliases = {
    sd = "sudo -u docker -i";
  };

}