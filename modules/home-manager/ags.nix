# AGS — custom bar/widget system
# Replaces hyprpanel
{ config, lib, pkgs, ... }:

{

  # AGS config directory
  home.file.ags = {
    source = ./ags;
    target = ".config/ags";
  };
}
