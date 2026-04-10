import AstalNetwork from "gi://AstalNetwork?version=0.1"

function getIcon(net: AstalNetwork.Network): string {
  const primary = net.primary
  if (!primary) return "睊"
  if (primary.strength < 30) return "📶"
  if (primary.strength < 60) return "📶"
  return "📶"
}

export default function Network() {
  const net = AstalNetwork.get_default()
  const primary = net.primary

  if (!primary || !primary.is_connected) {
    return (
      <button class="net-btn disconnected">
        <label label="睊" class="net-icon" />
        <label label="—" class="net-name" />
      </button>
    )
  }

  const ssid = primary.ssid || "Wired"
  const icon = getIcon(net)

  return (
    <button class="net-btn" tooltipText={ssid}>
      <label label={icon} class="net-icon" />
      <label label={ssid} class="net-name" truncate />
    </button>
  )
}
