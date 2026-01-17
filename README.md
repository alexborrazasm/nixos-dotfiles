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

