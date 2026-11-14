{ config, pkgs, ... }:

{
  # User information
  home.username = "caramujosan";
  home.homeDirectory = "/home/caramujosan";

  # Keep this value with the initial version in which you installed Home Manager
  home.stateVersion = "26.05";

  # Packages installed only for user (not global system-wide)
  home.packages = with pkgs; [
    bat
    fastfetch       # System information display (successor to neofetch).
    gedit
    git
    google-chrome
    htop
    keepassxc
    nix-direnv      # Optimized integration between direnv and Nix to avoid unwanted garbage collection.
    plocate
    tilix
    tldr
    tree
    vlc
    wget
    
    # General development packages
    # Languages and Compilers
    #go
    #rustup
    python3
    #kotlin
    #jdk17
      
    # Tools and Containers
    #gcc
    #gnumake
    #direnv      # For local environments (e.g., with Flakes)
    #podman
    #podman-compose
    #devpod
      
    # Editors
    #vscode
    #vscodium
    #android-studio
    #jetbrains.rust-rover
  ];


  # BASH
  # Bash Configuration (~/.bashrc)
  programs.bash = {
    enable = true;
    initExtra = builtins.readFile ./dotfiles/my_bashrc;
  };
  
  # DIRENV
  # Enables integrated direnv and nix-direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # <-- Enables instant caching
    # Optional: enables automatic integration with your shell (Bash)
    enableBashIntegration = true; 
  };
  
  
  # FLATPAK
  services.flatpak = {
    enable = true;
    # Flathub Repo
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    # User Packages
    packages = [
      "com.github.tchx84.Flatseal"
    ];
    # Weekly automatic updates via systemd timer (optional)
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    # Automatically uninstalls Flatpaks installed manually via CLI that are not in this list (optional)
    #uninstallUnmanaged = true;
  };


  # GIT
  # Git declarative management (~/.gitconfig)
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.name = "caramujosan";
      user.email = "gustavocjorge11@yahoo.com.br";
      alias = {
        lg = "log --oneline --graph --decorate";
        st = "status";
        cm = "commit -m";
      };
    };
  };
  
  
  # TILIX
  # Define Tilix as default terminal
  # environment variables so that external applications know which terminal to call
  home.sessionVariables = {
    TERMINAL = "tilix"; 
  };
  dconf.settings = {
    # Adjusting terminal in the Desktop Environment (Gnome)
    "org/gnome/desktop/default-applications/terminal" = {
      exec = "tilix";
      exec-arg = "-e";
    };
  # Converts your JSON color data directly into the dconf format used by Home Manager
    "com/gnumake/tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d" = {
      name = "Tilix_terminal_configuration-2";
      visible-name = "Tilix_terminal_configuration-3";
      background-color = "#1C1C1F";
      badge-color = "#AC7EA8";
      bold-color = "#3584E4";
      cursor-background-color = "#000000";
      cursor-foreground-color = "#FFFFFF";
      foreground-color = "#FAF9F9";
      highlight-background-color = "#000000";
      highlight-foreground-color = "#FFFFFF";
      palette = [
        "#2E3436" "#E01B24" "#2EC27E" "#F5C110"
        "#51A1FF" "#75507B" "#4FD1FD" "#D3D7CF"
        "#555753" "#EA2828" "#4BE482" "#FCE94F"
        "#51A1FF" "#AD7FA8" "#4FD1FD" "#EEEEEC"
      ];
      use-badge-color = false;
      use-bold-color = false;
      use-cursor-color = false;
      use-highlight-color = false;
      use-theme-colors = false;
    };

    # Sets the profile above as the default profile for Tilix
    "com/gnumake/tilix" = {
      default-profile = "2b7c4080-0ddd-46c5-8f23-563fd3ba789d";
    };
  };


  # VIM
  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/my_vimrc;
  };
  

  # Allows the Home Manager to manage itself
  programs.home-manager.enable = true;
}

