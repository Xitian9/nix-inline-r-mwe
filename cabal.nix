{ mkDerivation, base, hpack, inline-r, pkgconfig, R, stdenv }:
mkDerivation {
  pname = "nix-mwe";
  version = "0.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base inline-r ];
  libraryPkgconfigDepends = [ R ];
  libraryToolDepends = [ hpack pkgconfig ];
  executableHaskellDepends = [ base ];
  prePatch = "hpack";
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
