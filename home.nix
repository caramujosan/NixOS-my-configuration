{ config, pkgs, ... }:

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

programs.bash = {
  enable = true;
  initExtra = ''
    # Seu prompt customizado ou scripts complexos
    export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    eval "$(direnv hook bash)"
  '';
};

