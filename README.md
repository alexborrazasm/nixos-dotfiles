# My dotfiles for NixOS

Under construction.

## Z3phyrus GRUB theme:

I use [this](https://github.com/hotaru-py/rog-grub).
 
# How to install home-manager in WSL Debian

```bash
sudo apt update && sudo apt upgrade
sudo apt install xz-utils curl
```

Install nix:

```bash
curl -L https://nixos.org/nix/install | sh
```

Load envvars

```bash
. ~/.nix-profile/etc/profile.d/nix.sh
echo ". ~/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc
```

Enable flakes

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
. ~/.nix-profile/etc/profile.d/nix.sh
```

```bash
cd
git clone https://github.com/alexborrazasm/nixos-dotfiles.git
mv ~/nixos-dotfiles/ ~/nix-config
```

Install home manager:

```bash
nix run home-manager/release-24.11 -- switch --flake ~/nix-config/#wsl
```

Change default shell:

```bash
echo "export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive" >> ~/.bashrc
echo "exec zsh" >> ~/.bashrc
```