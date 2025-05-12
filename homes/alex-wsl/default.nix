# homes/wsl/default.nix
{ config, pkgs, inputs, ... }:

{
  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;

  # Basic Home Manager configuration
  home = {
    username = "alex";
    homeDirectory = "/home/alex";
    stateVersion = "24.11";
    
    # Packages to install
    packages = with pkgs; [
    ];
  };

  # Zsh local configuration
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Source nix profile
      source ~/.nix-profile/etc/profile.d/nix.sh
    '';
    shellAliases = {
      sudo = "sudo -E env PATH=$HOME/alex/.nix-profile/bin:$PATH";
      # Aliases for NixOS and Home Manager management
      hms = "nix run home-manager/release-24.11 -- switch --flake ~/nix-config/#wsl";
      nfu = "(cd ~/nix-config && nix flake update && git add flake.lock && git commit -m 'Update flake.lock' && git push)";
      ncg = "sudo nix-collect-garbage -d";
    };
  };

  # nvim clipboard in WSL
  programs.neovim.extraLuaConfig = ''
    vim.g.clipboard = {
      name = "WslClipboard",
      copy = {
        ["+"] = "clip.exe",
        ["*"] = "clip.exe",
      },
      paste = {
        ["+"] = "powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))",
        ["*"] = "powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))",
      },
      cache_enabled = 0,
    }
  '';

  # Direnv configuration for per-directory environment variables
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
