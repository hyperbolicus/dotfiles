     pkgs: extraConfig :
        (let 
        defaultConfig = (builtins.readFile ./fishrc) ;
        configFile = pkgs.writeTextFile {
          name = "fishrc";
          text = defaultConfig + "\n" + extraConfig;
          };
        in
        pkgs.symlinkJoin {
          name = "fish";
          buildInputs = [ pkgs.makeWrapper ];
          paths = [ pkgs.fish ];
          postBuild = ''
            wrapProgram "$out/bin/fish" \
            --run 'mkdir -p ~/.config/fish && cp -f ${configFile} ~/.config/fish/config.fish'
          '';
        })
