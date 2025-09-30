{ config, ... }:
{

  imports =
    [
    ./../../modules/home-manager/hyprland.nix
      ./../../modules/home-manager/btop.nix
      ./../../modules/home-manager/zsh.nix
      ./../../modules/home-manager/kitty.nix
      ./../../modules/home-manager/lazygit.nix
      ./../../modules/home-manager/hyprpanel.nix
      ./../../modules/home-manager/device.nix
    ];
# Home Manager needs a bit of information about you and the paths it should
# manage.
  home.username = "ben";
  home.homeDirectory = "/home/ben";

# This value determines the Home Manager release that your configuration is
# compatible with. This helps avoid breakage when a new Home Manager release
# introduces backwards incompatible changes.
#
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

# The home.packages option allows you to install Nix packages into your
# environment.
    home.packages = [
    ];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
  home.file = {
# # Building this configuration will create a copy of 'dotfiles/screenrc' in
# # the Nix store. Activating the configuration will then make '~/.screenrc' a
# # symlink to the Nix store copy.
# ".screenrc".source = dotfiles/screenrc;
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

# Home Manager can also manage your environment variables through
# 'home.sessionVariables'. These will be explicitly sourced when using a
# shell provided by Home Manager. If you don't want to manage your shell
# through Home Manager then you have to manually source 'hm-session-vars.sh'
# located at either
#
#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  /etc/profiles/per-user/ben/etc/profile.d/hm-session-vars.sh
#
  home.sessionVariables = {
# EDITOR = "emacs";
  };

# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
