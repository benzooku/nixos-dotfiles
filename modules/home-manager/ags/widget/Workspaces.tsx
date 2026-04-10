import { Gtk } from "ags/gtk4"
import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

interface HyprWorkspace {
  id: number
  windows: number
}

interface HyprworkspacesResult {
  workspaces: HyprWorkspace[]
}

interface HyprFocusResult {
  focused: boolean
}

export default function Workspaces() {
  // Poll workspace list from Hyprland
  const workspaces = createPoll<HyprWorkspace[]>(
    [],
    500,
    () =>
      execAsync([
        "bash",
        "-c",
        "hyprctl workspaces -j 2>/dev/null || echo '[]'",
      ]).then((out) => {
        try {
          const parsed = JSON.parse(out.trim()) as HyprWorkspace[]
          return Array.isArray(parsed) ? parsed : []
        } catch {
          return [] as HyprWorkspace[]
        }
      }),
  )

  // Poll focused workspace id
  const focusedId = createPoll<number>(
    0,
    500,
    () =>
      execAsync([
        "bash",
        "-c",
        "hyprctl activeworkspace -j 2>/dev/null | grep -o '\"id\":[0-9]*' | grep -o '[0-9]*' || echo '0'",
      ]).then((out) => {
        const id = parseInt(out.trim(), 10)
        return isNaN(id) ? 0 : id
      }),
  )

  const NUM_WORKSPACES = 10

  return (
    <box class="workspaces" spacing={2}>
      {Array.from({ length: NUM_WORKSPACES }, (_, i) => i + 1).map((n) => {
        const wsId = n
        const occupied = workspaces((list) =>
          list.some((w) => w.id === wsId),
        )
        const active = focusedId((id) => id === wsId)

        return (
          <button
            class={`ws-btn ${active ? "active" : ""} ${occupied && !active ? "occupied" : ""}`}
            onClicked={() =>
              execAsync(["bash", "-c", `hyprctl dispatch workspace ${wsId}`])
            }
            tooltipText={
              occupied
                ? `${wsId} — ${workspaces((l) => l.find((w) => w.id === wsId)?.windows ?? 0)} window(s)`
                : `Workspace ${wsId}`
            }
          >
            <label label={String(n)} class="ws-num" />
            {occupied && !active && <box class="ws-dot" halign={Gtk.Align.END} valign={Gtk.Align.END} />}
          </button>
        )
      })}
    </box>
  )
}
