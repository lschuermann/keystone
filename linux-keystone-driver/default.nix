{ lib
# The Linux kernel Nix package for which this module is compiled.
# Either 'pkgs.linux_6_2` or the custom kernel created above.
, kernel
, stdenv
}:

stdenv.mkDerivation rec {
  pname = "keystone-linux-driver";
  version = "0.1";

  src = ./.;

  setSourceRoot = ''
    export sourceRoot=$(pwd)/linux-keystone-driver
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = kernel.makeFlags ++ [
    "-C"
    "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(sourceRoot)"
  ];

  buildFlags = [ "modules" ];
  installFlags = [ "INSTALL_MOD_PATH=${placeholder "out"}" ];
  installTargets = [ "modules_install" ];

  meta = with lib; {
    description = "Keystone Enclave driver for Linux";
    platforms = platforms.linux;
  };
}
