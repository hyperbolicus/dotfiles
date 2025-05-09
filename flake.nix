{
  description = "Flake to configure basic setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
        fish_func = pkgs.callPackage ././packages/fish/default.nix;
        tmux_func = pkgs.callPackage ././packages/tmux/default.nix;
        neovim_func = pkgs.callPackage ././packages/neovim/default.nix;
        helix_func = pkgs.callPackage ././packages/helix/default.nix;
        default_packages = with pkgs; [
          lua-language-server
          languagetool
          ltex-ls-plus
          nixd
          taskwarrior3
          tasksh
          fzf
          bat
          nixpkgs-fmt
          ripgrep
          fd
        ]; 
      in rec {
        formatter = pkgs.nixpkgs-fmt;
        packages.fish = fish_func pkgs "";
        packages.tmux = tmux_func pkgs packages.fish "";
        packages.neovim = neovim_func pkgs;
        packages.helix = helix_func pkgs {config= ""; languages="";};
        packages.joined_with_config = fishConfig:
        let fish_custom = 
            fish_func pkgs fishConfig.fish;
            tmux_custom = tmux_func pkgs fish_custom "";
            helix_custom = helix_func pkgs fishConfig.helix;
            in
        pkgs.symlinkJoin {
        name = "customPackages";
          paths = [
            fish_custom
            tmux_custom
            # packages.neovim
            helix_custom
          ] ++ default_packages;
        };

        packages.default = pkgs.symlinkJoin {
          name = "customPackages";
          paths = [
            packages.tmux
            packages.fish
            # packages.neovim
            packages.helix
          ] ++ default_packages
          ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ pkgs.iterm2 ];
        };
      });
}
