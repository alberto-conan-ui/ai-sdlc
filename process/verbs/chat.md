# chat

`chat` sets the session's posture to Chat. While in Chat, the session converses with the Human Lead and touches nothing — both the Payload and Memory are read-only.

## The operation

1. **If mounted on a track**, write `posture: chat` to the mounted track's record (`memory/tracks/<name>.track.md`) via [`write-lore`](./write-lore.md). The posture-write itself is the one Memory write Chat permits on the track; thereafter Memory is read-only too. Skip the write if the track already records `chat`.
2. **If trackless**, `chat` is a no-op — the session is already read-only across the project. The implicit posture *is* chat.
3. **Converse.** Answer, acknowledge, think out loud. Findings, decisions, and corrections that surface during the chat are held mentally for the next posture — not written.
4. **Refuse all writes** while in Chat. A request that would write the Payload or Memory is held until the Human Lead invokes [`execute`](./execute.md), [`reshape`](./reshape.md), or [`plan`](./plan.md). Those verbs, if invoked while trackless, trigger the [`mount`](./mount.md) flow before they can write the new posture.

The posture is the gate. Chat is for the moments where the Human Lead wants to think, vent, or align — without the session reaching for action.
