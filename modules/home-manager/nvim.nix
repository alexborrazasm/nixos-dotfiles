#modules/home-manager/nvim.nix
{ config, pkgs, lib, ... }:
let
  cfg = config.nvim;
in {
  options.nvim = {
    enable = lib.mkEnableOption "neovim configuration";
  };

  config = lib.mkIf cfg.enable {
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