{ config, pkgs, ... }:

{
  # User information
  home.username = "caramujosan";
  home.homeDirectory = "/home/caramujosan";

  # Keep this value with the initial version in which you installed Home Manager
  home.stateVersion = "26.05";

  # Packages installed only for user (not global, not system-wide)
  home.packages = with pkgs; [
    fastfetch       # System information display (successor to neofetch).
    gedit
    git             # Version control.
    google-chrome
    htop            # Interactive process monitor.
    keepassxc
    vscode
    direnv          # Shell extension to load environment variables per directory. 
    nix-direnv      # Optimized integration between direnv and Nix to avoid unwanted garbage collection.
  ];

  # Enables integrated direnv and nix-direnv
	  programs.direnv = {
	    enable = true;
	    nix-direnv.enable = true; # <-- Enables instant caching!
	    
	    # Optional: enables automatic integration with your shell (Bash)
	    enableBashIntegration = true; 
	};

  # Bash Configuration (~/.bashrc)
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
	  };
    initExtra = ''
      export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    '';
  };

  programs.vim = {
  enable = true;
  plugins = with pkgs.vimPlugins; [ gruvbox ];
  extraConfig = ''
    set number
    set relativenumber
    set tabstop=4
    syntax on
    colorscheme gruvbox
  '';
  };

  # Git declarative management (~/.gitconfig)
  programs.git = {
    enable = true;
    userName = "caramujosan";
    userEmail = "gustavocjorge11@yahoo.com.br";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };


  # Allows the Home Manager to manage itself
  programs.home-manager.enable = true;
}



