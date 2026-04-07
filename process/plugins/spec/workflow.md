# spec Plugin — Workflow

> **Joins:** [workflow.md](../../workflow.md) — Addendum: load core workflow first (focus, modes, stack, headless, checkpoints), then layer this file for the spec work cycle.
>
> **References**
>
> | Group | File |
> |---|---|
> | Core workflow | [workflow.md](../../workflow.md) |
> | spec stances | [roles.md](./roles.md) |

Core workflow defines focus, modes, the focus stack, headless, and checkpoints. This adds the spec-specific work cycle: think → edit → commit, with no formal design/implementation split.

---

## The Work Cycle

```
Think ──→ Edit ──→ Commit ──→ Evaluate
  ▲                               │
  └───────────────────────────────┘
```

**Think.** Shape the change — what needs to happen, why, what the implications are. This is the Editor's strategic thinking or the Strategist's evaluation. Often brief — a few exchanges before editing begins.

**Edit.** Make the change directly. Process docs, knowledge tree nodes, action tree structure, README, whatever the work requires. No prompts, no receipts, no formal spec. The domain is prose and structure — direct editing is the natural mode.

**Commit.** Write to files, update status, journal the change. Append-forward applies — new versions, not silent edits.

**Evaluate.** Does the change serve the goal? The Human Lead reviews. If something's off, cycle back to Think.

The cycle is compressed compared to SDLC. There's no formal phase spec, no separate design artifact. The Editor thinks and edits fluidly; the distinction is cognitive, not procedural.

---

## Strategist Sessions

When the Strategist is loaded, the cycle changes character:

- **Think** becomes *evaluate* — reading docs, positioning, competitive landscape
- **Edit** is suspended — the Strategist doesn't modify files
- **Commit** becomes *deliver verdict* — an audit document written to the KT
- **Evaluate** becomes *defend* — the Human Lead challenges, the Strategist holds or revises

The Strategist produces assessments, not changes. The Editor acts on them afterward.

---

## Session Boundaries

Single sessions are the default. The Editor handles everything in one conversation. Separate sessions are the escalation path for dedicated Strategist assessments where the evaluation context shouldn't be polluted by execution context.
