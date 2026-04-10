// AGS Config — Azurra Theme (v2 API)
// Replaces hyprpanel

import { App, Widget, Utils } from "resource:///com/github/Aylur/ags/src/index.js";
import { Service } from "resource:///com/github/Aylur/ags/src/service.js";

// ── Azurra Color Palette ─────────────────────────────────────────
const C = {
    bg: "#0d1117",
    surface: "#161b22",
    border: "#21262d",
    text: "#e6edf3",
    textDim: "#8b949e",
    accent: "#58a6ff",
    accentSubtle: "#1f6feb",
    danger: "#f85149",
    success: "#3fb950",
};

// ── Hyprland Service ─────────────────────────────────────────────
const hypr = Service.get("hyprland");

// ── Workspaces ───────────────────────────────────────────────────
const Workspaces = () => Widget.Box({
    children: Array.from({ length: 10 }, (_, i) => {
        const ws = i + 1;
        return Widget.Button({
            label: `${ws}`,
            onClicked: () => Utils.exec(`hyprctl dispatch workspace ${ws}`),
            connections: [[hypr, (box) => {
                const workspaces = hypr.workspaces;
                const active = workspaces.some(w => w.id === ws);
                box.children[i].className = active ? "ws-active" : "ws-inactive";
            }]],
        });
    }),
});

// ── Window Title ─────────────────────────────────────────────────
const WindowTitle = () => Widget.Label({
    connections: [[hypr, (label) => {
        const win = hypr.active.window;
        label.label = win ? `  ${win.title}  ` : "";
    }]],
});

// ── Media Widget ────────────────────────────────────────────────
const Media = () => Widget.Label({
    connections: [[Service, (label) => {
        // Use mpris service if available
        try {
            const mpris = Service.get("mpris");
            if (mpris && mpris.players) {
                const player = Object.values(mpris.players)[0];
                label.label = player?.title ? `  󱐾 ${player.title.substring(0, 30)}  ` : "  󱐾  ";
            } else {
                label.label = "  󱐾  ";
            }
        } catch {
            label.label = "  󱐾  ";
        }
    }]],
});

// ── Clock ───────────────────────────────────────────────────────
const Clock = () => Widget.Label({
    connections: [[Utils, (label) => {
        label.label = "  " + new Date().toLocaleTimeString("de-DE", { hour: "2-digit", minute: "2-digit" }) + "  ";
    }]],
});

// ── Top Bar ─────────────────────────────────────────────────────
const TopBar = Widget.Window({
    name: "topbar",
    className: "topbar",
    exclusivity: "normal",
    anchor: ["top", "left", "right"],
    child: Widget.CenterBox({
        start_widget: Widget.Box({
            children: [
                Widget.Button({
                    label: "  󰣇  ",
                    onClicked: () => Utils.exec("wofi --show drun"),
                }),
                Widget.Box({ hexpand: true, children: [Workspaces()] }),
            ],
        }),
        center_widget: WindowTitle(),
        end_widget: Widget.Box({
            halign: "end",
            children: [Media(), Widget.Systray({}), Clock()],
        }),
    }),
});

// ── App Config ───────────────────────────────────────────────────
App.config({
    windows: [TopBar()],
    style: `
        * {
            all: unset;
            font-family: "JetBrains Mono", monospace;
            font-size: 12px;
            color: ${C.text};
        }
        window {
            background-color: ${C.surface};
            border-bottom: 1px solid ${C.border};
        }
        .topbar {
            background-color: ${C.surface};
        }
        button {
            background-color: transparent;
            border-radius: 6px;
            padding: 4px 8px;
            color: ${C.textDim};
        }
        button:hover {
            background-color: ${C.border};
            color: ${C.text};
        }
        .ws-active {
            background-color: ${C.accentSubtle};
            color: ${C.accent};
        }
        .ws-inactive {
            background-color: transparent;
            color: ${C.textDim};
        }
        .systray > * {
            margin: 0 4px;
        }
    `,
});

App.start();
