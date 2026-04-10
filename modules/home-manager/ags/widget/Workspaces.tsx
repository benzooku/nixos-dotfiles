import { Gtk } from "ags/gtk4"
import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

interface HyprWorkspace {
  id: number
  windows: number
}

function WorkspaceButton({ id }: { id: number }) {
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

  // Compute class from within accessor subscriptions
  const cls = workspaces((list) => {
    const isOccupied = list.some((w) => w.id === id)
    const isActive = focusedId((fid) => fid === id)
    if (isActive) return isOccupied ? "ws-btn active occupied" : "ws-btn active"
    if (isOccupied) return "ws-btn occupied"
    return "ws-btn"
  })

  const tooltip = workspaces((list) => {
    const ws = list.find((w) => w.id === id)
    return ws ? `${id} — ${ws.windows} window(s)` : `Workspace ${id}`
  })

  return (
    <button
      class={cls}
      onClicked={() => execAsync(["bash", "-c", `hyprctl dispatch workspace ${id}`])}
      tooltipText={tooltip}
    >
      <label label={String(id)} class="ws-num" />
    </button>
  )
}

export default function Workspaces() {
  return (
    <box class="workspaces" spacing={2}>
      {[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((n) => (
        <WorkspaceButton id={n} key={n} />
      ))}
    </box>
  )
}
