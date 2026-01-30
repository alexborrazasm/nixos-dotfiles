{ 
  pkgs,
  username,
  ...
}: {
  users.users = {
    ${username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"   # sudo
        "docker"  # docker access
      ];
      uid = 1001;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBkMYwuNdqWYMYnW/xb5cqJWmn+0+vkwfJ7iLJjtAag0 alexborrazasm@gmail.com"
      ];
    };
  };

  # Sudo without password
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

}
