{
  description = "A very basic flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";


  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: rec {

      formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      packages.neovim =
        let
          super = nixpkgs.legacyPackages.${system};
          vim-lsp-settings = super: (super.vimUtils.buildVimPluginFrom2Nix {
            name = "vim-lsp-settings";
            buildDependencies = [ super.shellcheck ];
            src = super.fetchFromGitHub {
              owner = "mattn";
              repo = "vim-lsp-settings";
              rev = "33ad6db29179cf16d6e35feddbbb343bba477623";
              sha256 = "XK1Y2qVe3ajjGmRdy/fJ6Nnb7PyHYCntJFJyjqr4uB4=";
            };
          });
          configs = super.luajit.pkgs.buildLuaPackage {
            pname = "personalconfig";
            version = "0.0.1";
            src = ./lua;

          };
        in

        super.neovim.override {
          vimAlias = true;
          viAlias = true;
          extraLuaPackages = _: [ configs super.luajit.pkgs.serpent ];
            withPython3 = true;
            extraPython3Packages= _: with super.python3Packages; [six packaging tasklib];
          configure = {
            customRC = "lua require('personalconfig')";
            packages.myPlugins = {
              start = with super.vimPlugins ; [
                nvim-cmp
                nvim-lspconfig
                cmp-buffer
                cmp-path
                cmp-cmdline
                cmp-nvim-lsp
                luasnip
                taskwiki
                vimwiki
                nvim-treesitter.withAllGrammars
              ];
            };
          };

        };


    });
}
