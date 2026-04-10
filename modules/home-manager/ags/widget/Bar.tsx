import { Astal, Gtk, Gdk } from "ags/gtk4"
import AstalTray from "gi://AstalTray?version=0.1"
import app from "ags/gtk4/app"
import Workspaces from "./Workspaces"
import ActiveWindow from "./ActiveWindow"
import Media from "./Media"
import Volume from "./Volume"
import Network from "./Network"
import Battery from "./Battery"
import SysIndicators from "./SysIndicators"
import Clock from "./Clock"

function Tray() {
  const tray = AstalTray.Tray.get_default()
  const items = tray.items

  if (items.length === 0) return <box />

  return (
    <box class="tray-box" spacing={4}>
      {items.map((item) => (
        <button
          class="tray-btn"
          onClicked={() => item.activate(0, 0)}
          tooltipText={item.title || "Tray item"}
        >
          <label label={item.iconName || "●"} />
        </button>
      ))}
    </box>
  )
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return (
    <window
      visible
      name="bar"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox class="bar">
        {/* ── Left ── Workspaces + Active window */}
        <box halign={Gtk.Align.START} class="bar-left">
          <Workspaces />
          <separator direction={Gtk.Orientation.VERTICAL} class="sep" />
          <ActiveWindow />
        </box>

        {/* ── Center ── Media player */}
        <box halign={Gtk.Align.CENTER} class="bar-center">
          <Media />
        </box>

        {/* ── Right ── System indicators + Tray + Clock */}
        <box halign={Gtk.Align.END} class="bar-right">
          <SysIndicators />
          <Volume />
          <Network />
          <Battery />
          <Tray />
          <separator direction={Gtk.Orientation.VERTICAL} class="sep" />
          <Clock />
        </box>
      </centerbox>
    </window>
  )
}
