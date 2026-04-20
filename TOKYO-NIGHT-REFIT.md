# Tokyo Night — Full Retheme Plan

**Status:** Pending
**Date:** 2026-04-20

---

## Color Palette (Tokyo Night)

| Role | Hex | Usage |
|------|-----|-------|
| Background | `#1a1b26` | Root bg, panels |
| Surface | `#24283b` | Cards, elevated surfaces |
| Border | `#414868` | Borders, separators |
| Text | `#c0caf5` | Main text |
| Text muted | `#565f89` | Labels, hints |
| Blue | `#7aa2f7` | Active states, highlights |
| Purple | `#bb9af7` | Accent |
| Cyan | `#7dcfff` | Secondary accent |

---

## Current State

- **Hyprpanel** — active bar, already has some Tokyo Night colors
- **Waybar** — dead symlink in `home.file`, config exists but not imported as module
- **Hyprland** — borders use Aura colors (`#4077b2ed`, `#595959aa`)
- **Kitty** — uses `~/nixos/modules/home-manager/aura-theme.conf` (broken path, but Ben says keep as-is)
- **hyprlock** — colors use Aura palette (`rgba(100, 114, 125, 0.4)`)
- **nvim** — uses Dracula theme (not Tokyo Night)

---

## Files to Update

### 1. `modules/home-manager/hyprpanel.nix`
Already uses `#1a1b26` / `#7aa2f7` / `#bb9af7` — verify full Tokyo Night consistency, no Aura colors remaining.

### 2. `modules/home-manager/hyprland.nix`
- `col.active_border` → `rgba(7aa2f7ff) rgba(7aa2f7ff) 45deg`
- `col.inactive_border` → `rgba(414868ff)`
- `shadow.color` → `rgba(1a1b2655)`
- Hyprlock palette: `inner_color` → `rgba(36, 40, 59, 0.4)`, `font_color` → `rgb(192, 202, 245)`

### 3. `modules/home-manager/hyprlock` (extraConfig in hyprland.nix)
- Remove hardcoded `path = ~/nixos/...` (Ben says paths are right as-is)
- Update colors to Tokyo Night palette

### 4. `modules/nixos/desktop-environment.nix` (SDDM theme)
- `catppuccin-mocha-mauve` → consider switching to `sddm-theme-tokyo-night` if available

### 5. `modules/home-manager/nvim/` (optional)
- Currently Dracula — could switch to Tokyo Night Neovim theme

---

## Do NOT Touch
- `~/nixos/` paths (Ben says they're correct as-is)
- Waybar config (not active)
- kitty `aura-theme.conf` path

---

## Execution Order

1. Hyprpanel — full Tokyo Night audit
2. Hyprland — borders, shadows, hyprlock palette
3. SDDM theme
4. nvim (optional)

---

## Commits

Will be tracked here after execution.