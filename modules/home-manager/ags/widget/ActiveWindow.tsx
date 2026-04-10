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

  return (
    <box class="active-window">
      <label
        class="window-title"
        label={title((t) => {
          if (!t) return "—"
          return t.length > 45 ? t.slice(0, 45) + "…" : t
        })}
      />
    </box>
  )
}
