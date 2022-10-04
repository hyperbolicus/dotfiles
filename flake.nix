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
		packages.tmux = tmux.packages.x86_64-darwin.tmux;
		packages.fish = fish.packages.x86_64-darwin.fish;
		packages.neovim = neovim.packages.x86_64-darwin.neovim;
		packages.default = pkgs.symlinkJoin {
			name = "customPackages";
			paths = [
				self.packages.x86_64-darwin.tmux
				self.packages.x86_64-darwin.fish
				self.packages.x86_64-darwin.neovim
				];
		} ;
		});
}
