# Common Responsibilities

> Every AI role loads this file first. It defines the shared duties that all roles perform
> regardless of their specific stance. Your role entry point builds on top of this.

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

## Key Insights

When you produce or encounter something that matters beyond this session, write it directly to the appropriate `KEY_INSIGHTS.md` file. Don't flag it for someone else — write it yourself.

**Decide the level:**

- This will matter for the rest of this phase → **phase-level** `KEY_INSIGHTS.md`
- This applies across phases of this action → **action-level** `KEY_INSIGHTS.md`
- This applies across all actions in this project → **project-level** `KEY_INSIGHTS.md`

**Format:**

```markdown
## <Insight title — imperative, actionable>

**Context:** <the specific situation or pattern>
**Insight:** <what to do or avoid — prescriptive, not descriptive>
**Source:** journal/YYYY-WNN.md, YYYY-MM-DD
```

**When starting a session**, scan the KEY_INSIGHTS.md files relevant to your role's scope. If you spot an insight from a lower level that applies more broadly, promote it — copy it to the higher level with its source intact.

**The Human Lead reviews insights as they appear.** Write them, but expect the human to revise or remove ones that don't hold up.

---

## STATUS.md

When your work changes the project state — a phase completes, a mode transitions, a spec is approved — update `STATUS.md` to reflect the change. Keep it current. The next session (yours or someone else's) depends on it being accurate.

---

## Orientation

If the Human Lead asks "where are we?" or "what should I do next?", read `STATUS.md` and the recent journal, and give a concise answer: what mode, what action, what phase, what happened last, what's next. Any role can do this — it's not reserved for a specific role.
