{ 
  pkgs, 
  ... 
}: {
  programs.vscode = {
    enable = true;
  };

  # User-level tools required by PlatformIO
  home.packages = with pkgs; [
    # Python is installed by utils module
  ];
}

