# YYYY-WNN.md (Journal Entry)

**Type name:** journal-entry
**File:** `YYYY-WNN.md` (e.g., `2026-W10.md`)
**Location:** `journal/`
**Required:** No — created when cross-cutting annotations arise
**Created by:** Any role (except Developer)
**Maintained by:** Append-only; Curator uses it as primary audit input

---

## Purpose

Captures cross-cutting annotations — project-level decisions, observations spanning multiple actions, and process changes. The journal sits between the action tree and the knowledge tree and serves as both a bridge (capturing what transcends individual actions) and an audit trail (letting the Curator verify the memory pipeline).

Weekly rolling files keep it manageable. Detailed session history lives in each action's `log.md`, not here.

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

## Notes

- Files are named by ISO week: `YYYY-WNN.md`.
- Entries are never edited or deleted (append-forward principle).
- The journal is the Curator's primary audit input. If the journal says a decision was made but the knowledge tree doesn't reflect it, something was missed.
- See [memory.md](../memory.md) for the journal's role in the memory pipeline.
