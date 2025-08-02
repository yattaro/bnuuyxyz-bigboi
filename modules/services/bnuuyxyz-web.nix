{ config, pkgs, ...}:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
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
}
