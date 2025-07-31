{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    git
    zsh
    tree
    curl
  ];
}
