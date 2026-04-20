{config, lib, pkgs, ...}:
{
   programs.zsh = {
        enable = true;
        enableCompletion = true;

        shellAliases = {
            update-nixos = "sudo nixos-rebuild switch --flake ~/repos/nixos-dotfiles";
        };
        history.size = 1000;

        initContent = lib.mkOrder 1500 ''
            zinit for \
            light-mode \
            zsh-users/zsh-autosuggestions \
            light-mode \
            zdharma-continuum/fast-syntax-highlighting \
            light-mode \
            zdharma-continuum/history-search-multi-word \
            '';

    };

   programs.starship = {
        enable = true;
        enableZshIntegration = true;
    };
}

