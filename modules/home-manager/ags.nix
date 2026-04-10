# AGS — custom bar/widget system
# Replaces hyprpanel
{ config, lib, pkgs, ... }:

{
  # Install AGS
  home.packages = [ pkgs.ags ];

  # AGS config directory
  home.file.ags = {
    source = ./ags;
    target = ".config/ags";
  };
}
