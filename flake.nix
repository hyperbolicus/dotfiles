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
    };
    neovim = {
      url = "path:./packages/neovim/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, fish, tmux, neovim, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        formatter = pkgs.nixpkgs-fmt;
        packages.fish = fish.packages.${system}.fish;
        packages.tmux = tmux.packages.${system}.tmux packages.fish;
        packages.neovim = neovim.packages.${system}.neovim;
        packages.joined_with_config = fishConfig:
        let fish = 
            fish.packages.${system}.fish_with_config fishConfig;
            tmux = tmux.packages.${system}tmux packages.fish;
            in
        pkgs.symlinkJoin {
name = "customPackages";
          paths = [
            fish
            tmux
            neovim.packages.${system}.neovim
            pkgs.lua-language-server
	    pkgs.nixd
            pkgs.taskwarrior
            pkgs.tasksh
          ];
        };

        packages.default = pkgs.symlinkJoin {
          name = "customPackages";
          paths = [
            packages.tmux
            packages.fish
            neovim.packages.${system}.neovim
            pkgs.lua-language-server
	    pkgs.nixd
            pkgs.taskwarrior
            pkgs.tasksh
          ];
        };
      });
}
