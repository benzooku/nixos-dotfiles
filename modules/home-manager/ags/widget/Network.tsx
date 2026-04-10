import AstalNetwork from "gi://AstalNetwork?version=0.1"
import { createPoll } from "ags/time"

export default function Network() {
  const network = AstalNetwork.get_default()

  const wifi = createPoll<{ ssid: string; connected: boolean; icon: string }>(
    { ssid: "—", connected: false, icon: "睊" },
    5000,
    () => {
      const wifiObj = network.wifi
      if (!wifiObj) return { ssid: "—", connected: false, icon: "睊" }

      const connected =
        network.state === AstalNetwork.State.CONNECTED_GLOBAL ||
        network.state === AstalNetwork.State.CONNECTED_SITE

      const ssid = wifiObj.ssid || "—"
      const icon = connected ? "📶" : "睊"

      return { ssid, connected, icon }
    },
  )

  const icon = wifi((w) => w.icon)
  const ssid = wifi((w) => w.ssid)
  const connected = wifi((w) => w.connected)

  const cls = connected((c) => `net-btn${c ? "" : " disconnected"}`)

  const tooltip = connected((c) =>
    c ? `Connected to ${ssid((s) => s)}` : "Disconnected",
  )

  return (
    <button class={cls} tooltipText={tooltip}>
      <label label={icon} class="net-icon" />
      <label label={ssid} class="net-name" widthChars={15} wrap={false} />
    </button>
  )
}
