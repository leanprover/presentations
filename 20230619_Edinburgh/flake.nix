{
  description = "University of Edinburgh 2023: Syntax Extensibility in Lean 4";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  inputs.flake-utils.url = github:numtide/flake-utils;

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    with import nixpkgs { inherit system; }; rec {
      packages.presentation = stdenv.mkDerivation {
        name = "presentation";
        src = ./.;
        buildInputs = [
          gnumake
          python3Packages.pygments
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
        FONTCONFIG_FILE = makeFontsConf { fontDirectories = [ iosevka dejavu_fonts ]; };
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
