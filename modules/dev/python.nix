{ pkgs, lib, config, ... }:
{
  options = {
    modules.ghostty.enable = 
      lib.mkEnableOption "enables python-uv";
  };
  config = lib.mkIf config.modules.python.enable {
    environment.systemPackages = with pkgs; [ 
      uv
    ];
  };
}
