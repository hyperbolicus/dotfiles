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
          rev = "33ad6db29179cf16d6e35feddbbb343bba477623";
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
lua dofile("${./base.lua}")

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
