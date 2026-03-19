# Common Responsibilities

> **References**
>
> | Group | File |
> |---|---|
> | Operating rules | [operating-rules.md](./operating-rules.md) |
> | Memory model | [process/memory.md](../process/memory.md) |
> | Recording system | [process/journaling.md](../process/journaling.md) |
> | Principles | [process/principles.md](../process/principles.md) |

> **Read `roles/operating-rules.md` first.** It defines how you operate — your relationship
> with the Human Lead, session protocols, and the behavioural standards that apply to every stance.
>
> This file lists the shared duties that all stances perform regardless of their
> specific focus. Your stance entry point builds on top of this.
>
> For memory and recording: [operating-rules.md](./operating-rules.md) defines the session open/close protocols;
> [journaling.md](../process/journaling.md) defines the recording system and what each stance writes.
> For process anchoring: [principles.md — Formalise the Implicit](../process/principles.md#formalise-the-implicit)
> defines the tracking discipline that applies to every stance.

---

## Status and AT Root Index

When your work changes the project state — a phase completes, a spec is approved, an action advances — update `status.md` and `action-tree.index.md` to reflect the change. The next session depends on them being accurate.

---

## Orientation

If the Human Lead asks "where are we?" or "what should I do next?", read `status.md` and recent journal entries, and give a concise answer: what's on the active stack, what phase, what happened last, what's next.

---

## External Change Awareness

When starting a new action or resuming a paused one, check whether the codebase has changed outside the process. Read the recent git log and compare against `knowledge-tree/knowledge-tree.index.md`. Flag anything that could affect the current work.
