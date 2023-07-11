{
  description = "Flake to setup fish";
  inputs.nixpkgs.url = github:NixOS/nixpkgs/22.05;
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: rec {
      packages.fish =
        let pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.symlinkJoin {
          name = "fish";
          buildInputs = [ pkgs.makeWrapper ];
          paths = [ pkgs.fish ];
          postBuild = ''
            wrapProgram "$out/bin/fish" \
            --run 'mkdir -p ~/.config/fish && cp -f ${./fishrc} ~/.config/fish/config.fish'
          '';
        };
      defaultPackage = self.fish;
    });



}

