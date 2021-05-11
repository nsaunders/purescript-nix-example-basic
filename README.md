# purescript-nix-example-basic

## Purpose
The goal of this project is to serve as a **minimalistic** example of how to use
Nix to build a PureScript project.

> :warning: I am a Nix newbie and would love to learn from you. If you have any advice, please [file an issue](https://github.com/nsaunders/purescript-nix-example-basic/issues).

## Building
```bash
# Required every time any source file or dependency has changed since last build.
# I think this is normal: https://discourse.purescript.org/t/purs-nix-manage-purescript-projects-with-nix/2290/4
nix-shell --run "spago build --then 'spago2nix generate'"`

# This is normal.
nix-build
```
