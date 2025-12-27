{ 
  config, 
  pkgs, 
  ... 
}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 14.0;
    };

    settings = {
      # Cursor
      cursor_shape = "beam";
      cursor_blink_interval = 0;

      # Window
      confirm_os_window_close = 0;
      remember_window_size = true;
      window_padding_width = 10;
      
      # Scroll
      scrollback_lines = 5000;
      scrollback_pager_history_size = 10;

      # Tabs
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      # Shell integration
      shell_integration = "enabled";

      # Clipboard
      copy_on_select = "yes";
      strip_trailing_spaces = "smart";
    };

    keybindings = {
      # Tabs
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";

      # Splits
      "ctrl+shift+enter" = "launch --location=hsplit";
      "ctrl+shift+|" = "launch --location=vsplit";

      # Font size
      "ctrl+plus" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
      "ctrl+0" = "change_font_size all 0";
    };

    themeFile = "Catppuccin-Mocha";
  };

  # Ensure kitty is default terminal
  home.sessionVariables.TERMINAL = "kitty";
}

