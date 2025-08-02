{ pkgs, lib, config, ... }:
{
  options = {
    modules.nautilus.enable = 
      lib.mkEnableOption "enables nautilus";
  };
  config = lib.mkIf config.modules.nautilus.enable {
    environment.systemPackages = with pkgs; [ 
      nautilus 
    ];
  };
}
