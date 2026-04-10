#!/usr/bin/env -S ags run
/// <reference path=".ags/types.ts" />
import Astal from "gi://Astal?version=0.1"
import AstalHyprland from "gi://AstalHyprland?version=0.1"
import AstalBattery from "gi://AstalBattery?version=0.1"
import AstalNetwork from "gi://AstalNetwork?version=0.1"
import AstalMpris from "gi://AstalMpris?version=0.1"
import AstalTray from "gi://AstalTray?version=0.1"
import { createPoll, execAsync } from "ags/time"
import { exec } from "ags/process"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"

// ── Azurra Theme ─────────────────────────────────────────────
const C = {
  bg: "#0d1117",
  surface: "#161b22",
  muted: "#21262d",
  border: "#30363d",
  text: "#e6edf3",
  textDim: "#8b949e",
  accent: "#58a6ff",
  accentSubtle: "#1f6feb",
  danger: "#f85149",
  success: "#3fb950",
}

// ── Helpers ───────────────────────────────────────────────────
const rgba = (hex, alpha = 1) => {
  const r = parseInt(hex.slice(1, 3), 16)
  const g = parseInt(hex.slice(3, 5), 16)
  const b = parseInt(hex.slice(5, 7), 16)
  return `rgba(${r},${g},${b},${alpha})`
}

const clock = createPoll("", 1000, "date '+%H:%M  •  %a %d %b'")

// ── Widgets ───────────────────────────────────────────────────

function Workspaces() {
  const hyprland = AstalHyprland.get_default()

  return (
    <box className="workspaces" spacing={4}>
      {[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((i) => {
        const ws = hyprland.get_workspace(i)
        const active = ws ? ws.id === hyprland.get_focused_workspace()?.id : false
        const windows = ws ? ws.get_clients() : []

        return (
          <button
            className={`ws-btn ${active ? "active" : ""} ${windows.length > 0 ? "occupied" : ""}`}
            onClick={() => execAsync(["hyprctl", "dispatch", "workspace", String(i)])}
            tooltipText={windows.length > 0 ? windows.map((c) => c.title).join(", ") : `Workspace ${i}`}
          >
            <label label={String(i)} />
            {windows.length > 0 && <box className="ws-dot" halign={Gtk.Align.END} valign={Gtk.Align.END} />}
          </button>
        )
      })}
    </box>
  )
}

function ActiveWindow() {
  const hyprland = AstalHyprland.get_default()
  const client = hyprland.get_focused_client()

  if (!client) return <label className="text-dim" label="—" />

  const title = client.title.length > 40 ? client.title.slice(0, 40) + "…" : client.title
  return <label className="window-title" label={title} truncate />
}

function Media() {
  const mpris = AstalMpris.get_default()
  const player = mpris.players[0]

  if (!player || !player.available) return <box />

  const artist = player.track?.artist || ""
  const title = player.track?.title || "Not playing"
  const playing = player.playing

  const label = artist ? `${artist} — ${title}` : title

  return (
    <button
      className={`media ${playing ? "playing" : "paused"}`}
      onClick={() => player.play_pause()}
      tooltipText={playing ? "Pause" : "Play"}
    >
      <label label={`${playing ? "▶" : "⏸"} ${label}`} truncate />
    </button>
  )
}

function Volume() {
  const vol = createPoll("", 2000, "wpctl get-volume @DEFAULT_AUDIO_SINK@")
  const muted = createPoll(false, 2000, () => {
    try {
      const out = exec("wpctl get-mute @DEFAULT_AUDIO_SINK@").trim()
      return out.includes("1")
    } catch { return false }
  })

  return (
    <button
      className={`volume ${muted((m) => m ? "muted" : "unmuted")}`}
      onClick={() => execAsync(["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"])}
      tooltipText={muted() ? "Unmute" : "Mute"}
    >
      <label label={muted((m) => m ? "婢" : "🔊")} />
      <label className="vol-pct" label={vol((v) => {
        const pct = Math.round(parseFloat(v.split(":")[1]) * 100)
        return `${pct}%`
      })} />
    </button>
  )
}

function Network() {
  const net = AstalNetwork.get_default()
  const primary = net.primary

  if (!primary || !primary.connected) {
    return (
      <button className="net disconnected" tooltipText="Disconnected">
        <label label="睊" />
        <label className="net-name" label="—" />
      </button>
    )
  }

  const icon = primary.wifi ? "直" : "歷"
  const ssid = primary.wifi?.ssid || primary.wired?.interface || "Connected"
  const strength = primary.strength

  return (
    <button
      className={`net ${primary.wifi ? "wifi" : "wired"} ${strength < 30 ? "weak" : ""}`}
      tooltipText={ssid}
    >
      <label label={icon} />
      <label className="net-name" label={ssid} truncate />
    </button>
  )
}

function Battery() {
  const battery = AstalBattery.get_default()
  const bat = battery.devices[0]

  if (!bat) return <box />

  const pct = Math.round(bat.percentage * 100)
  const state = bat.state
  const icon = state === "charging" ? "⚡" : pct > 80 ? "󰁹" : pct > 60 ? "󰁿" : pct > 40 ? "󰁾" : pct > 20 ? "󰁽" : "󰂎"
  const color = pct < 20 ? C.danger : pct < 40 ? "#f0883e" : C.textDim

  return (
    <button
      className={`battery ${state === "charging" ? "charging" : ""}`}
      tooltipText={`${pct}%${state === "charging" ? " (charging)" : ""}`}
    >
      <label className="bat-icon" label={icon} />
      <label className="bat-pct" label={`${pct}%`} />
    </button>
  )
}

function CpuMem() {
  const cpu = createPoll("0%", 5000, "bash -c 'top -bn1 | grep Cpu | awk \\'{print $2}\\' | tr -d \\'user,\\''")
  const mem = createPoll("0%", 5000, "bash -c 'free -m | awk \\'NR==2{printf \"%d%%\", $3*100/$2 }\\''")

  return (
    <box className="sys-indicators" spacing={12}>
      <tooltip text="CPU usage">
        <box className="sys-item">
          <label className="sys-icon" label="﬙" />
          <label className="sys-val" label={cpu((v) => v.trim() || "0%")} />
        </box>
      </tooltip>
      <tooltip text="Memory usage">
        <box className="sys-item">
          <label className="sys-icon" label=" RAM" />
          <label className="sys-val" label={mem()} />
        </box>
      </tooltip>
    </box>
  )
}

function Clock() {
  return (
    <button className="clock" onClick={() => execAsync(["bash", "-c", "calendar && read"])}>
      <label label={clock()} />
    </button>
  )
}

function SysTray() {
  return <AstalTray.TrayItemManager orientation={Gtk.Orientation.HORIZONTAL} />
}

// ── Bar ──────────────────────────────────────────────────────
app.start({
  css: `
    * { color: ${C.text}; font-family: "JetBrains Mono", monospace; font-size: 13px; }
    window { background: ${C.bg}; }
    .bar { padding: 0 12px; }
    .workspaces { padding: 0 8px; }
    .ws-btn {
      background: transparent;
      color: ${C.textDim};
      border: none;
      border-bottom: 2px solid transparent;
      border-radius: 0;
      padding: 6px 8px;
      min-width: 28px;
      box-shadow: none;
    }
    .ws-btn:hover { background: ${C.surface}; color: ${C.text}; }
    .ws-btn.active { color: ${C.accent}; border-bottom: 2px solid ${C.accent}; }
    .ws-btn.occupied .ws-dot {
      background: ${C.accentSubtle};
      border-radius: 50%;
      width: 4px;
      height: 4px;
    }
    .ws-dot { min-width: 4px; min-height: 4px; }
    .window-title { color: ${C.text}; font-size: 12px; padding: 0 8px; }
    .text-dim { color: ${C.textDim}; }
    .media {
      background: transparent;
      border: none;
      color: ${C.text};
      padding: 4px 10px;
      border-radius: 0;
      max-width: 220px;
    }
    .media:hover { background: ${C.surface}; }
    .media.playing label:first-child { color: ${C.success}; }
    .media.paused label:first-child { color: ${C.textDim}; }
    .volume, .net, .battery {
      background: transparent;
      border: none;
      color: ${C.accent};
      padding: 4px 8px;
      border-radius: 0;
    }
    .volume:hover, .net:hover, .battery:hover { background: ${C.surface}; }
    .vol-pct, .net-name, .bat-pct { color: ${C.textDim}; margin-left: 4px; font-size: 12px; }
    .net.disconnected { color: ${C.textDim}; }
    .net-name { max-width: 100px; }
    .sys-indicators { }
    .sys-item { background: transparent; }
    .sys-icon { color: ${C.textDim}; font-size: 12px; }
    .sys-val { color: ${C.textDim}; font-size: 12px; margin-left: 2px; }
    .clock {
      background: transparent;
      border: none;
      color: ${C.textDim};
      padding: 4px 10px;
      border-radius: 0;
    }
    .clock:hover { background: ${C.surface}; color: ${C.text}; }
    box { transition: background 0.2s; }
    tooltip {
      background: ${C.surface};
      color: ${C.text};
      border: 1px solid ${C.border};
      border-radius: 6px;
      padding: 6px 10px;
      font-size: 12px;
    }
  `,

  main() {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    Gtk.Widget.set_default_direction(Gtk.TextDirection.LTR)

    return (
      <window
        visible
        anchor={TOP | LEFT | RIGHT}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        layer={Astal.Layer.TOP}
      >
        <centerbox className="bar">
          {/* Left: Workspaces + Active Window */}
          <box halign={Gtk.Align.START} className="bar-left">
            <Workspaces />
            <separator direction={Gtk.Orientation.VERTICAL} />
            <ActiveWindow />
          </box>

          {/* Center: Media */}
          <box halign={Gtk.Align.CENTER} className="bar-center">
            <Media />
          </box>

          {/* Right: System indicators + Tray + Clock */}
          <box halign={Gtk.Align.END} className="bar-right">
            <CpuMem />
            <Volume />
            <Network />
            <Battery />
            <SysTray />
            <separator direction={Gtk.Orientation.VERTICAL} />
            <Clock />
          </box>
        </centerbox>
      </window>
    )
  },
})
