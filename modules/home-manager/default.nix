{ config, lib, pkgs, ... }:
{
  programs.git = {
enable = true;
  userName = "clement fombonne";
  userEmail = "clement.fombonne@proton.me";
  extraConfig = {
    init.defaultBranch = "main";
    core.editor = "vim";
    push.autoSetupRemote = true; 
    };
  };
}
