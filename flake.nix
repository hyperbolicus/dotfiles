{
	description = "Flake to configure basic setup";

	inputs = {
		nixpkgs.url = github:NixOS/nixpkgs/22.05;
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

        outputs = {self, nixpkgs, tmux, fish, neovim, flake-utils}:
        flake-utils.lib.eachDefaultSystem (system: 
          let pkgs = nixpkgs.legacyPackages.${system};
          in rec {
		packages.tmux = tmux.packages.${system}.tmux;
		packages.fish = fish.packages.${system}.fish;
		packages.neovim = neovim.packages.${system}.neovim;
		packages.default = pkgs.symlinkJoin {
			name = "customPackages";
			paths = [
				self.packages.${system}.tmux
				self.packages.${system}.fish
				self.packages.${system}.neovim
				];
		} ;
		});
}
