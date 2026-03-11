# log.md (Action Log)

**Type name:** action-log
**File:** `log.md`
**Location:** Action nodes in `action-tree/` where work happens
**Required:** No — but expected for any action that spans more than one session
**Created by:** The role active during the session
**Maintained by:** All roles (except Developer) append entries

---

## Purpose

Session-by-session record of what happened while working on this action. What was done, what was decided, what surprised you. The log is the action's short-term memory — it tells the next session where the previous one left off.

Logs live at the nodes where work happens. The Human Lead and the active role look up the tree when broader context is needed.

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
- Detailed session history lives here, not in the journal. The journal captures what transcends individual actions.
- See [memory.md](../memory.md) for how the log fits into the memory pipeline.
