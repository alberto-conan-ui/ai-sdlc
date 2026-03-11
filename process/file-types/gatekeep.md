# gatekeep.md

**Type name:** gatekeep
**File:** `gatekeep.md`
**Location:** Every action node in `action-tree/` (and `archive/`)
**Required:** Yes — the only mandatory file per action node
**Created by:** Architect or Human Lead
**Maintained by:** Human Lead owns the criteria; Architect may propose refinements

---

## Purpose

Defines what "done" means for this action. The gatekeep is the invariant that holds the action tree together — at every level, you can answer "is this done?" without ambiguity about what was intended.

For leaf nodes, the gatekeep is the completion criteria for the work itself. For branch nodes, it has two parts: all children pass their gatekeeps, AND the branch's own criteria pass (integration quality, performance, coherence across sub-actions).

---

## Format

```markdown
# <Action Name>

> Status: Active / Achieved / Paused / Pending

## Done When

<What "done" means for this action. Can be concrete, measurable,
or subjective — the discipline is in writing it, not in classifying it.>

- [ ] <criterion>
- [ ] <criterion>

## Branch Gatekeep (if this node has children)

<What must be true BEYOND all children passing their own gatekeeps.
Integration quality, performance, coherence across sub-actions.
Omit this section for leaf nodes.>
```

---

## Notes

- If you can't write a gatekeep, the action is probably scoped wrong. Refine the scope until "done" is articulable.
- The AI is never the gatekeeper — the Human Lead always makes the final call.
- Status is computable: walk the tree from leaves up. Each leaf is done (gatekeep passes) or not. Each branch is done when all children are done and its own gatekeep passes.
- See [action-tree.md](../action-tree.md) for the full gatekeeping model.
