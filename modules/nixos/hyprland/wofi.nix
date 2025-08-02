{ pkgs, lib, config, ... }:
{
  options = {
    modules.wofi.enable = 
      lib.mkEnableOption "enables wofi";
  };
  config = lib.mkIf config.modules.wofi.enable {
    environment.systemPackages = with pkgs; [
      wofi
    ];
  };
}
