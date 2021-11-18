{fish, writeText, symlinkJoin, makeWrapper, ...}:
  symlinkJoin  {
    name = "fish";
    buildInputs = [makeWrapper];
    paths = [fish];
    postBuild = ''
      wrapProgram "$out/bin/fish" \
      --run "mkdir -p ~/.config/fish && cp -f ${./fishrc} ~/.config/fish/config.fish"
      '';
  } 
