{ pkgs, lib, config, ... }:
{
  options = {
    modules.ghostty.enable = 
      lib.mkEnableOption "enables ghostty";
  };
  config = lib.mkIf config.modules.ghostty.enable {
    environment.systemPackages = with pkgs; [ 
      ghostty 
    ];
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };
}
