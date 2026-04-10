// AGS Config — Azurra Theme (v1 API)
// Replaces hyprpanel

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

// ── Helper: run command and return output ────────────────────────
const exec = (cmd) => Utils.exec(cmd);
const execAsync = (cmd) => Utils.execAsync(cmd);

// ── Workspaces ───────────────────────────────────────────────────
const Workspaces = () => {
    const box = Widget.Box({});

    const update = () => {
        execAsync("hyprctl workspaces -j")
            .then((out) => JSON.parse(out))
            .then((wss) => {
                box.children = Array.from({ length: 10 }, (_, i) => {
                    const ws = i + 1;
                    const active = wss.some((w) => w.id === ws);
                    return Widget.Button({
                        label: `${ws}`,
                        className: active ? "ws-active" : "ws-inactive",
                        onClicked: () => exec(`hyprctl dispatch workspace ${ws}`),
                    });
                });
            })
            .catch(() => {});
    };

    Utils.interval(1000, update);
    update();
    return box;
};

// ── Window Title ─────────────────────────────────────────────────
const WindowTitle = () => {
    const label = Widget.Label({ label: "" });

    Utils.interval(500, () => {
        execAsync("hyprctl activewindow -j")
            .then((out) => JSON.parse(out))
            .then((win) => {
                const newTitle = win?.title || "";
                if (newTitle !== label.label) {
                    label.label = newTitle ? `  ${newTitle}  ` : "";
                }
            })
            .catch(() => { label.label = ""; });
    });

    return label;
};

// ── Media Widget ────────────────────────────────────────────────
const Media = () => {
    const label = Widget.Label({ label: "  󱐾  " });

    Utils.interval(1000, () => {
        execAsync("playerctl metadata --format '{{title}}' 2>/dev/null")
            .then((t) => {
                label.label = t.trim()
                    ? `  󱐾 ${t.trim().substring(0, 30)}  `
                    : "  󱐾  ";
            })
            .catch(() => { label.label = "  󱐾  "; });
    });

    return label;
};

// ── Clock ───────────────────────────────────────────────────────
const Clock = () => {
    const label = Widget.Label({
        label: "  " + new Date().toLocaleTimeString("de-DE", { hour: "2-digit", minute: "2-digit" }) + "  ",
    });

    Utils.interval(1000, () => {
        label.label = "  " + new Date().toLocaleTimeString("de-DE", { hour: "2-digit", minute: "2-digit" }) + "  ";
    });

    return label;
};

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
                    onClicked: () => exec("wofi --show drun"),
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
