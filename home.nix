{ pkgs, ... }:

{
  home.username = "seth";
  home.homeDirectory = "/home/seth";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      shell = "fish";
      background_opacity = "0.85";
    };
  };

  programs.micro = {
    enable = true;
    settings = {
      "colorscheme" = "simple";
    };
    keybindings = {
      "Alt-/" = "lua:comment.comment";
      "CtrlUnderscore" = "lua:comment.comment";
    };
  };
}
