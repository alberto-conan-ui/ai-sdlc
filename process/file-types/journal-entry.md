# YYYY-WNN.md (Journal Entry)

**Type name:** journal-entry
**File:** `YYYY-WNN.md` (e.g., `2026-W10.md`)
**Location:** `journal/`
**Required:** No — created when cross-cutting annotations arise
**Created by:** Any role (except Developer)
**Maintained by:** Append-only; Curator uses it as primary audit input
**Used by:** Design roles (primary output), implementation roles (exception path — only when something genuinely cross-cutting surfaces)

---

## Purpose

Captures cross-cutting annotations — project-level decisions, observations spanning multiple actions, and process changes. The journal sits between the action tree and the knowledge tree and serves as both a bridge (capturing what transcends individual actions) and an audit trail (letting the Curator verify the memory pipeline).

Weekly rolling files keep it manageable. Detailed session history lives in each action's `log.md`, not here.

---

## When to Write

Write a journal entry when you make or encounter something that crosses action boundaries:

- A non-trivial project-level decision (e.g., choosing a new dependency, changing an architectural pattern)
- An observation that spans multiple actions (e.g., a recurring issue across different areas)
- A process change (e.g., adjusting how phases are structured, updating tooling)

If it's scoped to the current action, it belongs in the [action log](./action-log.md). If it transcends any single action, it belongs here.

During implementation, journal entries should be rare. If you're writing frequent journal entries while implementing, you may be doing design work that belongs in an Architect session.

---

## Entry Types

- `[decision]` — a non-trivial project-level choice with context and reasoning
- `[observation]` — cross-cutting patterns, recurring issues, something worth tracking
- `[process]` — changes to how the team works, tooling updates, methodology adjustments

---

## Format

```markdown
# Journal — Week of YYYY-MM-DD

---

## YYYY-MM-DD — <Role> [decision]

<What was decided.>

**Context:** <What prompted this decision.>
**Reason:** <Why this option was chosen.>

---

## YYYY-MM-DD — <Role> [observation]

<What was noticed — cross-cutting pattern, recurring issue, something worth tracking.>

**Actions affected:** <which action nodes this touches>
**Implication:** <what this means for future work>

---

## YYYY-MM-DD — [process]

<What changed in how we work.>

**Reason:** <Why the change was made.>
```

---

## Real Example

The following entries are from a single week on a real monorepo project. Names and specifics have been anonymised. Note the range: a design rule established after discovering a type conflict, a process improvement born from a CI failure, and a lesson about how knowledge tree rules should be written.

```markdown
# Journal — Week of 2026-03-09

---

## 2026-03-12 — Architect [decision]

Pass-through property rule established for the abstraction layer: shortcut
factories and decorator types must use the same value space as downstream
widget props. No aliases at the type level. Convenience names (like
`'vertical'`) are permitted as function parameters but must be mapped to
the real prop value inside the factory.

**Context:** During `move-layer-to-shared` implementation, discovered
that `LayoutDecorator extends Partial<LayoutProps>` was inheriting a
`direction` field that expected CSS values (`'row' | 'column'`), but the
shortcut code was passing `'vertical'` / `'horizontal'` straight through.
The mismatch was hidden by branch isolation.
**Reason:** The abstraction layer is a convenience layer, not an
abstraction boundary. If it invents its own vocabulary for pass-through
properties, every upstream type change becomes a silent breakage.

---

## 2026-03-12 — Architect [process]

Post-merge type verification added to project workflow: after every merge
of `main` into a feature branch, run `npx tsc --noEmit` against
downstream app tsconfigs. The solution-style `tsconfig.json` does not
catch cross-project type mismatches.

**Reason:** A merge of `main` into a feature branch introduced 4 type
errors from a prop type narrowing. No CI or local check caught them
because the solution-style tsc skips cross-project boundaries. The
app-level tsconfig is the only one that catches these.

---

## 2026-03-12 — Tech Lead [process]

Knowledge tree rules must not illustrate prohibited patterns by naming
them as exceptions. During implementation, a rule stated "No aliases" but
parenthetically cited a convenience type as a permitted exception. The
Tech Lead read the parenthetical as endorsement and wrote a prompt
preserving the convenience type with a mapping table — the exact pattern
the rule intended to prevent. Three iterations were needed before Human
Lead escalation resolved the ambiguity.

**Reason:** When a KT rule names a specific exception, readers anchor on
the exception rather than the rule. The fix was to remove the
parenthetical, restate the rule without naming what it prohibits, and
show only the correct pattern. This applies to all future KT authoring —
state the rule, show the right way, stop.
```

**Typical cadence:** A week of active work across design and implementation might produce 3-5 entries. Quiet weeks might produce none. If you're writing more than 2 entries per day, some of them probably belong in the action log instead.

---

## Naming

Files are named by ISO week: `YYYY-WNN.md`. One file per week, multiple entries per file.

---

## Notes

- Entries are never edited or deleted (append-forward principle).
- The journal is the Curator's primary audit input. If the journal says a decision was made but the knowledge tree doesn't reflect it, something was missed.
- See [memory.md](../memory.md) for the broader memory model. See [journaling.md](../journaling.md) for how recording flows per role.
