import { Gtk } from "ags/gtk4"
import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

interface HyprWorkspace {
  id: number
  windows: number
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

        return (
          <button
            class={workspaces((list) =>
              focusedId((fid) =>
                list.some((w) => w.id === wsId)
                  ? fid === wsId
                    ? "ws-btn active occupied"
                    : "ws-btn occupied"
                  : fid === wsId
                    ? "ws-btn active"
                    : "ws-btn"
              )
            )}
            onClicked={() =>
              execAsync(["bash", "-c", `hyprctl dispatch workspace ${wsId}`])
            }
            tooltipText={workspaces((list) => {
              const ws = list.find((w) => w.id === wsId)
              return ws ? `${wsId} — ${ws.windows} window(s)` : `Workspace ${wsId}`
            })}
          >
            <label label={String(n)} class="ws-num" />
            {workspaces((list) => list.some((w) => w.id === wsId) && (
              <box class="ws-dot" halign={Gtk.Align.END} valign={Gtk.Align.END} />
            ))}
          </button>
        )
      })}
    </box>
  )
}
