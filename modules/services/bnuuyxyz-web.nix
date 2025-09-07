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
}
