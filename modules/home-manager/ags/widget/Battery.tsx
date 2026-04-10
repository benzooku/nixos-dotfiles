import AstalBattery from "gi://AstalBattery?version=0.1"
import { createPoll } from "ags/time"

export default function Battery() {
  const battery = createPoll<{ pct: number; charging: boolean; icon: string }>(
    { pct: 0, charging: false, icon: "󰂎" },
    30000,
    () => {
      const device = AstalBattery.get_default()
      if (!device) return { pct: 0, charging: false, icon: "󰂎" }

      const pct = Math.round(device.percentage * 100)
      const charging = device.charging

      let icon: string
      if (charging) {
        icon = "⚡"
      } else if (pct >= 90) {
        icon = "󰁹"
      } else if (pct >= 80) {
        icon = "󰁿"
      } else if (pct >= 70) {
        icon = "󰁾"
      } else if (pct >= 60) {
        icon = "󰁽"
      } else if (pct >= 50) {
        icon = "󰁼"
      } else if (pct >= 40) {
        icon = "󰁻"
      } else if (pct >= 30) {
        icon = "󰁺"
      } else if (pct >= 20) {
        icon = "󰁹"
      } else if (pct >= 10) {
        icon = "󰂎"
      } else {
        icon = "󰂎"
      }

      return { pct, charging, icon }
    },
  )

  const pct = battery((b) => `${b.pct}%`)
  const icon = battery((b) => b.icon)
  const charging = battery((b) => b.charging)

  const cls = battery(
    (b) => `bat-btn${b.pct < 20 && !b.charging ? " low" : ""}${b.charging ? " charging" : ""}`,
  )

  const tooltip = battery(
    (b) => `Battery: ${b.pct}%${b.charging ? " (charging)" : ""}`,
  )

  return (
    <button class={cls} tooltipText={tooltip}>
      <label label={icon} class="bat-icon" />
      <label label={pct} class="bat-pct" />
    </button>
  )
}
