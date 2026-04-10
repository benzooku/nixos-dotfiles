# Desktop Overhaul — Planning

**Branch:** `desktop-overhaul`
**Status:** In Progress (4/4 commits pushed)
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

- [x] Hyprland config (colors, borders, shadows, blur, animations)
  - Active border: `#58a6ff`, inactive: `#21262d`
  - Shadow color: `#0d111755`
- [x] **hyprpanel → AGS** (remove hyprpanel entirely, build custom bar/widgets with AGS)
  - AGS module created: `modules/home-manager/ags.nix`
  - Bar config: `modules/home-manager/ags/config.js`
  - Both removed from imports and system packages
- [x] **Notification daemon: Mako** (replaces hyprpanel notifications)
  - Module: `modules/home-manager/mako.nix`
  - Azurra colors, overlay layer, 5 max visible, centered
- [x] **Starship prompt** (replaces powerlevel10k)
  - Module: `modules/home-manager/starship.nix`
  - Azurra-colored prompt: directory in `#58a6ff`, git in `#8b949e`, success `#3fb950`, error `#f85149`
  - Note: zsh.nix still has p10k plugin — user should migrate zsh config to remove p10k
- [x] **GTK theme** — switched from Orchis-Purple-Dark to **Dracula** (close match to Azurra navy base)
- [x] **Qt theme** — enabled `platformTheme.name = "gtk"` for GTK-Qt integration
- [x] **wofi** (Azurra-styled CSS)
  - `modules/home-manager/wofi/style.css` — all colors updated to Azurra palette
- [x] **kitty** (Azurra theme)
  - `modules/home-manager/aura-theme.conf` — re-themed to Azurra colors
- [x] **waybar** (Azurra-styled)
  - `modules/home-manager/waybar/style.css` — full Azurra color update
- [x] **GRUB theme** — switched from `tela` to `stylish` (dark, clean aesthetic)
- [ ] hyprlock (keep as-is, minor color updates already applied)
- [ ] hyprpaper (wallpaper stays — no change needed)
- [ ] Cursor theme (keep Bibata as-is)

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
- **2026-04-10:** Added GRUB theme `stylish` for dark, clean aesthetic.
- **2026-04-10:** Changed GTK from Orchis-Purple-Dark to Dracula (good Azurra-adjacent dark theme).
- **2026-04-10:** Enabled Qt GTK platform theme for consistent cross-Qt/GTK look.

---

## Commits (desktop-overhaul)

| # | Commit | Description |
|---|--------|-------------|
| 1 | `930b72a` | Apply Azurra colors to wofi, kitty, hyprland borders/shadows |
| 2 | `a9cdee1` | Add starship, mako, ags modules; remove hyprpanel |
| 3 | `395ccba` | Switch to stylish GRUB theme, Dracula GTK, enable Qt GTK platform |
| 4 | `403f90e` | Waybar Azurra styling |

---

## Known Issues / TODO

1. **zsh.nix still references p10k** — p10k plugin is still in zsh.nix, should be removed and replaced with Starship init once user confirms
2. **AGS config.js is skeleton** — the AGS config is a basic starter; full widget system (workspaces polling, media, clock, systray) needs testing on actual NixOS system with AGS installed
3. **No `nixos-rebuild dry-run` possible** — Nix is not in PATH on this build machine; dry-run should be run on the actual NixOS machine before deploying
4. **SDDM theme** — `catppuccin-mocha-mauve` still in use; consider switching to a dark theme that matches Azurra (e.g. `sddm-theme-breeze` or custom)
5. **hyprlock** — only minor color updates applied; could get a fuller Azurra treatment
