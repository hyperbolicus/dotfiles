          pkgs: fish: extraConfig:
          (
          let
          defaultConfig = (builtins.readFile ./tmux.conf);
          configFile = pkgs.writeTextFile {
            name = "tmux.conf";
            text = defaultConfig + "\n" + extraConfig;
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
