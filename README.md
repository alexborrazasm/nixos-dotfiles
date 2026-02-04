TODO

vscode OS keyring error 
adding "password-store": "gnome-libsecret" to ~/.vscode/argv.json
https://github.com/microsoft/vscode/issues/187338


on wsl
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

mkdir -p ~/.config/nix
nano ~/.config/nix/nix.conf
add:
experimental-features = nix-command flakes

nix run home-manager/master -- switch --flake .#wsl

VPS

entramos al vps con debian 13

instalamos nix

sh <(curl -L https://nixos.org/nix/install) --daemon

sudo su

instalamos nixos-everywere

nix-env -iE "_: with import <nixpkgs/nixos> { configuration = {}; }; \
  with config.system.build; [ nixos-generate-config ]"

generamos un configuración

nixos-generate-config --no-filesystems --root /mnt

copiar la configuración del hardware,
Copy from /mnt the hardware-configuration.nix file.

/mnt/etc/nixos/hardware-configuration.nix

nix run github:nix-community/nixos-anywhere -- --flake .#ovh-vps debian@152.228.129.154

remove know host entrys

nixos-rebuild switch --flake .#ovh-vps --target-host "root@<vps-ip>"

ssh root@ tall es NIXOS

