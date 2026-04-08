{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;

    settings = {
      # Display
      mode = "drun";
      show-icons = true;
      icon-theme = "Adwaita";
      icon-size = 24;

      # Window
      location = "center";
      width = 650;
      height = 420;
      margin = "15%";
      normal-window = false;

      # Behavior
      allow-markup = true;
      no-actions = true;
      insensitive = true;
      parse-search = true;
      gtk-dark = true;

      # Columns
      columns = 1;

      # Matching
      matching = "fuzzy";
      fuzzy = true;
    };

    style = ./wofi/style.css;
  };
}
