{
  description = "Flake to configure basic setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
        fish_func = pkgs.callPackage ././packages/fish/default.nix;
        tmux_func = pkgs.callPackage ././packages/tmux/default.nix;
        neovim_func = pkgs.callPackage ././packages/neovim/default.nix;
      in rec {
        formatter = pkgs.nixpkgs-fmt;
        packages.fish = fish_func pkgs "";
        packages.tmux = tmux_func pkgs packages.fish;
        packages.neovim = neovim_func pkgs;
        packages.joined_with_config = fishConfig:
        let fish_custom = 
            fish_func pkgs fishConfig;
            tmux_custom = tmux_func pkgs fish_custom;
            in
        pkgs.symlinkJoin {
name = "customPackages";
          paths = [
            fish_custom
            tmux_custom
            packages.neovim
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
            packages.neovim
            pkgs.lua-language-server
	    pkgs.nixd
            pkgs.taskwarrior
            pkgs.tasksh
          ];
        };
      });
}
