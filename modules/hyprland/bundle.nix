{ pkgs, lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./wofi.nix
    ./waybar.nix
  ];

  modules.hyprland.enable =
    lib.mkDefault true;
  modules.wofi.enable =
    lib.mkDefault true;
  modules.waybar.enable =
    lib.mkDefault true;
}
