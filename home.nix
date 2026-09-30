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
    vim
    vscode
    direnv          # Shell extension to load environment variables per directory. 
    nix-direnv      # Optimized integration between direnv and Nix to avoid unwanted garbage collection.
  ];

  # Bash Configuration (~/.bashrc)
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
	  };
    initExtra = ''
      export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    '';
    # Injects the direnv initialization script into the interactive Bash session.
    interactiveShellInit = ''
      eval "$(direnv hook bash)"
    '';
  };

  programs.vim = {
  enable = true;
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
    config = {
    user.name = "caramujosan";
    user.email = "gustavocjorge11@yahoo.com.br";
      init.defaultBranch = "main";
    };
  };


  # Allows the Home Manager to manage itself
  programs.home-manager.enable = true;
}



