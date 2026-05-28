# plan

`plan` sets the session's posture to Planning. While in Planning, the session discusses and writes plans; the Payload is read-only. The plan itself lands in Memory — in the active focus body or under an action tree — through [`write-lore`](./write-lore.md).

## The operation

1. **Ensure a mounted track.** Writing the posture is itself a write — if the session is trackless, [`mount`](./mount.md) fires (auto-home if free, HL-prompted otherwise).
2. **Write the posture** — set `posture: plan` on the mounted track's record via [`write-lore`](./write-lore.md).
3. **Produce the plan** — phases, decomposition, the shape the work needs. The plan is Memory: the focus body for a short plan, an action tree for a decomposed one. The plan writes land within the mounted track's claim.
   - **If the plan creates a new focus**, propose a `claim` for the focus — derived from its title, area, and any references it touches — and ask the Human Lead to confirm or edit before writing the focus file. The claim is optional (omit if the area is exploratory or not yet pinned), but proposing one is the default: when the focus becomes active on home, the claim seeds home's working claim (see [`tracks.md`](../tracks.md#claims)).
4. **Refuse Payload writes** while Planning. A request to edit the Payload is held until the Human Lead invokes [`execute`](./execute.md).

The posture is the gate. Being in Planning is the standing permission to plan and the constraint that the Payload does not move yet.

## On engines with native plan modes

Some engines carry their own plan posture — Claude Code's `/plan` is one. The native posture may impose its own constraints, including an assigned plan-file path outside the project. **The plan itself still lands in Memory**, regardless of any harness-side plan-file assignment. If the engine routes a plan file outside the project, treat it as scratch — the Memory plan is authoritative.

For Claude Code specifically: invoke `/ai-lore-plan`, not Claude Code's native `/plan`, in an AI-Lore project. See [`bindings.md`](../bindings.md#plan-mode-collision) for the full collision note.
