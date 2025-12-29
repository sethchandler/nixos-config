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
  };

  # Manually managing the bindings file because the module doesn't support it
  xdg.configFile."micro/bindings.json".text = ''
    {
        "Alt-/": "lua:comment.comment",
        "CtrlUnderscore": "lua:comment.comment"
    }
  '';
}

