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
      } else if (pct >= 95) {
        icon = "󰁹"
      } else if (pct >= 85) {
        icon = "󰁿"
      } else if (pct >= 75) {
        icon = "󰁾"
      } else if (pct >= 65) {
        icon = "󰁽"
      } else if (pct >= 55) {
        icon = "󰁼"
      } else if (pct >= 45) {
        icon = "󰁻"
      } else if (pct >= 35) {
        icon = "󰁺"
      } else if (pct >= 25) {
        icon = "󰁹"
      } else if (pct >= 15) {
        icon = "󰂎"
      } else {
        icon = "󰂃"
      }

      return { pct, charging, icon }
    },
  )

  const pct = battery((b) => `${b.pct}%`)
  const icon = battery((b) => b.icon)
  const charging = battery((b) => b.charging)

  const cls = battery(
    (b) =>
      `bat-btn${b.pct < 20 && !b.charging ? " low" : ""}${b.charging ? " charging" : ""}`,
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
