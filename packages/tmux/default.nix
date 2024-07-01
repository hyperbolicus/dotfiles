          pkgs: fish:
          (
          let
          configFile = pkgs.writeTextFile {
            name = "tmux.conf";
            text = ''

					set -g default-terminal "xterm-256color"
					set -sg escape-time 0
					setw -g mode-keys vi

					bind '"' split-window -c "#{pane_current_path}"
					bind % split-window -h -c "#{pane_current_path}"
					bind c new-window -c "#{pane_current_path}"


# Start windows and panes at 1, not 0
					set -g base-index 1
					setw -g pane-base-index 1
					set-option -g default-shell ${fish}/bin/fish
					set -g status-bg black
					set -g status-fg white

                                        set-option -g detach-on-destroy off
					'';
          };
        in

        pkgs.symlinkJoin {
          name = "tmux";
          buildInputs = [ pkgs.makeWrapper fish ];
          paths = [ pkgs.tmux fish ];
          postBuild = ''
            					wrapProgram "$out/bin/tmux" \
            					--add-flags "-f ${configFile}"
            					'';
        })
