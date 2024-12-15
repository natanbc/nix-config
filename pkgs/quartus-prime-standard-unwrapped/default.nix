{
  stdenv,
  lib,
  unstick,
  fetchurl,
  withQuesta ? true,
  supportedDevices ? [
    "Arria II"
    "Arria V"
    "Arria V GZ"
    "Arria 10"
    "Cyclone IV"
    "Cyclone V"
    "Cyclone 10 LP"
    "MAX II/V"
    "MAX 10 FPGA"
    "Stratix IV"
    "Stratix V"
  ],
}:

let
  deviceIds = {
    "Arria II" = "arria";
    "Arria V" = "arriav";
    "Arria V GZ" = "arriavgz";
    "Arria 10" = "arria10";
    "Cyclone IV" = "cyclone";
    "Cyclone V" = "cyclonev";
    "Cyclone 10 LP" = "cyclone10lp";
    "MAX II/V" = "max";
    "MAX 10 FPGA" = "max10";
    "Stratix IV" = "stratixiv";
    "Stratix V" = "stratixv";
  };

  supportedDeviceIds =
    assert lib.assertMsg (lib.all (
      name: lib.hasAttr name deviceIds
    ) supportedDevices) "Supported devices are: ${lib.concatStringsSep ", " (lib.attrNames deviceIds)}";
    lib.listToAttrs (
      map (name: {
        inherit name;
        value = deviceIds.${name};
      }) supportedDevices
    );

  unsupportedDeviceIds = lib.filterAttrs (
    name: value: !(lib.hasAttr name supportedDeviceIds)
  ) deviceIds;

  componentHashes = {
    "arria" = "sha256-yl5Oo1X0eSlTHfVZnUnvytcP575g8n/wAZDbMjePU5c=";
    "arriav" = "sha256-Rv8lxMBrx1aQOlalFT1+J2DBUYHGHn8twfj3dpLAv/o=";
    "arriavgz" = "sha256-eDC7rcL/WzXXECeSNDSvG1Heo+1kjr0fus1wxpcaebI=";
    "arria10" = "sha256-ahBSHA3Tq3Z3DXqXJlyBLKcdyXQzNRqpkdsUbQI4cEM=";
    "cyclone" = "sha256-2huDuTkXt6jszwih0wzusoxRvECi6+tupvRcUvn6eIA=";
    "cyclonev" = "sha256-HoNJkcD96rPQEZtjbtmiRpoKh8oni7gOLVi80c1a3TM=";
    "cyclone10lp" = "sha256-i8VJKqlIfQmK2GWhm0W0FujHcup4RjeXughL2VG5gkY=";
    "max" = "sha256-qh920mvu0H+fUuSJBH7fDPywzll6sGdmEtfx32ApCSA=";
    "max10" = "sha256-XOyreAG3lYEV7Mnyh/UnFTuOwPQsd/t23Q8/P2p6U+0=";
    "stratixiv" = "sha256-1UoJDaaiOFshs7i9B/JdIkGUXF863jYiFNObNX71cJY=";
    "stratixv" = "sha256-Pi5MpgadLGqCr8xcsy80U5ZLpP1sI/dr8gNyTIvu+5k=";
  };

  version = "23.1std.1.993";

  download =
    { name, hash }:
    fetchurl {
      inherit name hash;
      # e.g. "23.1std.0.991" -> "23.1std/921"
      url = "https://downloads.intel.com/akdlm/software/acdsinst/${lib.versions.majorMinor version}std/${lib.elemAt (lib.splitVersion version) 4}/ib_installers/${name}";
    };

  installers = map download (
    [
      {
        name = "QuartusSetup-${version}-linux.run";
        hash = "sha256-wWM4DE4SCda+9bKWOY+RXez3ht0phBI/zeFKa5TzhrA=";
      }
    ]
    ++ lib.optional withQuesta {
      name = "QuestaSetup-${version}-linux.run";
      hash = "sha256-Dne4MLFSGXUVLMd+JgiS/d5RX9t5gs6PEvexTssLdF4=";
    }
  );
  components = map (
    id:
    download {
      name = "${id}-${version}.qdz";
      hash = lib.getAttr id componentHashes;
    }
  ) (lib.attrValues supportedDeviceIds);

in
stdenv.mkDerivation rec {
  inherit version;
  pname = "quartus-prime-standard-unwrapped";

  nativeBuildInputs = [ unstick ];

  buildCommand =
    let
      copyInstaller = installer: ''
        # `$(cat $NIX_CC/nix-support/dynamic-linker) $src[0]` often segfaults, so cp + patchelf
        cp ${installer} $TEMP/${installer.name}
        chmod u+w,+x $TEMP/${installer.name}
        patchelf --interpreter $(cat $NIX_CC/nix-support/dynamic-linker) $TEMP/${installer.name}
      '';
      copyComponent = component: "cp ${component} $TEMP/${component.name}";
      # leaves enabled: quartus, devinfo
      disabledComponents =
        [
          "quartus_help"
          "quartus_update"
          "questa_fe"
        ]
        ++ (lib.optional (!withQuesta) "questa_fse")
        ++ (lib.attrValues unsupportedDeviceIds);
    in
    ''
      echo "setting up installer..."
      ${lib.concatMapStringsSep "\n" copyInstaller installers}
      ${lib.concatMapStringsSep "\n" copyComponent components}

      echo "executing installer..."
      # "Could not load seccomp program: Invalid argument" might occur if unstick
      # itself is compiled for x86_64 instead of the non-x86 host. In that case,
      # override the input.
      unstick $TEMP/${(builtins.head installers).name} \
        --disable-components ${lib.concatStringsSep "," disabledComponents} \
        --mode unattended --installdir $out --accept_eula 1

      echo "cleaning up..."
      rm -r $out/uninstall $out/logs

      # replace /proc pentium check with a true statement. this allows usage under emulation.
      substituteInPlace $out/quartus/adm/qenv.sh \
        --replace-fail 'grep sse /proc/cpuinfo > /dev/null 2>&1' ':'
    '';

  meta = with lib; {
    homepage = "https://fpgasoftware.intel.com";
    description = "FPGA design and simulation software";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
