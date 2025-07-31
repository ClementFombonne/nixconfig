{ config, lib, pkgs, ... }:
{
  options.bundles.hyprland.enable = lib.mkEnableOption "Enable Hyprland bundle";

  config = {
    environment.systemPackages = with pkgs; [
      vim git zsh tree curl
    ];
  };
}
