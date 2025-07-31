let
  ssh-pubkeys = import ../../modules/secrets/ssh-pubkeys.nix;
in
{ ... }:
{
  users.users.yattaro = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = ssh-pubkeys.yattaro;
  };
}
