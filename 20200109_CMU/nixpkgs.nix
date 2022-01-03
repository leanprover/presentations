import (builtins.fetchTarball {
  name = "nixos-19.03-2019-05-05";
  url = https://github.com/nixos/nixpkgs/archive/8ea36d73256.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "1d59i55qwqd76n2d0hr1si26q333ydizkd91h8lfczb00xnr5pqn";
}) {}
