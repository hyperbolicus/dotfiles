self: super: {

  neovim = super.neovim.override {
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
      vam.knownPlugins = super.vimPlugins // ({
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
        asyncomplete-lsp = super.vimUtils.buildVimPluginFrom2Nix {
          name = "asyncomplete-lsp";
          buildDependencies = [super.shellcheck];
          src = super.fetchFromGitHub {
            owner = "prabirshrestha";
            repo = "asyncomplete-lsp";
            rev = "9c7651894c2c6d656c0dc71e87cfabbbb71b9c78";
            sha256 = "XK1Y2qVe3ajjGmRdy/fJ6Nnb7PyHYCntJFJyjqr4uB4=";
          };
        };
      }); 
      vam.pluginDictionaries = [
        "vim-nix"
        "vim-lsp"
        "vim-lsp-settings"
        "dhall-vim"
        "robotframework-vim"
        "asyncomplete-vim"
        "asyncomplete-lsp"
      ];
    };
  };}

