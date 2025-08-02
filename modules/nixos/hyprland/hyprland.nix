{ pkgs, lib, config, ... }:
{
  options = {
    modules.hyprland.enable = 
      lib.mkEnableOption "enables hyprland";
  };
  config = lib.mkIf config.modules.hyprland.enable {
    # hyprland setup
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    services.displayManager.sddm.enable = true;
    services.xserver.enable = true;
    # hyprutils setyp
    environment.systemPackages = with pkgs; [
      hypridle
      hyprlock
      hyprpaper
    ];
  };
}
