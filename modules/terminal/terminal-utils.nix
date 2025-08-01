{ pkgs, lib, config, ... }:
{
  options = {
    modules.terminal-utils.enable = 
      lib.mkEnableOption "enables terminal utils";
  };
  config = lib.mkIf config.modules.terminal-utils.enable {
    environment.systemPackages = with pkgs; [ 
      btop 
      tmux
      fastfetc
    ];
  };
}
