import { Gtk } from "ags/gtk4"
import AstalMpris from "gi://AstalMpris?version=0.1"
import { createPoll } from "ags/time"

export default function Media() {
  const mpris = AstalMpris.get_default()

  const playerCount = createPoll<number>(
    0,
    1000,
    () => mpris.players.length,
  )

  const info = createPoll<{ label: string; playing: boolean; artist: string; title: string }>(
    { label: "—", playing: false, artist: "", title: "" },
    1000,
    () => {
      const players = mpris.players
      if (!players || players.length === 0) {
        return { label: "—", playing: false, artist: "", title: "" }
      }

      const player = players[0]
      const artist = player.artist || ""
      const title = player.title || ""
      const playing = player.playbackStatus === AstalMpris.PlaybackStatus.PLAYING

      let label = "—"
      if (artist && title) {
        label = `${artist} — ${title}`
      } else if (title) {
        label = title
      } else if (artist) {
        label = artist
      }

      if (label.length > 40) {
        label = label.slice(0, 40) + "…"
      }

      return { label, playing, artist, title }
    },
  )

  // Reactive class: show "hidden" when no players, "playing"/"paused" when active
  const cls = createPoll<string>(
    "media-btn hidden",
    1000,
    () => {
      const count = playerCount.get()
      if (count === 0) return "media-btn hidden"
      const { playing } = info.get()
      return `media-btn${playing ? " playing" : " paused"}`
    },
  )

  const tooltip = info(
    (i) => (i.artist && i.title ? `${i.artist} — ${i.title}` : i.label),
  )

  const icon = info((i) => (i.playing ? "▶" : "⏸"))
  const label = info((i) => i.label)

  function handleClick() {
    const players = mpris.players
    if (players.length > 0 && players[0].canControl) {
      players[0].play_pause()
    }
  }

  return (
    <button class={cls} onClicked={handleClick} tooltipText={tooltip}>
      <label label={icon} class="media-icon" />
      <label label={label} class="media-label" />
    </button>
  )
}
