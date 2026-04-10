# AGS (Azurra-themed) — custom bar/widget system
# Replaces hyprpanel entirely
{ config, lib, pkgs, ... }:
let
  azurraBg = "#0d1117";
  azurraSurface = "#161b22";
  azurraBorder = "#21262d";
  azurraText = "#e6edf3";
  azurraTextDim = "#8b949e";
  azurraAccent = "#58a6ff";
  azurraAccentSubtle = "#1f6feb";
  azurraDanger = "#f85149";
  azurraSuccess = "#3fb950";
in
{
  programs.ags = {
    enable = true;

    # AGS config is JS/TypeScript, placed in ~/.config/ags/
    # The module generates the config directory
    configDir = lib.mkForce "/home/ben/.config/ags";

    # Azurra-themed bar widgets
    # This creates a custom bar with workspaces, window title, systray, clock, etc.
  };

  # Create AGS config files via home.file
  home.file."ags/config.js" = {
    source = ./ags/config.js;
  };
}
