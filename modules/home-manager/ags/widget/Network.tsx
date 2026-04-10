import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

export default function Network() {
  const net = createPoll<{ ssid: string; connected: boolean }>(
    { ssid: "—", connected: false },
    5000,
    () =>
      execAsync([
        "bash",
        "-c",
        `nmcli -t -f STATE,SSID dev wifi 2>/dev/null | head -1 || echo "disconnected:"`,
      ]).then((out) => {
        const line = out.trim()
        if (line.startsWith("disconnected") || !line) {
          return { ssid: "—", connected: false }
        }
        const parts = line.split(":")
        return {
          ssid: parts[1] || parts[0] || "—",
          connected: true,
        }
      }),
  )

  return (
    <button
      class={net((n) => `net-btn ${n.connected ? "" : "disconnected"}`)}
      tooltipText={net((n) => n.connected ? n.ssid : "Disconnected")}
    >
      <label
        label={net((n) => (n.connected ? "📶" : "睊"))}
        class="net-icon"
      />
      <label label={net((n) => n.ssid)} class="net-name" />
    </button>
  )
}
