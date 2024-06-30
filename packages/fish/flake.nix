{
  description = "Flake to setup fish";
  inputs.nixpkgs.url = github:NixOS/nixpkgs/22.05;
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils}:
    flake-utils.lib.eachDefaultSystem (system: rec {
      packages.fish_with_config = extraConfig :
        (let pkgs = nixpkgs.legacyPackages.${system};
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
        });
      packages.fish = packages.fish_with_config "";
      defaultPackage = self.fish;
    });



}

