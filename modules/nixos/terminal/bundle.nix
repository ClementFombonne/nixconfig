{ pkgs, lib, ... }:
{
  imports = [
    ./ghostty.nix
    ./neovim.nix
    ./terminal-utils.nix
  ];

  modules.ghostty.enable =
    lib.mkDefault true;
  modules.neovim.enable =
    lib.mkDefault true;
  modules.terminal-utils.enable =
    lib.mkDefault true;
}
