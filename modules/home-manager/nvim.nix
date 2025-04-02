#modules/home-manager/nvim.nix
{ config, pkgs, lib, ... }:

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

      extraLuaConfig = ''
        vim.api.nvim_create_augroup("cursor_reset", { clear = true })
        vim.api.nvim_create_autocmd("VimLeave", {
          group = "cursor_reset",
          pattern = "*",
          command = "set guicursor=a:ver25"
        })

        -- System clipboard shortcuts 
        vim.keymap.set("n", "<Space>y", '"+y', { noremap = true, silent = true })
        vim.keymap.set("v", "<Space>y", '"+y', { noremap = true, silent = true })
        vim.keymap.set("x", "<Space>y", '"+y', { noremap = true, silent = true })
        vim.keymap.set("n", "<Space>d", '"+d', { noremap = true, silent = true })
        vim.keymap.set("v", "<Space>d", '"+d', { noremap = true, silent = true })
        vim.keymap.set("x", "<Space>d", '"+d', { noremap = true, silent = true })
        vim.keymap.set("n", "<Space>p", '"+p', { noremap = true, silent = true })
        vim.keymap.set("n", "<Space>P", '"+P', { noremap = true, silent = true })
        vim.keymap.set("v", "<Space>p", '"+p', { noremap = true, silent = true })
        vim.keymap.set("v", "<Space>P", '"+P', { noremap = true, silent = true })


        -- Use spaces
        vim.opt.expandtab = true
        -- 2 spaces
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.softtabstop = 2

        vim.opt.syntax = "on"
        vim.opt.number = true
        vim.opt.relativenumber = true
      '';
    };

    home.packages = with pkgs; [
      wl-clipboard
      xclip
    ];
    
    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
