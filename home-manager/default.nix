{ config, lib, pkgs, ... }:
{
  programs.git = {
      enable = true;
      userName = "clement fombonne";
      userEmail = "clement.fombonne@proton.me";
      coreEditor = "vim";
      color.ui = "auto";
      init.defaultBranch = "main";
}
