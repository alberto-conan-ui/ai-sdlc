# context.md (Action Context)

**Type name:** action-context
**File:** `context.md`
**Location:** Action nodes in `action-tree/`
**Required:** No — useful for complex actions that touch multiple areas; unnecessary for simple ones where the gatekeep says enough
**Created by:** Architect
**Maintained by:** Architect updates as scope evolves

---

## Purpose

Bridges the action tree (what you're doing) and the knowledge tree (what you know). When starting work on an action, the AI loads `context.md` to find which knowledge tree nodes are relevant. For complex work that touches authentication, API validation, and deployment patterns, context.md tells the AI where to look without loading the entire knowledge tree.

---

## Format

```markdown
# Context — <Action Name>

> Last updated: YYYY-MM-DD

## What This Is

<What this action is about. Brief — enough for someone starting a new session
to understand the work without reading everything else.>

## Knowledge

| Area | Node | Why it matters here |
|---|---|---|
| <area> | [{memory}/knowledge-tree/<path>/index.spec.md]({memory}/knowledge-tree/<path>/index.spec.md) | <how this knowledge applies> |

## Scope

<What's in scope and what's explicitly out of scope for this action.>
```

---

## Notes

- For simple actions (a single bug fix, a small feature), skip `context.md` entirely — the gatekeep says enough.
- The Knowledge table is the key value: it's a curated pointer set that saves the AI from guessing which knowledge to load.
- See [action-tree.md](../action-tree.md) for where `context.md` fits in the node structure.
