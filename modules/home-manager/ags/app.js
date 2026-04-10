// AGS Config — Azurra Theme
// Replaces hyprpanel with a custom AGS-based bar and widgets
import Config from "resource:///com/github/Aylur/ags/config.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Utils from "resource:///com/github/Aylur/ags/utils.js";
import App from "resource:///com/github/Aylur/ags/app.js";

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

// ── Bar Widget ───────────────────────────────────────────────────
const TopBar = () => {
    const left = Widget.Box({
        children: [
            Widget.Button({
                label: " 󰣇",
                on_clicked: () => App.toggleWindow("ags-launcher"),
            }),
            Widget.Box({
                class_name: "divider",
            }),
            Widget.Box({
                hexpand: true,
                children: [workspaces()] ,
            }),
        ],
    });

    return Widget.Window({
        name: "topbar",
        exclusivity: "normal",
        anchor: ["top", "left", "right"],
        child: Widget.CenterBox({
            start_widget: left,
            center_widget: windowTitle(),
            end_widget: rightTray(),
        }),
    });
};

// ── Workspaces ───────────────────────────────────────────────────
const workspaces = () => {
    const wsBox = Widget.Box({});

    const update = (n) => {
        wsBox.children = Array.from({ length: 10 }, (_, i) => {
            const ws = i + 1;
            return Widget.Button({
                label: `${ws}`,
                on_clicked: () => Utils.execAsync(`hyprctl dispatch workspace ${ws}`),
            });
        });
    };

    // Poll for workspace changes
    const timer = Utils.timeout(1000, () => {
        Utils.execAsync("hyprctl workspaces -j")
            .then((out) => JSON.parse(out))
            .then((wss) => {
                wsBox.children.forEach((btn, i) => {
                    btn.class_name = wss.some((w) => w.id === i + 1) ? "ws-active" : "ws-inactive";
                });
            })
            .catch(() => {});
        return true;
    });

    return wsBox;
};

// ── Window Title ─────────────────────────────────────────────────
const windowTitle = () => {
    let title = "";
    const label = Widget.Label({ label: "" });

    const timer = Utils.timeout(500, () => {
        Utils.execAsync("hyprctl activewindow -j")
            .then((out) => JSON.parse(out))
            .then((win) => {
                const newTitle = win?.title || "";
                if (newTitle !== title) {
                    title = newTitle;
                    label.label = title ? `  ${title}  ` : "";
                }
            })
            .catch(() => {
                label.label = "";
            });
        return true;
    });

    return label;
};

// ── Right Tray ───────────────────────────────────────────────────
const rightTray = () => {
    return Widget.Box({
        halign: "end",
        children: [
            // Media widget placeholder
            Widget.Box({
                children: [mediaWidget()],
            }),
            // Systray
            Widget.Systray({}),
            // Clock
            Widget.Button({
                label: "  " + new Date().toLocaleTimeString("de-DE", { hour: "2-digit", minute: "2-digit" }) + "  ",
            }),
        ],
    });
};

// ── Media Widget ────────────────────────────────────────────────
const mediaWidget = () => {
    const label = Widget.Label({ label: "  󱐾  " });

    const timer = Utils.timeout(1000, () => {
        Utils.execAsync("playerctl metadata --format '{{title}}' 2>/dev/null")
            .then((t) => {
                if (t.trim()) {
                    label.label = `  󱐾 ${t.trim().substring(0, 30)}  `;
                } else {
                    label.label = "  󱐾  ";
                }
            })
            .catch(() => {
                label.label = "  󱐾  ";
            });
        return true;
    });

    return label;
};

// ── Launcher / App Menu ──────────────────────────────────────────
const Launcher = () => {
    return Widget.Window({
        name: "ags-launcher",
        visible: false,
        anchor: ["center"],
        child: Widget.Box({
            children: [
                Widget.Entry({
                    placeholder: "Search apps...",
                    on_accept: (entry) => {
                        Utils.execAsync(`wofi --show drun ${entry.text}`);
                        App.closeWindow("ags-launcher");
                    },
                }),
            ],
        }),
    });
};

// ── Register Widgets ─────────────────────────────────────────────
App.config({
    windows: [TopBar(), Launcher()],
    style: `
        * {
            all: unset;
            font-family: "JetBrains Mono", monospace;
            color: ${C.text};
        }
        window {
            background-color: ${C.surface};
            border-bottom: 1px solid ${C.border};
        }
        .divider {
            width: 1px;
            background-color: ${C.border};
            margin: 0 4px;
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
        .systray {
            spacing: 8px;
        }
    `,
});

export default {};
