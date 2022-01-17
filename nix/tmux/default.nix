self: super: {
  tmux = super.symlinkJoin  {
    name = "tmux";
    buildInputs = [super.makeWrapper];
    paths = [super.tmux];
    postBuild = ''
      wrapProgram "$out/bin/tmux" \
      --add-flags "-f ${./tmux.conf}"
      '';
  };
  }
