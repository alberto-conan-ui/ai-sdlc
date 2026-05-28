# Status

The live register: where the project stands, what each track is working on, and how each track is dialed. Status is the project's orientation hub — the entry point every session reads first — and the registry that surfaces every open track at a glance.

This pillar covers the dashboard layer: status as the registry, the focus that sits under a track, the focus chain from the mounted track down to whatever node is active, and the conversational register (dials, posture, presets). The workspace primitive underneath — tracks themselves, mounting, claims — lives in [`tracks.md`](./tracks.md). The git arrangement those tracks branch on lives in [`git.md`](./git.md). The persistent record — journal, blueprint, save-points, action tree, knowledge tree — lives in [`memory.md`](./memory.md).

## Status — the registry

Lives at `memory/status/status.index.md`. Status is the project's **summary registry**, not itself a focus node — its job is to surface what is open and where things stand. It carries:

- **Open tracks** — the list of tracks currently registered, each with branch, claim summary, focus pointer, posture, dials, and mounted-by (session ID or empty). Pointers; the full record for each track lives at `memory/tracks/<name>.track.md`. See [`tracks.md`](./tracks.md).
- **Save-points pointer** — to the ledger at `memory/save-points/`.
- **Blueprint pointer** — to `memory/blueprint/`.
- **Journal trail** — newest-first across all tracks. Each entry is a one-line pointer; the full per-session journal lives in `memory/journal/live/`.
- **Drift summary** — per-track ("home clean, v06-tracks 3 uncommitted") at the last orient check. See [`git.md`](./git.md#the-drift-signal) for the mechanics.
- **Children** — pointers to subfolders (focus, tracks, journal, blueprint, save-points, …).

Status orients a session in seconds. Every session reads it at [`orient`](./verbs/orient.md). The session itself starts **trackless** — it inspects status to learn the landscape, and mounts a track only when it is about to write.

In v0.5.1 and earlier, status carried `active_focus`, `posture`, and `dials` in its frontmatter — the live register for the single session the methodology assumed. v0.6 moves those onto per-track records so multiple tracks can each carry their own live state and the registry stays a pure dashboard.

## Focus

A **focus** is one unit of intent. One file per focus at `memory/status/focus/<name>.md`. Every focus declares its **`focus_type`**:

- **`build`** — concrete delivery against an evaluable gate. The Human Lead checks the gate; the session may move to `Review` but never to `Done`.
- **`goal`** — directional work against a subjective target. The Human Lead claims done by judgement; the session's job is to deliver *and* offer an opinionated critique alongside the work.

A `build` carries a list of gate conditions; a `goal` carries a vision the work aims at. Both carry context, stack, active child pointer, and journal trail.

A focus too large to track in one file grows an action tree — the focus file stays the head, the action tree decomposes it. The action tree itself is documented in [`memory.md`](./memory.md).

A track may point at a focus to declare what work it is doing in that workspace. The focus and the track are decoupled: focuses can exist without tracks (dormant), and tracks can exist without focuses (exploratory). See [`tracks.md`](./tracks.md) for how track and focus relate.

## Focus tracking

Tracks and action-tree nodes are **focus nodes** — each tracks the project's focus at a given depth (a track at the top, action-tree nodes deeper). Every focus node carries four fields:

- **Stack** — ordered children, top is active.
- **Active child pointer** — which child is currently being worked.
- **Journal trail** — one-line entries pointing to relevant journal sessions.
- **Gate** — the concrete, evaluable definition of done (for a `build`).

**The chain.** The focus chain *is* the orientation chain. When a session is mounted on a track, the chain starts at the track's focus pointer and walks down through the action tree if one exists, until there is nothing below. Each node adds exactly one thing the parent does not already say. No node repeats its parent.

**Gates and review.** A session may move a focus node up to `Review`; only the Human Lead moves it past `Review` to `Done` (ungated) or `Achieved` (gated). This is where human accountability lives at the focus level.

## The two dials

**Altitude** — how lean the talk is. Three stops:

- *Low* — detailed, shows the work.
- *Mid* — balanced.
- *High* — headline only, plain words.

**Commitment** — how hard the session pushes. Three stops:

- *Go* — just do it.
- *Neutral* — even-handed.
- *Challenge* — push hard.

Dials live on the mounted track's record and persist across sessions that remount the same track. Trackless sessions have no track record to write to — the dials may still be adjusted, but the change is volatile and does not survive the session.

## Posture

The posture is one of four values, each a real constraint — not a label.

| Posture | Activity | Payload | Memory |
|---|---|---|---|
| **Chat** | Converse — think, vent, align. | Read-only. | Read-only for substance; **marginalia** allowed (see [`chat.md`](./verbs/chat.md#marginalia--the-chat-carve-out)). |
| **Plan** | Discuss and write plans. | Read-only. | Writes confined to the plan itself (focus, action tree). |
| **Reshape** | Work on Memory — restructure, rewrite, consolidate. | Read-only. | Full Memory work through `write-lore`. |
| **Execute** | Produce the Payload against the active focus. | Read–write. | Progress writes through `write-lore`. |

The posture verbs — [`chat`](./verbs/chat.md), [`plan`](./verbs/plan.md), [`reshape`](./verbs/reshape.md), [`execute`](./verbs/execute.md) — write this field to the **mounted track's record**. Each verb is deliberately light: write the field, continue. A request that would violate the current posture (a Payload edit while Planning, for example) is refused until the posture changes.

**Marginalia is the one carve-out**, and it only applies under Chat: a narrow allow-list of HL-initiated Memory operations that are housekeeping rather than composition — frontmatter edits, link repair, single-token typo fixes, index entries. The full definition lives in [`chat.md`](./verbs/chat.md#marginalia--the-chat-carve-out). The litmus: *if removing the change wouldn't shift what the file means to a future reader, it's marginalia*. Anything that changes meaning needs `plan`, `reshape`, or `execute`. The Payload's read-only rule under non-execute postures is absolute — there is no Payload marginalia.

**Execute is the default** — the value `init` writes on the home track at project creation.

**Trackless implies chat.** A session with no mounted track is read-only across the project, equivalent to chat. Invoking the `chat` verb while trackless is a no-op (no record to write to, no behavior to change). Invoking `plan`, `reshape`, or `execute` while trackless triggers the [`mount`](./verbs/mount.md) flow — those are writes (they set posture on a track record), and the mount-on-first-write rule applies.

In Publishing projects, `publish/` sits outside the posture table — it is off-limits to every posture, written only by the [`publish`](./verbs/publish.md) verb. See [Publish](./project-structure.md#publish).

## Scope — and an honest limit

Dials shape the **conversation**, not what the session does. Same task, same conclusion, same Memory write — only the talk around them changes.

That holds across the middle of each range. It strains at the extremes: at maximum Altitude the session does not just shorten — it *drops* the lower-ranked point. At *Go* Commitment it does not just soften — it *withholds* a concern it would otherwise raise. The dials are a register control, not a free cosmetic layer; the high-Altitude / Go corner costs the Human Lead information, not only words. Set them there deliberately.

Posture, by contrast, is action-constraining by design — it does not only shape talk; it determines what the session is permitted to touch. The claim is action-constraining too, but at the **path** level rather than the verb level — it determines *where* the session is permitted to write. See [`tracks.md`](./tracks.md#claims).

## Presets

A preset is a **named, saved dial combination** — nothing more. A shortcut for a setting the Human Lead reaches for often, not an identity.

Presets are deliberately **thin and few**, with flat names. AI-Lore does not ship a grid of persona presets ("CEO", "Auditor", and the like). A persona name drags behavioural baggage in — the reader, and the session, infer decisiveness or suspicion from the label — which re-couples behaviour to the preset. Presets name dial coordinates, not roles.

Presets cover dials only. Posture is set independently by its own verbs.

## Setting — redial

The dials are set by the [`redial`](./verbs/redial.md) verb. `redial` is loaded only when invoked — its content does not ride along as a standing instruction from session start. On invocation it re-reads this document and the mounted track's focus, then re-attunes the session both to its declared dials and to the shape of the work it is doing right now. The new dials are written to the mounted track's record.

While trackless, `redial` operates without a record — the dial change applies to the session in-memory but is not persisted anywhere. The next time a track is mounted, the track's saved dials apply, not the volatile in-memory ones.

This loading discipline is deliberate. A register instruction held as a standing rule degrades under task load. Loaded on `redial`, the setting is high-signal exactly when it is applied. The dials work because of *when* they load, not merely because they exist.
