import { Gtk } from "ags/gtk4"
import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

interface HyprWorkspace {
  id: number
  windows: number
}

const MAX_WORKSPACES = 10

export default function Workspaces() {
  const workspaces = createPoll<HyprWorkspace[]>(
    [],
    300,
    () =>
      execAsync(["bash", "-c", "hyprctl workspaces -j 2>/dev/null"])
        .then((out) => {
          try {
            const parsed = JSON.parse(out.trim())
            return Array.isArray(parsed) ? parsed : []
          } catch {
            return []
          }
        }),
  )

  const focusedId = createPoll<number>(
    0,
    300,
    () =>
      execAsync([
        "bash",
        "-c",
        "hyprctl activeworkspace -j 2>/dev/null | grep -o '\"id\":[0-9]*' | grep -o '[0-9]*' || echo '0'",
      ]).then((out) => {
        const n = parseInt(out.trim(), 10)
        return isNaN(n) ? 0 : n
      }),
  )

  function handleClick(id: number) {
    execAsync(["hyprctl", "dispatch", "workspace", String(id)])
  }

  const buttons = Array.from({ length: MAX_WORKSPACES }, (_, i) => {
    const id = i + 1

    // Reactive class based on both workspaces list and focused id
    const cls = createPoll<string>(
      "ws-btn",
      300,
      () => {
        const list = workspaces.get()
        const fid = focusedId.get()
        const occupied = list.some((w: HyprWorkspace) => w.id === id)
        const active = fid === id
        return `ws-btn${active ? " active" : ""}${occupied ? " occupied" : ""}`
      },
    )

    const tooltip = createPoll<string>(
      `Workspace ${id}`,
      300,
      () => {
        const list = workspaces.get()
        const ws = list.find((w: HyprWorkspace) => w.id === id)
        return ws ? `Workspace ${id} — ${ws.windows} window(s)` : `Workspace ${id}`
      },
    )

    return (
      <button
        class={cls}
        onClicked={() => handleClick(id)}
        tooltipText={tooltip}
      >
        <label label={String(id)} class="ws-num" />
      </button>
    )
  })

  return (
    <box class="workspaces" spacing={2}>
      {buttons}
    </box>
  )
}
