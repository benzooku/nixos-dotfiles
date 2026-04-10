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
          const parsed = JSON.parse(out.trim())
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
        const n = parseInt(out.trim(), 10)
        return isNaN(n) ? 0 : n
      }),
  )

  // Compute class by subscribing to both accessors
  // The button re-renders when workspaces OR focusedId changes
  function getClass(): string {
    let occupied = false
    let active = false

    // Subscribe to workspaces
    workspaces((list) => {
      occupied = list.some((w: HyprWorkspace) => w.id === id)
    })

    // Subscribe to focusedId
    focusedId((fid) => {
      active = fid === id
    })

    const cls = `ws-btn${active ? " active" : ""}${occupied ? " occupied" : ""}`
    return cls
  }

  const cls = createPoll<string>(
    "ws-btn",
    500,
    () => {
      let occupied = false
      let active = false

      // Subscribe to both within the poll callback
      // This works because createPoll re-runs when any subscribed accessor changes
      workspaces((list) => {
        occupied = list.some((w: HyprWorkspace) => w.id === id)
      })

      focusedId((fid) => {
        active = fid === id
      })

      return `ws-btn${active ? " active" : ""}${occupied ? " occupied" : ""}`
    },
  )

  const tooltip = createPoll<string>(
    `Workspace ${id}`,
    500,
    () => {
      let tip = `Workspace ${id}`
      workspaces((list) => {
        const ws = list.find((w: HyprWorkspace) => w.id === id)
        if (ws) {
          tip = `Workspace ${id} — ${ws.windows} window(s)`
        }
      })
      return tip
    },
  )

  function handleClick() {
    execAsync(["bash", "-c", `hyprctl dispatch workspace ${id}`])
  }

  return (
    <button
      class={cls((c) => c)}
      onClicked={handleClick}
      tooltipText={tooltip((t) => t)}
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
