{ runCommandCC }:
runCommandCC "sv_second_pcie_hip.so" {} ''
  $CC -shared -o $out -fPIC ${./sv_second_pcie_hip.c}
''
