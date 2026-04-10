import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

export default function SysIndicators() {
  const cpu = createPoll<string>(
    "0%",
    5000,
    () =>
      execAsync([
        "bash",
        "-c",
        "top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | tr -d 'user,' || echo '0'",
      ]).then((out) => {
        const v = parseFloat(out.trim())
        return isNaN(v) ? "0%" : `${Math.round(v)}%`
      }),
  )

  const mem = createPoll<string>(
    "0%",
    5000,
    () =>
      execAsync([
        "bash",
        "-c",
        "free -m | awk 'NR==2{printf \"%d%%\", $3*100/$2}' || echo '0%'",
      ]).then((out) => out.trim()),
  )

  return (
    <box class="sys-indicators" spacing={6}>
      <box class="sys-item" tooltipText="CPU usage">
        <label label="" class="sys-icon" />
        <label label={cpu} class="sys-val" />
      </box>
      <box class="sys-item" tooltipText="Memory usage">
        <label label="󰍛" class="sys-icon" />
        <label label={mem} class="sys-val" />
      </box>
    </box>
  )
}
