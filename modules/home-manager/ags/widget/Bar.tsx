import { Astal, Gtk, Gdk } from "ags/gtk4"
import app from "ags/gtk4/app"
import Workspaces from "./Workspaces"
import ActiveWindow from "./ActiveWindow"
import Media from "./Media"
import Volume from "./Volume"
import Network from "./Network"
import Battery from "./Battery"
import Clock from "./Clock"

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
      <box class="bar">
        {/* Left: Workspaces */}
        <box hexpand halign={Gtk.Align.START} class="bar-left">
          <Workspaces />
        </box>

        {/* Center: Active window title */}
        <box hexpand halign={Gtk.Align.CENTER} class="bar-center">
          <ActiveWindow />
        </box>

        {/* Right: System indicators */}
        <box hexpand halign={Gtk.Align.END} class="bar-right">
          <Media />
          <Volume />
          <Network />
          <Battery />
          <Clock />
        </box>
      </box>
    </window>
  )
}
