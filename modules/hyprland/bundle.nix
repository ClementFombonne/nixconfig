{ pkgs, lib, ... }:
{
  imports = [
    ./hyprland.nix
  ];

  modules.hyprland.enable =
    lib.mkDefault true;
}
