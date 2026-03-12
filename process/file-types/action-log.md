# log.md (Action Log)

**Type name:** action-log
**File:** `log.md`
**Location:** Action nodes in `action-tree/` where work happens
**Required:** No — but expected for any action that spans more than one session
**Created by:** The role active during the session
**Maintained by:** All roles (except Developer) append entries
**Used by:** All roles (except Developer) — design decisions and exploration notes in design sessions, implementation progress in Tech Lead sessions

---

## Purpose

Session-by-session record of what happened while working on this action. What was done, what was decided, what surprised you. The log is the action's short-term memory — it tells the next session where the previous one left off.

Logs live at the nodes where work happens. The Human Lead and the active role look up the tree when broader context is needed.

---

## When to Write

Write a log entry at the end of every session that touches this action. No exceptions, no minimum threshold — if you worked on the action, log what happened.

### What belongs here vs. elsewhere

The log captures what happened within this action's scope. If something transcends this action — a decision that affects the whole project, a pattern noticed across multiple actions — it goes in the [journal](./journal-entry.md), not here. During implementation, if something was learned that might matter beyond this action, it goes in [KEY_INSIGHTS.md](./key-insights.md) alongside the log entry. In design sessions (Architect, Curator), durable insights go directly to the knowledge tree.

---

## Format

```markdown
# Log — <Action Name>

---

## YYYY-MM-DD — <Role>

<One-line summary: what was accomplished.>

**Detail:** *(optional — include for complex sessions, skip for simple ones)*
- **Phase:** N — <name>
- **Files touched:** <paths>
- **Open threads:** <anything pending>
- **Next:** <what to pick up next session>

---

## YYYY-MM-DD — <Role>

...
```

---

## Notes

- Entries are appended chronologically — never edited after the session ends (append-forward principle).
- Keep entries concise. The log is a trail, not a report.
- The Developer doesn't write log entries — its session receipt serves as its contribution.
- See [memory.md](../memory.md) for the broader memory model. See [journaling.md](../journaling.md) for how recording flows per role.
