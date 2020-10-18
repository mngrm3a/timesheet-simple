{ pkgs ? import <nixpkgs> {} }:
with (pkgs);
let
  nixPackages = [ rnix-lsp nixpkgs-fmt ];
  haskellPackages =
    let
      packages = p: with p; [ stack haskell-language-server hspec-discover ];
    in
      [ (haskell.packages.ghc884.ghcWithPackages packages) ];
in
mkShell {
  buildInputs = nixPackages ++ haskellPackages;
}
