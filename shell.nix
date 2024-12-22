{ pkgs ? import <nixpkgs> { } }:

with pkgs;
mkShell {
  name = "nerdfont.vim";
  buildInputs = [
    perl
    jq
  ];
}
