{
  description = "Flake to configure basic setup";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    fish = {
      url = "path:./packages/fish/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tmux = {
      url = "path:./packages/tmux/";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.fish.follows = "fish";
    };
    neovim = {
      url = "path:./packages/neovim/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, tmux, fish, neovim, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        formatter = pkgs.nixpkgs-fmt;
        packages.tmux = tmux.packages.${system}.tmux;
        packages.fish = fish.packages.${system}.fish;
        packages.neovim = neovim.packages.${system}.neovim;
        packages.default = pkgs.symlinkJoin {
          name = "customPackages";
          paths = [
            packages.tmux
            packages.fish
            neovim.packages.${system}.neovim
            pkgs.rnix-lsp
            pkgs.lua-language-server
            pkgs.taskwarrior
            pkgs.tasksh
          ];
        };
      });
}
