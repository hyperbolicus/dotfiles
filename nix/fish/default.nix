self: super:{
  fish = super.symlinkJoin  {
    name = "fish";
    buildInputs = [super.makeWrapper];
    paths = [super.fish];
    postBuild = ''
      wrapProgram "$out/bin/fish" \
      --run "mkdir -p ~/.config/fish && cp -f ${./fishrc} ~/.config/fish/config.fish"
      '';
    };
  }
