# AGS — custom bar/widget system
# Built from scratch 2026-04-10
{ inputs, config, lib, pkgs, ags, astal, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  imports = [ ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
    configDir = ./ags;
    extraPackages = with pkgs; [
      astal.packages.${system}.battery
      astal.packages.${system}.mpris
      astal.packages.${system}.network
      astal.packages.${system}.tray
      astal.packages.${system}.hyprland
      astal.packages.${system}.wireplumber  # for volume/audio
    ];
  };
}
