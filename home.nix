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


 # Git declarative management (~/.gitconfig)
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.name = "caramujosan";
      user.email = "gustavocjorge11@yahoo.com.br";
    };   
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

    # Natively declarative options supported by Home Manager
    settings = {
      background = "dark";
      mouse = "a";
      number = true;
      relativenumber = true;
      ignorecase = true;
      smartcase = true;
      hidden = true;
      modeline = false;
      tabstop = 4;
    };

    # Raw VimL Script injected directly at the end of ~/.vimrc
    extraConfig = ''
      " Retorna o cursor para a última posição conhecida ao abrir um arquivo
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

      filetype plugin indent on
      set showcmd
      set showmatch
      set autowrite
      set wildmode=longest,list
      set hlg=pt    
      set ul=500     
      set ai          
      set hls          
      set incsearch

      " Highlight search 
      hi Search ctermbg=yellow ctermfg=black
      hi IncSearch ctermbg=yellow ctermfg=black

      " Mappings
      nnoremap n nzz
      nnoremap N Nzz
      nnoremap * *zz
      nnoremap # #zz
      nnoremap g* g*zz
      nnoremap g# g#zz
      nnoremap cs :let @/=""<cr>
      
      " Enable the ruler (shows line and column in the bottom right corner)
      set ruler
      hi StatusLine ctermfg=white
      set laststatus=2

      noremap <F2> :hi Comment ctermfg=black guifg=black<cr>
      noremap <F3> :hi Comment term=bold ctermfg=cyan guifg=cyan<cr>

      cab W w | cab Q q | cab Wq wq | cab wQ wq | cab WQ wq
      imap { {}<left>
      imap ( ()<left>
      imap [ []<left>

      au BufWritePost *.sh  !chmod +x %

      au FileType sh let b:is_bash=1

      syn case ignore
      syn keyword p_c caramujosan
      hi p_c ctermbg=white ctermfg=black

      autocmd BufWinLeave *.* mkview
      autocmd BufWinEnter *.* silent loadview

      syntax on
    '';
  };


  # Allows the Home Manager to manage itself
  programs.home-manager.enable = true;
}


