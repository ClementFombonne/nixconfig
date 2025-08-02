{ pkgs, lib, ... }:
{
  imports = [
    ./nautilus.nix
  ];
  modules.nautilus.enable =
    lib.mkDefault true;
}
