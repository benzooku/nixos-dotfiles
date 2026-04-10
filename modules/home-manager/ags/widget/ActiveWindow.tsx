import { Gtk } from "ags/gtk4"
import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

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
    return t.length > 45 ? t.slice(0, 45) + "…" : t
  })

  return (
    <box class="active-window">
      <label
        label={displayTitle}
        class="window-title"
        ellipsize={Gtk.EllipsizeMode.END}
      />
    </box>
  )
}
