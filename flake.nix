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
	};

	outputs = {self, nixpkgs, tmux, fish, neovim}: {
		packages.x86_64-darwin.tmux = tmux.packages.x86_64-darwin.tmux;
		packages.x86_64-darwin.fish = fish.packages.x86_64-darwin.fish;
		packages.x86_64-darwin.neovim = neovim.packages.x86_64-darwin.neovim;
		packages.x86_64-darwin.default = nixpkgs.legacyPackages.x86_64-darwin.symlinkJoin {
			name = "customPackages";
			paths = [
				self.packages.x86_64-darwin.tmux
				self.packages.x86_64-darwin.fish
				self.packages.x86_64-darwin.neovim
				];
		} ;
		};
}
