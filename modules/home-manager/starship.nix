{ config, lib, pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.mkForce "$username$directory$git_branch$git_status$container$cmd_duration$line_break$status$character";
      add_newline = false;

      character = {
        success_symbol = "[➜](bold #58a6ff)";
        error_symbol = "[✗](bold #f85149)";
      };

      directory = {
        style = "bold #58a6ff";
        truncation = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        symbol = " ";
        style = "#8b949e";
        format = "[$symbol$branch]($style)";
      };


      git_status = {
        style = "#f85149";
        format = "[$all_status$ahead_behind]($style)";
        conflicts_status = "[✘ $conflicted]($style)";
      };

      cmd_duration = {
        style = "#8b949e";
        format = "[⬌ $duration]($style)";
        min_time = 500;
      };

      username = {
        format = "[$user]($style) ";
        style_root = "bold #f85149";
        style_user = "#e6edf3";
      };

      status = {
        style = "#3fb950";
        format = "[$symbol]($style) ";
        symbol_success = "[✓](bold #3fb950)";
        symbol_error = "[✗](bold #f85149)";
        not_executable_symbol = "[✗]()";
      };

      container = {
        format = "[$symbol $name]($style)";
        symbol = " ";
        style = "#8b949e";
      };

      line_break = {
        disabled = false;
      };

      jobs = {
        format = "[$symbol]($style)";
        symbol = " ";
        style = "#58a6ff";
        threshold = 1;
      };
    };
  };
}
