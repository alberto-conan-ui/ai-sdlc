# plan

`plan` sets the session's posture to Planning. While in Planning, the session discusses and writes plans; the Payload is read-only.

## The operation

1. **Write the posture to status** — set `posture: plan` in `status/status.index.md` via [`write-lore`](./write-lore.md).
2. **Produce the plan** — phases, gates, the decomposition the work needs. The plan itself is Memory; write it through `write-lore` into the focus or action tree, depending on size.
3. **Refuse Payload writes** while Planning. A request to edit the Payload is held until the Human Lead invokes [`execute`](./execute.md).

The posture is the gate. The session does not ask permission turn by turn — being in Planning is the standing permission to plan and the constraint that the Payload does not move yet.

When the engine carries a native plan posture (Claude Code's Plan mode, for example), `plan` uses it — the verb names the posture and the engine enforces it where it can.
