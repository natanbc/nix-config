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
      enp7s0 = {
        allowedUDPPorts = [ 67 ];
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
          address = "10.0.1.1";
          prefixLength = 24;
        }];
        mtu = 9000;
      };

      enp7s0 = {
        ipv4.addresses = [{
          address = "192.168.128.1";
          prefixLength = 24;
        }];
      };
    };
  };

  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = false;
    settings = {
      bind-interfaces = true;
      except-interface = [ "lo" ];
      interface = [ "enp1s0" "enp1s0d1" "enp7s0" ];

      dhcp-range = [
        "enp1s0,10.0.0.10,10.0.0.200,12h"
        "enp1s0d1,10.0.1.10,10.0.1.200,12h"
        "enp7s0,192.168.128.10,192.168.128.200,12h"
      ];
      dhcp-option = [
        # Don't send default route
        "3"
        # Don't send DNS server
        "6"
        # MTU
        "enp1s0,26,9000"
        "enp1s0d1,26,9000"
      ];
    };
  };
}
