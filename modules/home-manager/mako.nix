# Azurra-themed Mako notification daemon config
{pkgs, ...}:
{
  services.mako = {
    enable = true;
    settings = {
      sort = true;
      layer = "overlay";
      max-visible = 5;
      default-timeout = 5000;
      align = "center";
      margin = "18px";
      padding = "12px";
      border-size = 2;
      border-radius = 12;
      border-color = "#58a6ff";
      background-color = "#161b22";
      text-color = "#e6edf3";
      progress-color = "#1f6feb";
      icons = true;
      max-icon-size = 32;
      text-size = "14px";
      font-family = "JetBrains Mono";
    };
  };
}
