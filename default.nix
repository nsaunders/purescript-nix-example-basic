{ pkgs ? import <nixpkgs> {} }:

let
  ps = import ./ps.nix {};
  spagoPkgs = import ./spago-packages.nix { inherit pkgs; };
in

pkgs.stdenv.mkDerivation rec {
  name = "purescript-nix-example-basic";
  src = ./.;
  buildInputs = [
    ps.purs-0_14_1
    ps.spago
  ];
  buildPhase = ''
    ${spagoPkgs.installSpagoStyle}/bin/install-spago-style
    ${spagoPkgs.buildSpagoStyle}/bin/build-spago-style
    ${ps.purs}/bin/purs bundle "output/*/*.js" --main Main --output index.js
  '';
  installPhase = ''
    mkdir -p $out
    mv index.js output $out/
  '';
}
