{ mkDerivation, aip, base, bytestring, digit, directory, doctest
, exitcode, filepath, HTTP, lens, network-uri, papa, parsec
, parsers, process, QuickCheck, quickcheck-text, stdenv, tagsoup
, tagsoup-selection, template-haskell, transformers
}:
mkDerivation {
  pname = "aip-post";
  version = "0.0.1";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aip base bytestring digit directory exitcode filepath HTTP lens
    network-uri papa parsec parsers process tagsoup tagsoup-selection
    transformers
  ];
  executableHaskellDepends = [
    base bytestring digit directory filepath HTTP lens network-uri papa
    parsec parsers tagsoup tagsoup-selection transformers
  ];
  testHaskellDepends = [
    base directory doctest filepath parsec QuickCheck quickcheck-text
    template-haskell
  ];
  homepage = "https://github.com/qfpl/aip-post";
  description = "Aeronautical Information Package (AIP)";
  license = stdenv.lib.licenses.bsd3;
}
