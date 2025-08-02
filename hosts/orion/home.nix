{ config, lib, pkgs, user, ... }:
let
  home-mod= builtins.toString ../../modules/home-manager;
in
{
  imports = [
    "${home-mod}/default.nix"
  ];
  # home config
  home.username = user;
  home.homeDirectory = "/home/${user}";  
  home.stateVersion = "25.05";
}
