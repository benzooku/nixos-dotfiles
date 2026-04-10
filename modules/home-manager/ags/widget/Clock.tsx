import { createPoll } from "ags/time"
import { execAsync } from "ags/process"

export default function Clock() {
  const timeStr = createPoll<string>(
    "",
    1000,
    () =>
      execAsync([
        "bash",
        "-c",
        "date '+%H:%M  •  %a %d %b'",
      ]).then((out) => out.trim()),
  )

  return (
    <button class="clock-btn" tooltipText="Click to view calendar">
      <label label={timeStr} class="clock-label" />
    </button>
  )
}
