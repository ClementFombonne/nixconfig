{ config, lib, pkgs, ... }:
{
  options.bundles.hyprland.enable = lib.mkEnableOption "Enable Hyprland bundle";
  options.bundles.app.enable = lib.mkEnableOption "Enable application bundle";
  options.bundles.dev.enable = lib.mkEnableOption "Enable development bundle";
  options.bundles.terminal.enable = lib.mkEnableOption "Enable Terminal bundle";

  config = {
    environment.systemPackages = with pkgs; [
      vim git tree curl
    ];
    programs.zsh.enable = true;
  };
}
