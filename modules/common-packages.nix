{ config, lib, pkgs, ... }:

{
  programs = {
    vim = {
      enable = true;
      defaultEditor = true;
    };
    tmux.enable = true;
    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
  ];
}
