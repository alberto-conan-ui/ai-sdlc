# execute

`execute` sets the session's posture to Executing. While in Executing, the session produces the Payload against the active focus and its gates.

Executing is the **default posture** — the value `init` writes on master at project creation, and the value a new child track defaults to unless the Human Lead chooses otherwise.

## The operation

1. **Ensure a mounted track.** Writing the posture is itself a write — if the session is trackless, [`mount`](./mount.md) fires (auto-master if free, HL-prompted otherwise).
2. **Write the posture** — set `posture: execute` on the mounted track's record via [`write-lore`](./write-lore.md). Skip the write if the track already records `execute`.
3. **Produce the Payload** against the focus and any phase gates, within the mounted track's claim. Record progress in Memory via `write-lore`.
4. **Stop** when the focus gate is met or the Human Lead names a different posture.

The posture is the gate. Executing lifts the Payload read-only rule that `plan` and `reshape` impose; the session can write the Payload because the posture says so.
