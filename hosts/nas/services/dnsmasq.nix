{
  networking = {
    firewall.interfaces = {
      enp1s0 = {
        allowedTCPPorts = [ 139 445 5201 ];
        allowedUDPPorts = [ 67 5201 ];
      };
      enp1s0d1 = {
        allowedTCPPorts = [ 139 445 5201 ];
        allowedUDPPorts = [ 67 5201 ];
      };
    };
    interfaces = {
      enp1s0 = {
        ipv4.addresses = [{
          address = "10.0.0.1";
          prefixLength = 24;
        }];
        mtu = 9000;
      };
      enp1s0d1 = {
        ipv4.addresses = [{
          address = "10.0.0.2";
          prefixLength = 24;
        }];
        mtu = 9000;
      };
    };
  };

  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = false;
    settings = {
      bind-interfaces = true;
      except-interface = [ "lo" ];
      interface = [ "enp1s0" "enp1s0d1" ];

      dhcp-range = [ "10.0.0.3,10.0.0.200,12h" ];
      dhcp-option = [
        # Don't send default route
        "3"
        # Don't send DNS server
        "6"
        # MTU
        "26,9000"
      ];
    };
  };
}
