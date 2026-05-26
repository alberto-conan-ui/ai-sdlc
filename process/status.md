# Status

The live register: where the session is, what it is working on, and how it is dialed. Status is the project's orientation hub — the entry point every session reads first — and it carries the working register the session operates from across every turn.

This pillar covers the live state: status itself, the focus that sits under it, the dials and posture status carries, and the focus chain that traverses from status down to whatever node is active. The persistent record — journal, blueprint, save-points, action tree, knowledge tree — lives in [`memory.md`](./memory.md).

## Status — the entry point

Lives at `memory/status/status.index.md`. A thin focus node carrying:

- The active focus (a pointer into `memory/status/focus/`)
- The focus stack (paused focuses, top is active)
- The journal trail
- The current dials and posture

Status orients a session in seconds. Every session reads it at [`orient`](./verbs/orient.md) and operates within it.

## Focus

A **focus** is one unit of intent. One file per focus at `memory/status/focus/<name>.md`. Every focus declares its **`focus_type`**:

- **`build`** — concrete delivery against an evaluable gate. The Human Lead checks the gate; the session may move to `Review` but never to `Done`.
- **`goal`** — directional work against a subjective target. The Human Lead claims done by judgement; the session's job is to deliver *and* offer an opinionated critique alongside the work.

A `build` carries a list of gate conditions; a `goal` carries a vision the work aims at. Both carry context, stack, active child pointer, and journal trail.

A focus too large to track in one file grows an action tree — the focus file stays the head, the action tree decomposes it. The action tree itself is documented in [`memory.md`](./memory.md).

## Focus tracking

Status, the active focus, and action-tree nodes are all **focus nodes** — each tracks the project's focus at a given depth. Every focus node carries four fields:

- **Stack** — ordered children, top is active.
- **Active child pointer** — which child is currently being worked.
- **Journal trail** — one-line entries pointing to relevant journal sessions.
- **Gate** — the concrete, evaluable definition of done (for a `build`).

**The chain.** The focus chain *is* the orientation chain. A session starts at `memory/status/status.index.md`, follows the active focus pointer down through the action tree if one exists, until there is nothing below. Each node adds exactly one thing the parent does not already say. No node repeats its parent.

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

## Posture

The posture is one of four values, each a real constraint — not a label.

| Posture | Activity | Payload | Memory |
|---|---|---|---|
| **Chat** | Converse — think, vent, align. | Read-only. | Read-only (after the posture-write itself). |
| **Plan** | Discuss and write plans. | Read-only. | Writes confined to the plan itself (focus, action tree). |
| **Reshape** | Work on Memory — restructure, rewrite, consolidate. | Read-only. | Full Memory work through `write-lore`. |
| **Execute** | Produce the Payload against the active focus. | Read–write. | Progress writes through `write-lore`. |

The posture verbs — [`chat`](./verbs/chat.md), [`plan`](./verbs/plan.md), [`reshape`](./verbs/reshape.md), [`execute`](./verbs/execute.md) — write this field. Each is deliberately light: write the field, continue. A request that would violate the current posture (a Payload edit while Planning, for example) is refused until the posture changes.

**Execute is the default** — the value `init` writes when the project is created.

## Scope — and an honest limit

Dials shape the **conversation**, not what the session does. Same task, same conclusion, same Memory write — only the talk around them changes.

That holds across the middle of each range. It strains at the extremes: at maximum Altitude the session does not just shorten — it *drops* the lower-ranked point. At *Go* Commitment it does not just soften — it *withholds* a concern it would otherwise raise. The dials are a register control, not a free cosmetic layer; the high-Altitude / Go corner costs the Human Lead information, not only words. Set them there deliberately.

Posture, by contrast, is action-constraining by design — it does not only shape talk; it determines what the session is permitted to touch.

## Presets

A preset is a **named, saved dial combination** — nothing more. A shortcut for a setting the Human Lead reaches for often, not an identity.

Presets are deliberately **thin and few**, with flat names. AI-Lore does not ship a grid of persona presets ("CEO", "Auditor", and the like). A persona name drags behavioural baggage in — the reader, and the session, infer decisiveness or suspicion from the label — which re-couples behaviour to the preset. Presets name dial coordinates, not roles.

Presets cover dials only. Posture is set independently by its own verbs.

## Setting — redial

The dials are set by the [`redial`](./verbs/redial.md) verb. `redial` is loaded only when invoked — its content does not ride along as a standing instruction from session start. On invocation it re-reads this document and the active focus, then re-attunes the session both to its declared dials and to the shape of the work it is doing right now.

This is deliberate. A register instruction held as a standing rule degrades under task load. Loaded on `redial`, the setting is high-signal exactly when it is applied. The dials work because of *when* they load, not merely because they exist.
