{
  description = "A very basic flake";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/22.05;
  inputs.flake-utils.url = "github:numtide/flake-utils";


  outputs = { self, nixpkgs, flake-utils}:
  flake-utils.lib.eachDefaultSystem (system: rec {

    packages.neovim = let 
      super = nixpkgs.legacyPackages.${system};
      vim-lsp-settings = super: (super.vimUtils.buildVimPluginFrom2Nix {
        name = "vim-lsp-settings";
        buildDependencies = [super.shellcheck];
        src = super.fetchFromGitHub {
          owner = "mattn";
          repo = "vim-lsp-settings";
          rev = "c796dd1878bede91c110a858123368861fc5aa34";
          sha256 = "XK1Y2qVe3ajjGmRdy/fJ6Nnb7PyHYCntJFJyjqr4uB4=";
        };
      });
      asyncomplete-omni = super: (super.vimUtils.buildVimPluginFrom2Nix {
        name = "asyncomplete-omni";
        buildDependencies = [super.shellcheck];
        src = super.fetchFromGitHub {
          owner = "yami-beta";
          repo = "asyncomplete-omni.vim";
          rev = "f13986b671a37d6320476af6bc066697e71463c1";
          sha256 = "RtHr7J+B95/SWzGwPp9vaktUWj1rsw3xioBbgRK+HPg=";
        };
      });

    in

    nixpkgs.legacyPackages.${system}.neovim.override {
      vimAlias = true;
      viAlias = true;
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
        packages.myPlugins =  {
          start = with super.vimPlugins ; [    vim-nix
          vim-lsp
          (vim-lsp-settings super)
          dhall-vim
          (asyncomplete-omni super)
          asyncomplete-vim
          asyncomplete-lsp-vim
          (nvim-treesitter.withPlugins (_: super.tree-sitter.allGrammars))
        ];
      };
    };

  };


});
}
