#modules/home-manager/nvim.nix
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
      defaultEditor = true;
      
      extraConfig = ''
        augroup cursor_reset
          autocmd!
          autocmd VimLeave * set guicursor=a:ver25
        augroup END

        " Use spaces
        set expandtab
        " 2 spaces
        set tabstop=2
        set shiftwidth=2
        set softtabstop=2

        syntax on

        set number
        set relativenumber
      '';
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
