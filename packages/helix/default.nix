
      super:
      (
      let defaultConfig = (builtins.readFile ./config.toml);
      configFile = super.writeTextFile {
            name = "config.toml";
            text = defaultConfig;
      };
      languageFile = super.writeTextFile {
            name = "languages.toml";
            text = ''
            [[language]]
            name = "markdown"
            language-servers = ["ltex-ls-plus"]

            [language-server.ltex-ls-plus.config]
            command = "ltex-ls-plus"
            ltex.language = "en-GB"
            '';
            
      };
      in
      super.symlinkJoin {
            name = "hx";
            buildInputs = [ super.makeWrapper ];
            paths = [ super.helix ];
            postBuild = ''
            wrapProgram "$out/bin/hx" --run "mkdir -p ~/.config/helix && cp -f ${configFile} ~/.config/helix/config.toml" --run "cp -f ${languageFile} ~/.config/helix/languages.toml"
            '';
            
      }

      

    )
