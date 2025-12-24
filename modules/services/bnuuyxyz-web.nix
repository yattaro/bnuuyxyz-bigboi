{ config, pkgs, ...}:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
    8448 # matrix federation
  ];

  # piwigo currently lives in docker until I can figure out how to deploy it un-fucked on nix
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
  services.caddy = {
    enable = true;
    configFile = ./Caddyfile;
  };
  services.matrix-conduit = {
    enable = true;
    settings.global = {
      address = "127.0.0.1";
      server_name = "bnuuy.xyz";
      well_known = {
        server = "bnuuy.xyz:443";
        client = "https://bnuuy.xyz";
      };
    };
  };

  # handle backups
  systemd.timers."web-backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "web-backup.service";
    };
  };
  systemd.services."web-backup" = {
    path = [ pkgs.openssh pkgs.rsync ];
    script = ''
      set -eu
      rsync -azXPv /var/lib/piwigo/ bnuuyxyz-backup-worker@172.24.10.2:~/bnuuyxyz-backup/piwigo/
      rsync -azXPv /var/www/ bnuuyxyz-backup-worker@172.24.10.2:~/bnuuyxyz-backup/www/
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
