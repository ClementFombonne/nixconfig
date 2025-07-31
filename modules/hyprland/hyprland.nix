{ pkgs, lib, config, ... }:
{
  options = {
    modules.hyprland.enable = 
      lib.mkEnableOption "enables hyprland";
  };
  config = lib.mkIf config.modules.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    services.displayManager.sddm.enable = true;
    services.xserver.enable = true;
  };
}
