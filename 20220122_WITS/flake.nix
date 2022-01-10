{
  description = "WITS'22 presentation: Gotta Prove Fast";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
  inputs.flake-utils.url = github:numtide/flake-utils;

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    with import nixpkgs { inherit system; }; rec {
      packages.presentation = stdenv.mkDerivation {
        name = "presentation";
        src = ./.;
        buildInputs = [
          gnumake
          pythonPackages.pygments
          (texlive.combine { inherit (texlive)
            scheme-small
            collection-latexextra
            collection-fontsrecommended
            mathpartir
            biblatex
            latexmk
            # KIT
            bera libertine; })
          which
        ];
        buildPhase = ''
          latexmk -xelatex -shell-escape lean.tex
        '';
        installPhase = ''
          mkdir $out
          mv lean.pdf $out/
        '';
      };

      defaultPackage = packages.presentation;
    });
}
