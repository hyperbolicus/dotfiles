let
  sources = import <nixpkgs>;

  pkgs = import sources.nixpkgs {
    overlays = [ ( self: super: {import pkgs/tmux/defaul.nix;})
  }
in pkgs
