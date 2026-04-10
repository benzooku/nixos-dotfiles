import AstalBattery from "gi://AstalBattery?version=0.1"

function batteryIcon(pct: number, state: AstalBattery.State): string {
  if (state === AstalBattery.State.CHARGING) return "⚡"
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
  const device = AstalBattery.get_default()

  if (!device) return <box />

  const pct = Math.round(device.percentage * 100)
  const state = device.state
  const isLow = pct < 20 && state !== AstalBattery.State.CHARGING
  const isCharging = state === AstalBattery.State.CHARGING

  return (
    <button
      class={`bat-btn ${isLow ? "low" : ""} ${isCharging ? "charging" : ""}`}
      tooltipText={`${pct}%${isCharging ? " (charging)" : ""}`}
    >
      <label label={batteryIcon(pct, state)} class="bat-icon" />
      <label label={`${pct}%`} class="bat-pct" />
    </button>
  )
}
