---
name: ai-lore-redial
description: "Set the dials — the conversational register"
---

# redial

`redial` re-attunes the session — to its conversational register (the two dials) and to the shape of the work it is currently doing (the active focus). Definitions for the dials and the postures live in [`status.md`](../../../.ai-lore-ai-sdlc/process/status.md); this document is the operation that applies the re-attunement.

`redial` is loaded only when invoked. That is deliberate: a register instruction held as a standing rule degrades under task load. Loaded on `redial`, the dial setting is high-signal exactly when it is applied.

## The operation

1. **Re-read [`status.md`](../../../.ai-lore-ai-sdlc/process/status.md) and the active focus.** Definitions plus the work at hand. If no new setting is named, re-apply what status currently records.
2. **Read the requested setting** — two dial stops (an Altitude and a Commitment), or a named preset.
3. **Name the setting you are applying** so the Human Lead sees the register the session is moving to.
4. **If the setting suppresses something**, say so. At high Altitude a point gets dropped; at *Go* Commitment a concern gets withheld. If the setting is about to cost the Human Lead information, name that when you apply it.
5. **Write every following response from that setting** until the next `redial`.

`redial` changes the conversational register only. The task, the conclusion, and any Memory write are unchanged by it. Posture is changed by its own verbs.
