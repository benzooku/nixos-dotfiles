import { createBinding, For, This, createPoll } from "ags"
import app from "ags/gtk4/app"
import Astal from "gi://Astal?version=4.0"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import { execAsync } from "ags/process"

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

// ── Hyprland ─────────────────────────────────────────────────────
const hyprland = Astal.Hyprland.get_default()

// ── Workspaces ───────────────────────────────────────────────────
function WorkspaceButton({ n }: { n: number }) {
    const btn = (
        <button
            label={`${n}`}
            className="ws-inactive"
            onClicked={() => execAsync(`hyprctl dispatch workspace ${n}`)}
        />
    )
    // Update class based on active workspace
    btn.hook(hyprland, () => {
        const active = hyprland.workspaces.some((w: any) => w.id === n)
        btn.className = active ? "ws-active" : "ws-inactive"
    })
    return btn
}

function Workspaces() {
    return (
        <box>
            {Array.from({ length: 10 }, (_, i) => (
                <WorkspaceButton n={i + 1} />
            ))}
        </box>
    )
}

// ── Window Title ─────────────────────────────────────────────────
function WindowTitle() {
    const label = <label xalign={0} label={""} />
    label.hook(hyprland, () => {
        const win = hyprland.active.window
        label.label = win ? `  ${win.title}  ` : ""
    })
    return label
}

// ── Media Widget ────────────────────────────────────────────────
function Media() {
    const mpris = Astal.Mpris.get_default()
    const label = <label label={"  󱐾  "} />
    label.hook(mpris, () => {
        const players = mpris.players
        if (players && players.length > 0) {
            const player = players[0]
            label.label = player.title ? `  󱐾 ${player.title.substring(0, 30)}  ` : "  󱐾  "
        } else {
            label.label = "  󱐾  "
        }
    })
    return label
}

// ── Clock ───────────────────────────────────────────────────────
function Clock() {
    // createPoll(initial, interval_ms, shell_command)
    const time = createPoll("  --:--  ", 1000, `date "+%H:%M"`)
    return <label label={time} />
}

// ── Tray ─────────────────────────────────────────────────────────
function Tray() {
    const tray = Astal.Tray.get_default()
    const box = <box />
    tray.hook(tray, () => {
        const items = tray.items
        box.children = items.map((item: any) => (
            <menubutton
                gicon={createBinding(item, "gicon")}
                menuModel={item.menuModel}
                actionGroup={item.actionGroup}
            />
        ))
    })
    return box
}

// ── Top Bar ─────────────────────────────────────────────────────
function Bar({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) {
    return (
        <window
            gdkmonitor={gdkmonitor}
            className="topbar"
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={Astal.Edge.TOP | Astal.Edge.LEFT | Astal.Edge.RIGHT}
        >
            <centerbox>
                <box hexpand halign={Gtk.Align.START}>
                    <button
                        label={"  󰣇  "}
                        onClicked={() => execAsync("wofi --show drun")}
                    />
                    <Workspaces />
                </box>
                <WindowTitle />
                <box halign={Gtk.Align.END}>
                    <Media />
                    <Tray />
                    <Clock />
                </box>
            </centerbox>
        </window>
    )
}

// ── Main ────────────────────────────────────────────────────────
app.start({
    css: `
        * { all: unset; font-family: "JetBrains Mono", monospace; font-size: 12px; color: ${C.text}; }
        window { background-color: ${C.surface}; border-bottom: 1px solid ${C.border}; }
        .topbar { background-color: ${C.surface}; }
        button { background-color: transparent; border-radius: 6px; padding: 4px 8px; color: ${C.textDim}; }
        button:hover { background-color: ${C.border}; color: ${C.text}; }
        .ws-active { background-color: ${C.accentSubtle}; color: ${C.accent}; }
        .ws-inactive { background-color: transparent; color: ${C.textDim}; }
    `,
    gtkTheme: "Adwaita",
    main() {
        const monitors = createBinding(app, "monitors")
        return (
            <For each={monitors}>
                {(monitor) => (
                    <This this={app}>
                        <Bar gdkmonitor={monitor} />
                    </This>
                )}
            </For>
        )
    },
})
