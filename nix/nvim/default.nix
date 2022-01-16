  self: super: {
    vim-lsp-settings = super.vimUtils.buildVimPluginFrom2Nix {
      name = "vim-lsp-settings";
      buildDependencies = [super.shellcheck];
      src = super.fetchFromGitHub {
        owner = "mattn";
        repo = "vim-lsp-settings";
        rev = "c796dd1878bede91c110a858123368861fc5aa34";
        sha256 = "XK1Y2qVe3ajjGmRdy/fJ6Nnb7PyHYCntJFJyjqr4uB4=";
      };
    };

    neovim =  super.neovim.override {
      viAlias = true;
      vimAlias = true;
      configure = {
        customRC = ''
              syntax enable
              set nocompatible

              filetype plugin indent on


              set hidden
              set noswapfile
              set smartcase
              set smarttab
              set smartindent
              set autoindent
              set expandtab
              set shiftwidth=2
              set softtabstop=2
              set background=dark
              set laststatus=2
              set ignorecase
              set wildmode=longest,list,full
              set nu
        '';
        packages.myVimPackages = {
          start = [
            super.vimPlugins.vim-lsp
            super.vimPlugins.vim-nix
            self.vim-lsp-settings
          ];

        };
      };
    };
  }
