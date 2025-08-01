{ config, lib, pkgs, ... }:
{
  options.bundles.hyprland.enable = lib.mkEnableOption "Enable Hyprland bundle";
  options.bundles.terminal.enable = lib.mkEnableOption "Enable Terminal bundle";

  config = {
    environment.systemPackages = with pkgs; [
      vim git zsh tree curl
    ];
  };
}
