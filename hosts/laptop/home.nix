{ config, pkgs, ... }:

{
  imports =
        [ 
            ./../../modules/home-manager/hyprland.nix
            ./../../modules/home-manager/btop.nix
            ./../../modules/home-manager/zsh.nix
            ./../../modules/home-manager/kitty.nix
            ./../../modules/home-manager/lazygit.nix
            ./../../modules/home-manager/hyprpanel-laptop.nix
            ./../../modules/home-manager/device.nix
        ];


  home.username = "ben";
  home.homeDirectory = "/home/ben";


  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ../../modules/home-manager/nvim;
    ".config/rofi".source = config.lib.file.mkOutOfStoreSymlink ../../modules/home-manager/rofi;
    ".config/rofi.ben".source = config.lib.file.mkOutOfStoreSymlink ../../modules/home-manager/rofi.ben;
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink ../../modules/home-manager/waybar;
# # You can also set the file content immediately.
# ".gradle/gradle.properties".text = ''
#   org.gradle.console=verbose
#   org.gradle.daemon.idletimeout=3600000
# '';
  };
  programs.home-manager.enable = true;

  home.stateVersion = "25.05"; # Please read the comment before changing.
}
