{ stdenv, which, cmake, pkgsCross }:

stdenv.mkDerivation {
  pname = "keystone-sdk";
  version = "0.1"; # TODO

  src = ./.;

  preConfigure = ''
    mkdir -p $out
    cmakeFlagsArray+=(
      "-DKEYSTONE_SDK_DIR=$out"
    )
  '';

  nativeBuildInputs = [
    cmake
    which
    pkgsCross.riscv64.buildPackages.gcc
  ];
}
