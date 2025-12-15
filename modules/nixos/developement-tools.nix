{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
# C
    gcc

# Nix
      nixd


# Go
    go

# General
      inotify-tools
      staruml
      figma-linux
      unzip
      nodejs_24
      watchman
      k6

# TUIs and shell tools
      lazygit
      fzf
      ripgrep
      fd
      ast-grep
      nettools
      gemini-cli
      ];

# KVM
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["ben"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
# virsh net-start default
# to start virt network

# waydroid
  virtualisation.waydroid.enable = true;
# Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  users.users.ben.extraGroups = [ "docker" ];

# Postgres
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "postgres" ];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
#type database DBuser origin-address auth-method
      local all       all     trust
# ipv4
      host  all      all     127.0.0.1/32   trust
# ipv6
      host all       all     ::1/128        trust
      '';
  };
# non-nix Executables
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
# Add any missing dynamic libraries for unpackaged programs
# here, NOT in environment.systemPackages
  ];
}
