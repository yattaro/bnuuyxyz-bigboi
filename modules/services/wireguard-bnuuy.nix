{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];
  networking = {
    nat.enable = true;
    nat.externalInterface = "enp3s0";
    nat.internalInterfaces = [ "wg0" "wg1" ];
    firewall.allowedUDPPorts = [ 51820 51821 ];
    wireguard = {
      enable = true;
      interfaces.wg0 = {
        privateKeyFile = "/private/bnuuy_key";
        generatePrivateKeyFile = true;
        ips = [ "172.24.10.3/24" "fdb1:26d8:15ce::3/64" ];
        listenPort = 51820;
        peers = [
          {
            name = "memeserver2";
            publicKey = "XSiDYtQvfEBZ+ThNxsB/3EtiAt34EUAGQ+2SzoXGGG0=";
            allowedIPs = [ "172.24.10.2/32" "fdb1:26d8:15ce::2/128" ];
          }
        ];
      };
      interfaces.wg1 = {
        privateKeyFile = "/private/bnuuy_key";
        ips = [ "172.24.11.5/24" ];
        listenPort = 51821;
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -A FORWARD -i %i -j ACCEPT; ${pkgs.iptables}/bin/iptables -A FORWARD -o %i -j ACCEPT; ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -o enp3s0 -j MASQUERADE
        '';
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -D FORWARD -i %i -j ACCEPT; ${pkgs.iptables}/bin/iptables -D FORWARD -o %i -j ACCEPT; ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -o enp3s0 -j MASQUERADE
        '';
        peers = [
          {
            name = "teleporter";
            publicKey = "mtm4iFz0Yem/RvKZTJXnPOmArNIhwpAgiTyCT4+2eEw=";
            allowedIPs = [ "172.24.11.2/32" ];
          }
          {
            name = "Merveille";
            publicKey = "TF1kjLKFL0asoo/bdCpLuEBztSudxGk64UeqTgs9mG0=";
            allowedIPs = [ "172.24.11.3/32" ];
          }
          {
            name = "Marzipan";
            publicKey = "AHlU6Jj9f+9IDNRsftTedP0O39KVFeJgz12KgvWgqWk=";
            allowedIPs = [ "172.24.11.4/32" ];
          }
        ];
      };
    };
  };
}
