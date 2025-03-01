{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.nvim;
in {
  options.nvim = {
    enable = mkEnableOption "neovim configuration";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      extraConfig = ''
        augroup cursor_reset
          autocmd!
          autocmd VimLeave * set guicursor=a:ver25
        augroup END

        " Use spaces
        set expandtab
        " 4 spaces
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4

        syntax on

        set number
        set relativenumber
      '';
    };

    environment.systemPackages = with pkgs; [
      neovim
    ];
  };
}