# Desktop Overhaul — Planning

**Branch:** `desktop-overhaul`
**Status:** Planning
**Last updated:** 2026-04-10

---

## Color Palette — Azurra

Deep navy base, bright sky blue accent. Bold contrast, very minimal.

| Role | Hex | Usage |
|------|-----|-------|
| Background (deep) | `#0d1117` | Root bg, panels, menus |
| Background (surface) | `#161b22` | Cards, elevated surfaces |
| Background (muted) | `#21262d` | Borders, separators |
| Text (primary) | `#e6edf3` | Main text |
| Text (secondary) | `#8b949e` | Labels, hints |
| Accent (sky blue) | `#58a6ff` | Highlights, active states, focus rings |
| Accent (subtle) | `#1f6feb` | Button bg, selection bg |
| Danger | `#f85149` | Errors, destructive actions |
| Success | `#3fb950` | Success states |

---

## Scope

- [ ] Hyprland config (colors, borders, shadows, blur, animations)
- [ ] **hyprpanel → AGS** (remove hyprpanel entirely, build custom bar/widgets with AGS)
  - Custom top bar with workspaces, window title, media widget, clock, systray, volume, network, CPU/RAM
  - AGS-based launcher/menu (custom, not wofi drun)
  - Lock screen via AGS or keep hyprlock?
- [ ] **Notification daemon: Mako** (replaces hyprpanel notifications)
  - Match Azurra colors
  - Configure urgency levels, timeouts, dismiss gestures
— [ ] hyprlock (keep or replace with AGS lock screen?)
- [ ] hyprpaper (wallpaper stays or new?)
- [ ] GTK theme (match Azurra)
- [ ] Qt theme (match Azurra)
- [ ] wofi (keep for app launching or replace with AGS launcher?)
- [ ] kitty (match Azurra)
- [ ] Cursor theme (keep Bibata or change?)
- [ ] Font choices (keep JetBrains Mono?)

---

## Constraints

- Keep current dual-monitor setup (HDMI-A-1 144Hz + HDMI-A-2 60Hz)
- Keep German keyboard layout + caps:escape
- Keep existing keybindings unless they conflict with new theming
- **Replace hyprpanel with AGS** — custom bar, no hyprpanel
- **Mako notification daemon** — replaces hyprpanel notification module
- No major workflow changes — purely visual overhaul (but AGS enables much more customization)

---

## Decision Log

- **2026-04-10:** Ben chose **Azurra** palette over Catppuccin. Dark with minimal accent colors.
