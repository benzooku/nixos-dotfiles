import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

export default function Volume() {
  const muted = createPoll<boolean>(
    false,
    1500,
    () =>
      execAsync([
        "bash",
        "-c",
        "wpctl get-mute @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep -q '1' && echo yes || echo no",
      ]).then((out) => out.trim() === "yes"),
  )

  const pct = createPoll<string>(
    "100%",
    1500,
    () =>
      execAsync([
        "bash",
        "-c",
        "wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{printf \"%d%%\", $2*100}' || echo '100%'",
      ]).then((out) => out.trim()),
  )

  const icon = muted((m) => (m ? "婢" : "🔊"))

  const cls = muted((m) => `volume-btn${m ? " muted" : ""}`)

  function handleClick() {
    execAsync(["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"])
  }

  return (
    <button class={cls} onClicked={handleClick}>
      <label label={icon} class="vol-icon" />
      <label label={pct} class="vol-pct" />
    </button>
  )
}
