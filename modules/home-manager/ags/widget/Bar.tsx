import { Astal, Gtk, Gdk } from "ags/gtk4"
import app from "ags/gtk4/app"

function Sep() {
  return <box class="sep" valign={Gtk.Align.FILL} />
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
        <box halign={Gtk.Align.START} class="bar-left" hexpand>
          <label label="1 2 3 4 5 6 7 8 9 10" class="ws-label" />
        </box>
        <box halign={Gtk.Align.CENTER} class="bar-center" hexpand>
          <label label="Media Player" class="media-label" />
        </box>
        <box halign={Gtk.Align.END} class="bar-right" hexpand>
          <label label="Vol  Net  Bat  Clock" class="sys-label" />
        </box>
      </centerbox>
    </window>
  )
}
