import { Gtk } from "ags/gtk4"
import Pango from "gi://Pango?version=1.0"
import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

const MAX_TITLE_LENGTH = 45

export default function ActiveWindow() {
  const title = createPoll<string>(
    "",
    800,
    () =>
      execAsync([
        "bash",
        "-c",
        "hyprctl activewindow -j 2>/dev/null | grep -o '\"title\":\"[^\"]*\"' | head -1 | sed 's/\"title\":\"//;s/\"$//' || echo ''",
      ]).then((out) => out.trim()),
  )

  const displayTitle = title((t) => {
    if (!t) return "—"
    return t.length > MAX_TITLE_LENGTH ? t.slice(0, MAX_TITLE_LENGTH) + "…" : t
  })

  return (
    <box class="active-window" hexpand>
      <label
        label={displayTitle}
        class="window-title"
        ellipsize={Pango.EllipsizeMode.END}
      />
    </box>
  )
}
