{ config, lib, pkgs, ... }:
let
  cfg_hypr = config.bundle.hyprland;
in {
  options.bundle.hyprland.enable = lib.mkEnableOption "Enable Hyprland bundle";

  config = {
    imports = lib.mkIf cfg_hypr.enable [
      ./hyprland/bundle.nix
    ];

    environment.systemPackages = with pkgs; [
      vim git zsh tree curl
    ];
  };
}
