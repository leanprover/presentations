{ pkgs ? import ./nixpkgs.nix }:

with pkgs;
stdenv.mkDerivation rec {
  name = "lean";
  src = lib.sourceFilesBySuffices ./. ["Makefile" ".bib" ".bst" ".cls" ".sty" ".tex"];
  buildInputs = [
    gnumake
    pythonPackages.pygments
    (texlive.combine { inherit (texlive)
      scheme-small
      collection-latexextra
      collection-fontsrecommended
      mathpartir
      latexmk; })
     which
  ];
  FONTCONFIG_FILE = makeFontsConf { fontDirectories = [ iosevka dejavu_fonts ]; };
  buildPhase = "mkdir $out && latexmk -pdf -pdflatex=lualatex -shell-escape -outdir=$out ${name}.tex";
}
