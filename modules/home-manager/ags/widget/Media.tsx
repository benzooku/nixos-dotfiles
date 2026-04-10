import AstalMpris from "gi://AstalMpris?version=0.1"
import { execAsync } from "ags/process"

export default function Media() {
  const mpris = AstalMpris.get_default()
  const players = mpris.players
  const player = players.length > 0 ? players[0] : null

  if (!player || !player.available) {
    return <box />
  }

  const label = (() => {
    const title = player.track?.title || "Not playing"
    const artist = player.track?.artist || ""
    const text = artist ? `${artist} — ${title}` : title
    return text.length > 45 ? text.slice(0, 45) + "…" : text
  })()

  const playing = player.playing

  return (
    <button
      class={`media ${playing ? "playing" : "paused"}`}
      onClicked={() => player.play_pause()}
    >
      <label label={playing ? "▶" : "⏸"} class="media-icon" />
      <label label={label} class="media-label" truncate />
    </button>
  )
}
