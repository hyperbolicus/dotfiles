{
	description = "Flake to setup Tmux with fish";
	inputs.nixpkgs.url = github:NixOS/nixpkgs/22.05;
	inputs.fish.url = "path:./fish/";
	inputs.flake-utils.url = "github:numtide/flake-utils";

        outputs = {self, nixpkgs, fish, flake-utils} : 
          flake-utils.lib.eachDefaultSystem (system: rec {
		packages.tmux =
			let
			pkgs = nixpkgs.legacyPackages.x86_64-darwin;
			configFile = pkgs.writeTextFile {
				name = "tmux.conf";
				text = ''

					set -g default-terminal "screen-256color"
					set -sg escape-time 0
					setw -g mode-keys vi

					bind '"' split-window -c "#{pane_current_path}"
					bind % split-window -h -c "#{pane_current_path}"
					bind c new-window -c "#{pane_current_path}"


# Start windows and panes at 1, not 0
					set -g base-index 1
					setw -g pane-base-index 1
					set-option -g default-shell ${fish.packages.${system}.fish}/bin/fish
					set -g status-bg black
					set -g status-fg white
					'';
			};
		in 

			with import nixpkgs {system = "x86_64-darwin";}; symlinkJoin  {
				name = "tmux";
				buildInputs = [pkgs.makeWrapper fish.packages.${system}.fish];
				paths = [pkgs.tmux fish.packages.${system}.fish];
				postBuild = ''
					wrapProgram "$out/bin/tmux" \
					--add-flags "-f ${configFile}"
					'';
			};
                      });
}

