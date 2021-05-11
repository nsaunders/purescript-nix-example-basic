# purescript-nix-example-basic

## Purpose
The goal of this project is to serve as a **minimalistic** example of how Nix to
build a PureScript project.

> :warning: I am a Nix newbie and would love to learn from you. If you have any advice, please [file an issue](https://github.com/nsaunders/purescript-nix-example-basic/issues).

## Building
```bash
nix-shell --run "spago build --then 'spago2nix generate'"` # Required every time any source file or dependency changes. Not sure whether normal or I'm doing something wrong.
nix-build
```
