{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "9.9.9.9"
 "149.112.112.112"
 "2620:fe::fe"
 "2620:fe::9"
 ];
    defaultGateway = "208.87.134.1";
    defaultGateway6 = {
      address = "2602:ff16:3::1";
      interface = "enp3s0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce true;
    interfaces = {
      enp3s0 = {
        ipv4.addresses = [
          { address="208.87.134.154"; prefixLength=24; }
        ];
        ipv6.addresses = [
          { address="2602:ff16:3:11c6::1"; prefixLength=48; }
{ address="fe80::5054:60ff:fe7c:f584"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "208.87.134.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = "2602:ff16:3::1"; prefixLength = 128; } ];
      };
      
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="52:54:60:7c:f5:84", NAME="enp3s0"
    
  '';
}
