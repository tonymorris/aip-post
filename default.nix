{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  sources = {
    papa = pkgs.fetchFromGitHub {
      owner = "qfpl";
      repo = "papa";
      rev = "97ef00aa45c70213a4f0ce348a2208e3f482a7e3";
      sha256 = "0qm0ay49wc0frxs6ipc10xyjj654b0wgk0b1hzm79qdlfp2yq0n5";
    };

    aip = pkgs.fetchFromGitHub {
      owner = "qfpl";
      repo = "aip";
      rev = "295765ff576e18e56f4fae0f997fc794ebf227ab";
      sha256 = "136pv5l0yb1pyc9hcd9vgrhj355c8ym9k93cbcxq0ak68273iahl";
    };

    exitcode = pkgs.fetchFromGitHub {
      owner = "qfpl";
      repo = "exitcode";
      rev = "758639382d38a6afff6c5d2e4f37b600932f5f3a";
      sha256 = "01qbh7kcf6h0ilrfivknfm226x48xmn1gx348aqkgrc2x1l4z8g6";
    };

  };

  modifiedHaskellPackages = haskellPackages.override {
    overrides = self: super: import sources.papa self // {
      aip = pkgs.haskell.lib.dontHaddock ( import sources.aip {});
      exitcode = pkgs.haskell.lib.dontHaddock ( import sources.exitcode {});
      parsers = pkgs.haskell.lib.dontCheck super.parsers;
      tagsoup-selection = pkgs.haskell.lib.doJailbreak super.tagsoup-selection;
    };
  };

  aip-post = modifiedHaskellPackages.callPackage ./aip-post.nix {};

in
  aip-post
