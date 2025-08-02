{ pkgs, lib, config, ... }:
{
  options = {
    modules.neovim.enable = 
      lib.mkEnableOption "enables neovim";
  };
  config = lib.mkIf config.modules.neovim.enable {
    programs.neovim.enable = true;
  };
}
