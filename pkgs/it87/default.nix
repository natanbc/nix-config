{ stdenv, lib, fetchFromGitHub, kernel, kmod }:

stdenv.mkDerivation rec {
  name = "it87-${version}-${kernel.version}";
  version = "14b1de2";

  src = fetchFromGitHub {
    owner = "frankcrawford";
    repo = "it87";
    rev = "14b1de2fb49db4e73b58177bc43daa71ceb8e92f";
    sha256 = "sha256-DPQWPWAPNm3LJk8sY2lPx+D2h/5j1GGyygE0nzUBiVY=";
  };

  patches = [
    ./nixos-dirs.patch
  ];

  hardeningDisable = [ "pic" ];
  nativeBuildInputs = kernel.moduleBuildDependencies ++ [ kmod ];

  makeFlags = [
    "TARGET=${kernel.modDirVersion}"
    "KERNEL_BUILD=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "SYSTEM_MAP=${kernel}/System.map"
    "MOD_ROOT=${kernel}"
    "DRIVER_VERSION=${version}"
    "MODDESTDIR=$(out)"
  ];

  meta = with lib; {
    description = "A kernel module to interface with ITE Super I/O chips";
    homepage = "https://github.com/frankcrawford/it87";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
