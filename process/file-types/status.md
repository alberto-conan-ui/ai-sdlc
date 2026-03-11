# STATUS.md

**Type name:** status
**File:** `STATUS.md`
**Location:** `action-tree/STATUS.md`
**Required:** Yes — one per project
**Created by:** Bootstrapper (inception skeleton), then updated by all roles
**Maintained by:** Every role updates it; Navigator uses it for handoffs

---

## Purpose

Single source of truth for project orientation. Every role reads this first. It answers: what mode are we in, what's on the active stack, what's the shape of the action tree, and what does the roadmap look like for the current action.

---

## Sections

- **Current State** — mode (Inception / Planning / Implementation), active phase, active prompt, next step
- **Active Stack** — push/pop stack of actions currently being worked on
- **Action Tree** — full table of all actions with gatekeep summaries and status
- **Roadmap** — phase breakdown for the currently active action
- **Code Repository** — repo location and current branch

---

## Template — Inception (new project)

```markdown
# <Project Name> — Status

> Single source of truth. Every role reads this for orientation.

## Current State

| Field | Value |
|---|---|
| **Mode** | **INCEPTION** |
| **Next step** | Invoke the Architect to define the first action |

## Active Stack

*Empty — no active work.*

## Action Tree

*No actions defined yet.*

## Code Repository

**Location:** `{code}/`
**Branch:** `main`
```

## Template — Active project

See [templates.md](../templates.md) for the full active-project template with example data.

---

## Notes

- The Roadmap section only appears when there's an active action with phases.
- Status indicators for actions: `Active`, `Achieved`, `Paused`, `Pending`.
- The active stack uses `→` to mark the top (current focus).
