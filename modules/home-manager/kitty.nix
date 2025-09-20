{config, pkgs, ...}:
{
    programs.kitty = {
        enable = true;
        enableGitIntegration = true;
        font.name = "JetBrains Mono";
        shellIntegration.enableZshIntegration = true;
        settings = {
            include = "~/nixos/modules/home-manager/aura-theme.conf";
        };
    };
}
