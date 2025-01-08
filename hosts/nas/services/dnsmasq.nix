{
  networking = {
    firewall.interfaces = {
      enp1s0 = {
        allowedTCPPorts = [ 139 445 5201 ];
        allowedUDPPorts = [ 67 547 5201 ];
      };
      enp1s0d1 = {
        allowedTCPPorts = [ 139 445 5201 ];
        allowedUDPPorts = [ 67 547 5201 ];
      };
      enp7s0 = {
        allowedUDPPorts = [ 67 547 ];
      };
    };
    interfaces = {
      enp1s0 = {
        ipv4.addresses = [{
          address = "10.0.0.1";
          prefixLength = 24;
        }];
        ipv6.addresses = [{
          address = "fd4d:b5dc:3f9b:0001::1";
          prefixLength = 64;
        }];
        mtu = 9000;
      };
      enp1s0d1 = {
        ipv4.addresses = [{
          address = "10.0.1.1";
          prefixLength = 24;
        }];
        ipv6.addresses = [{
          address = "fd4d:b5dc:3f9b:0002::1";
          prefixLength = 64;
        }];
        mtu = 9000;
      };

      enp7s0 = {
        ipv4.addresses = [{
          address = "192.168.128.1";
          prefixLength = 24;
        }];
        ipv6.addresses = [{
          address = "fd4d:b5dc:3f9b:0003::1";
          prefixLength = 64;
        }];
      };
    };
  };

  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = false;
    settings = {
      bind-interfaces = true;
      enable-ra = true;
      except-interface = [ "lo" ];
      interface = [ "enp1s0" "enp1s0d1" "enp7s0" ];

      dhcp-range = [
        "enp1s0,10.0.0.10,10.0.0.200,12h"
        "enp1s0d1,10.0.1.10,10.0.1.200,12h"
        "enp7s0,192.168.128.10,192.168.128.200,12h"

        "enp1s0,::1:0,::1:ff,constructor:enp1s0,12h"
        "enp1s0d1,::1:0,::1:ff,constructor:enp1s0d1,12h"
        "enp7s0,::1:0,::1:ff,constructor:enp7s0,12h"
      ];
      dhcp-option = [
        # Don't send default route
        "option:router"
        # Don't send DNS server
        "option:dns-server"
        "option6:dns-server"

        "enp1s0,option:mtu,9000"
        "enp1s0d1,option:mtu,9000"
      ];
      ra-param = [
        "enp1s0,mtu:9000,86400,0"
        "enp1s0d1,mtu:9000,86400,0"
        "enp7s0,86400,0"
      ];
    };
  };
}
