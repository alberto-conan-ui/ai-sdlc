# Common Responsibilities

> **Read `roles/principles.md` first.** It defines how you operate — your relationship
> with the Human Lead and the behavioural standards that apply to every role.
>
> This file defines the shared duties that all roles perform regardless of their
> specific stance. Your role entry point builds on top of this.

---

## Journal

You write journal entries as part of your normal output. Every session, every non-trivial decision, every lesson learned — logged in the current week's journal file (`journal/YYYY-WNN.md`).

**Entry types — tag every entry:**

- `[session]` — what happened in this session (always produce at least one)
- `[decision]` — a non-trivial decision with context and reasoning
- `[lesson]` — something learned the hard way, stated prescriptively

**Format:**

```markdown
## YYYY-MM-DD — <Your Role> [type]

<What happened / what was decided / what was learned.>

**Context:** <situation or background>
**Detail:** <reasoning, files touched, open threads — as needed>
```

Keep entries concise. The journal is a log, not a report.

---

## Knowledge

When you produce or encounter something that matters beyond this session, propose it for the knowledge tree or the current action's `KEY_INSIGHTS.md` scratchpad.

**Decide where it belongs:**

- Specific to this action's work → **action-level** `KEY_INSIGHTS.md` (working scratchpad — migrates to the knowledge tree when the action completes)
- About a specific area of the codebase → **knowledge tree** node matching that area (e.g., `knowledge/auth/index.md`)
- Cross-cutting, project-wide → **knowledge tree** root `knowledge/index.md`

Write the insight directly. If you're unsure about placement, propose it and let the Human Lead confirm or redirect.

**Format:**

```markdown
## <Insight title — imperative, actionable>

**Context:** <the specific situation or pattern>
**Insight:** <what to do or avoid — prescriptive, not descriptive>
**Source:** journal/YYYY-WNN.md, YYYY-MM-DD
```

**When starting a session**, read `CONTEXT.md` to identify relevant knowledge tree nodes and load them. If you spot an insight in the action scratchpad that belongs in the knowledge tree, propose the migration.

**The Human Lead reviews knowledge contributions as they appear.** Write them, but expect the human to revise, move, or remove ones that don't hold up.

---

## STATUS.md

When your work changes the project state — a phase completes, a mode transitions, a spec is approved — update `STATUS.md` to reflect the change. Keep it current. The next session (yours or someone else's) depends on it being accurate.

---

## Orientation

If the Human Lead asks "where are we?" or "what should I do next?", read `STATUS.md` and the recent journal, and give a concise answer: what mode, what action, what phase, what happened last, what's next. Any role can do this — it's not reserved for a specific role.
