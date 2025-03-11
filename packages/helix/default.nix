
      super: extraConfig:
      (
      let defaultConfig = (builtins.readFile ./config.toml);
      configFile = super.writeTextFile {
            name = "config.toml";
            text = defaultConfig + "\n" + extraConfig.config;
      };
      defaultLanguages = (builtins.readFile ./languages.toml);
      languageFile = super.writeTextFile {
            name = "languages.toml";
            text = defaultLanguages + "\n" + extraConfig.languages;
            
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
