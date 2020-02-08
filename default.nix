let
  config = {
    packageOverrides = super: rec {

      haskellPackages = super.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: {
          nix-mwe = haskellPackagesNew.callPackage ./cabal.nix {
            R = super.rWrapper.override {
              packages = with super.rPackages; [ dplyr ];
            };
          };
        };
      };

    };
  };

  pkgs = import <nixpkgs> { inherit config; };

in

  pkgs.haskellPackages.nix-mwe
