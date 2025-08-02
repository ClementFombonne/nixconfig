{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.modules.hyprland.enable {
    services.hyprpaper.wallpaper = {
      path = "../../assets/013.png";
      mode = "fit";
    };
  };
}
