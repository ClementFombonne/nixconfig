{ pkgs, lib, ... }:
{
  imports = [
    ./python.nix
  ];

  modules.python.enable =
    lib.mkDefault true;
}
