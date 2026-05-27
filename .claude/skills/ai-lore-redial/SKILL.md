---
name: ai-lore-redial
description: "Set the dials — the conversational register"
---

# redial

`redial` re-attunes the session — to its conversational register (the two dials) and to the shape of the work it is currently doing. The verb is loaded only when invoked; this is deliberate, because a register instruction held as a standing rule degrades under task load. Loaded on `redial`, the dial setting is high-signal exactly when it is applied. Definitions for the dials and the postures live in [`status.md`](../status.md); this document is the operation that applies the re-attunement.

## What redial does

- **Re-reads [`status.md`](../status.md), the mounted track's record, and the active focus** so the register applies to the work as it actually is, not as the session remembers it from earlier turns.
- **Applies the requested setting** — two dial stops (an Altitude and a Commitment), or a named preset. If no new setting is named, re-applies what the mounted track's record currently carries.
- **Writes the new dials** to the mounted track's record via [`write-lore`](./write-lore.md). The change persists for any session that later mounts the same track.
- **Names the setting** so the Human Lead sees the register the session is moving to.
- **Names what the setting suppresses.** At high Altitude a point gets dropped; at *Go* Commitment a concern gets withheld. If the setting is about to cost the Human Lead information, that cost is named when the setting is applied.

Every following response writes from that setting until the next `redial`.

## Trackless redial

While trackless, the session has no track record to write to. `redial` still re-attunes the session in-conversation — the dials apply to subsequent responses — but the change is **volatile**: nothing is persisted anywhere, and the next mount picks up the mounted track's saved dials, not the trackless session's adjustments.

This is the only verb that runs meaningfully while trackless without triggering [`mount`](./mount.md). Redial is a conversation-shaping operation; without a track, there is nothing for it to persist.

`redial` changes the conversational register only. The task, the conclusion, and any Memory write are unchanged by it. Posture is changed by its own verbs.
