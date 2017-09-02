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
      rev = "d544b979a709a2f0899c1b137db9d74928e42f12";
      sha256 = "02x8jxr5yxciz3lwkq4bbclfd18hq697fy768f8vywywpvrxbr3b";
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
