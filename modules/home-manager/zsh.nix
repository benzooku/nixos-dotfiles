{config, lib, pkgs, ...}:
{
   programs.zsh = {
        enable = true;
        enableCompletion = true;

        shellAliases = {
            update-nixos = "sudo nixos-rebuild switch --flake ~/nixos#nixos";
        };
        history.size = 1000; 

        plugins = [
            {
                name = "powerlevel10k-config";
                src = ./p10k-config;
                file = "p10k.zsh";
            } 
            {
                name = "zinit";
                src = pkgs.zinit;
                file = "share/zinit/zinit.zsh";
            } 
        ];

        initContent = lib.mkOrder 1500 ''
            zi light romkatv/powerlevel10k
            zinit for \
            light-mode \
            zsh-users/zsh-autosuggestions \
            light-mode \
            zdharma-continuum/fast-syntax-highlighting \
            light-mode \
            zdharma-continuum/history-search-multi-word \
            '';

    };
}

