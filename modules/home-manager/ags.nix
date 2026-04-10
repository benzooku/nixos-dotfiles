# AGS — custom bar/widget system
# Replaces hyprpanel
# Uses AGS v2 home-manager module
{ inputs, config, lib, pkgs, ags, astal, ... }:

{
  imports = [ ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
    configDir = ./ags;
    extraPackages = with pkgs; [
      astal.packages.${pkgs.stdenv.hostPlatform.system}.battery
      astal.packages.${pkgs.stdenv.hostPlatform.system}.mpris
      astal.packages.${pkgs.stdenv.hostPlatform.system}.network
      astal.packages.${pkgs.stdenv.hostPlatform.system}.tray
      astal.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
    ];
  };
}
