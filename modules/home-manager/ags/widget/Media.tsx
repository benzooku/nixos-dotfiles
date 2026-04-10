import { Gtk } from "ags/gtk4"
import AstalMpris from "gi://AstalMpris?version=0.1"
import { createPoll } from "ags/time"

export default function Media() {
  const mpris = AstalMpris.get_default()

  // Poll for player count to detect when media starts/stops
  const playerCount = createPoll<number>(
    0,
    1000,
    () => mpris.players.length,
  )

  // Get first player info if available
  const hasPlayer = playerCount((c) => c > 0)

  const info = createPoll<{ label: string; playing: boolean }>(
    { label: "—", playing: false },
    1000,
    () => {
      const players = mpris.players
      if (!players || players.length === 0) {
        return { label: "—", playing: false }
      }

      const player = players[0]
      const artist = player.artist || ""
      const title = player.title || ""
      const label =
        !artist && !title
          ? "—"
          : `${artist} — ${title}`.length > 45
            ? `${artist} — ${title}`.slice(0, 45) + "…"
            : `${artist} — ${title}`

      const playing =
        player.playbackStatus === AstalMpris.PlaybackStatus.PLAYING

      return { label, playing }
    },
  )

  const label = info((i) => i.label)
  const playing = info((i) => i.playing)

  const cls = playing((p) => `media${p ? " playing" : " paused"}`)

  function handleClick() {
    const players = mpris.players
    if (players.length > 0 && players[0].canControl) {
      players[0].play_pause()
    }
  }

  return (
    <button class={cls} onClicked={handleClick}>
      <label label="▶" class="media-icon" />
      <label label={label} class="media-label" />
    </button>
  )
}
