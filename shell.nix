{ pkgs ? import <nixpkgs> {} }:

let
  ps = import ./ps.nix {};
in

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs-14_x
    ps.spago2nix
    ps.purs-0_14_1
    ps.spago
  ];
}
