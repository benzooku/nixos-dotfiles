{ config, pkgs, ...}:
{
    environment.systemPackages = [
        # C
        pkgs.gcc

        # Nix
        pkgs.nixd

        # General
        pkgs.inotify-tools
        pkgs.staruml
        pkgs.figma-linux
        pkgs.unzip
        pkgs.nodejs_24
        pkgs.watchman

            
    ];

    # VirtualBox
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
    users.extraGroups.vboxusers.members = [ "ben" ];

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
