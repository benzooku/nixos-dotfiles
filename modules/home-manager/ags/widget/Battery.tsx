import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

function batteryIcon(pct: number, charging: boolean): string {
  if (charging) return "⚡"
  if (pct >= 90) return "󰁹"
  if (pct >= 80) return "󰁿"
  if (pct >= 70) return "󰁾"
  if (pct >= 60) return "󰁽"
  if (pct >= 50) return "󰁼"
  if (pct >= 40) return "󰁻"
  if (pct >= 30) return "󰁺"
  if (pct >= 20) return "󰁹"
  if (pct >= 10) return "󰂎"
  return "󰂎"
}

export default function Battery() {
  const bat = createPoll<{ pct: number; charging: boolean }>(
    { pct: 0, charging: false },
    30000,
    () =>
      execAsync([
        "bash",
        "-c",
        "cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo '0'",
      ]).then((out) => {
        const pct = parseInt(out.trim(), 10)
        const charging = execAsync([
          "bash",
          "-c",
          "cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo 'Unknown'",
        ]).then((s) => s.trim() === "Charging")
        return {
          pct: isNaN(pct) ? 0 : pct,
          charging: false,
        }
      }),
  )

  return (
    <button
      class={bat((b) =>
        `bat-btn ${b.pct < 20 && !b.charging ? "low" : ""} ${b.charging ? "charging" : ""}`
      )}
      tooltipText={bat((b) => `${b.pct}%${b.charging ? " (charging)" : ""}`)}
    >
      <label label={bat((b) => batteryIcon(b.pct, b.charging))} class="bat-icon" />
      <label label={bat((b) => `${b.pct}%`)} class="bat-pct" />
    </button>
  )
}
