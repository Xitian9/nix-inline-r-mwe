let
  thisOverlay = self: super: {
    my-R = self.rWrapper.override {
      packages = with self.rPackages; [ dplyr ];
    };

    haskellPackages = super.haskellPackages.override {
      overrides = hself: hsuper: {
        nix-mwe = self.haskell.lib.overrideCabal (hself.callCabal2nix "nix-mwe" ./. {}) (oldAttrs: {
          buildTools = oldAttrs.buildTools or [] ++ [ self.makeWrapper ];
          postInstall = oldAttrs.postInstall or "" + ''
            wrapProgram $out/bin/nix-mwe --prefix 'PATH' ':' "${self.lib.getBin self.my-R}/bin"
          '';
        });

        inline-r = self.haskell.lib.overrideCabal hsuper.inline-r (oldAttrs: {
          buildDepends = (oldAttrs.buildDepends or []) ++ [ self.R ];
        });
      };
    };
  };

  nixpkgsSrc =
    builtins.fetchTarball {
      # nixpkgs master as of 2020-02-08.
      url = "https://github.com/NixOS/nixpkgs/archive/4e95bba3d39360e405d567089d8e17fc9433fc69.tar.gz";
      sha256 = "sha256:1xzilrxkf0jdd0ck2f2sbjxxplz73g2r0kpjyn5ka5l8frc1zlii";
    };

  pkgs = import nixpkgsSrc { overlays = [ thisOverlay ]; };
in

pkgs.haskellPackages.nix-mwe
