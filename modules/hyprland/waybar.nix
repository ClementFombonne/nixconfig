{ pkgs, lib, config, ... }:
{
  options = {
    modules.waybar.enable = 
      lib.mkEnableOption "enables waybar";
  };
  config = lib.mkIf config.modules.waybar.enable {
    programs.waybar.enable = true;
  };
}
