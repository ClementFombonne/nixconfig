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

  programs.vim = {
    enable = true; 
    extraConfig = ''
      set number          " Show line numbers
      set relativenumber  " Show relative line numbers
      set tabstop=4       " Number of spaces tabs count for
      set shiftwidth=4    " Number of spaces to use for each step of (auto)indent
      set expandtab       " Use spaces instead of tabs
      syntax on           " Enable syntax highlighting
    '';
  };

  programs.zsh = {
    enable = true;  # Enable Zsh
    autosuggestion.enable = true;
    shellAliases = {
      ll = "ls -lha";
      ".." = "cd ..";
    };
    oh-my-zsh = {
      enable = true;  # Enable Oh My Zsh for additional features
      theme = "agnoster";  # Set the theme (you can choose others)
      plugins = [
        "git"
	"sudo"
	"copyfile"
      ];
    };
  };
}
