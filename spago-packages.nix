# This file was generated by Spago2Nix

{ pkgs ? import <nixpkgs> {} }:

let
  inputs = {

    "console" = pkgs.stdenv.mkDerivation {
        name = "console";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-console.git";
          rev = "d7cb69ef8fed8a51466afe1b623868bb29e8586e";
          sha256 = "0fzzzqjgrz33pb2jf7cdqpg09ilxb7bsrc7sbfq52wjg0sx9aq6g";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "effect" = pkgs.stdenv.mkDerivation {
        name = "effect";
        version = "v3.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-effect.git";
          rev = "985d97bd5721ddcc41304c55a7ca2bb0c0bfdc2a";
          sha256 = "1n9qr85knvpm4i0qhm8xbgfk46v9y843p76j278phfs9l6aywzsn";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "prelude" = pkgs.stdenv.mkDerivation {
        name = "prelude";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-prelude.git";
          rev = "37717776a3693fd5a0a614239f7de1285cba8cdf";
          sha256 = "1312g2a5c5j89048v1ks0jg25caysmzclwcmnc3r0dvgl935z00y";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

    "psci-support" = pkgs.stdenv.mkDerivation {
        name = "psci-support";
        version = "v5.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/purescript/purescript-psci-support.git";
          rev = "f26fe8266a63494080476333e22f971404ea8846";
          sha256 = "16vhf8hapd7rcgmafmjpiq7smhzdh3300f2idk1q4kk01yxn8ddj";
        };
        phases = "installPhase";
        installPhase = "ln -s $src $out";
      };

  };

  cpPackage = pkg:
    let
      target = ".spago/${pkg.name}/${pkg.version}";
    in ''
      if [ ! -e ${target} ]; then
        echo "Installing ${target}."
        mkdir -p ${target}
        cp --no-preserve=mode,ownership,timestamp -r ${toString pkg.outPath}/* ${target}
      else
        echo "${target} already exists. Skipping."
      fi
    '';

  getGlob = pkg: ''".spago/${pkg.name}/${pkg.version}/src/**/*.purs"'';

  getStoreGlob = pkg: ''"${pkg.outPath}/src/**/*.purs"'';

in {
  inherit inputs;

  installSpagoStyle = pkgs.writeShellScriptBin "install-spago-style" ''
      set -e
      echo installing dependencies...
      ${builtins.toString (builtins.map cpPackage (builtins.attrValues inputs))}
      echo "echo done."
  '';

  buildSpagoStyle = pkgs.writeShellScriptBin "build-spago-style" ''
      set -e
      echo building project...
      purs compile ${builtins.toString (builtins.map getGlob (builtins.attrValues inputs))} "$@"
      echo done.
  '';

  buildFromNixStore = pkgs.writeShellScriptBin "build-from-store" ''
      set -e
      echo building project using sources from nix store...
      purs compile ${builtins.toString (
        builtins.map getStoreGlob (builtins.attrValues inputs))} "$@"
      echo done.
  '';

  mkBuildProjectOutput =
    { src, purs }:

    pkgs.stdenv.mkDerivation {
      name = "build-project-output";
      src = src;

      buildInputs = [ purs ];

      installPhase = ''
        mkdir -p $out
        purs compile "$src/**/*.purs" ${builtins.toString
          (builtins.map
            (x: ''"${x.outPath}/src/**/*.purs"'')
            (builtins.attrValues inputs))}
        mv output $out
      '';
    };
}
