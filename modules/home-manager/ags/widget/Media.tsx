import AstalMpris from "gi://AstalMpris?version=0.1"
import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

interface MediaInfo {
  label: string
  playing: boolean
}

export default function Media() {
  const media = createPoll<MediaInfo>(
    { label: "—", playing: false },
    1000,
    () =>
      execAsync([
        "bash",
        "-c",
        `playerctl -p $(playerctl -l 2>/dev/null | head -1) metadata --format '{{artist}} --- {{title}}' 2>/dev/null || echo ''`,
      ]).then((out) => {
        const text = out.trim()
        if (!text || text === "---") return { label: "—", playing: false }
        const playing = execAsync([
          "bash",
          "-c",
          "playerctl -p $(playerctl -l 2>/dev/null | head -1) status 2>/dev/null || echo 'Stopped'",
        ]).then((s) => s.trim() === "Playing")
        return {
          label: text.length > 45 ? text.slice(0, 45) + "…" : text,
          playing: false,
        }
      }),
  )

  return (
    <box class="media playing">
      <label label="▶" class="media-icon" />
      <label label={media((m) => m.label)} class="media-label" />
    </box>
  )
}
