# index.md (Action Branch Index)

**Type name:** action-index
**File:** `index.md`
**Location:** Branch nodes (nodes with children) in `action-tree/`
**Required:** No — only meaningful for branch nodes
**Created by:** Architect
**Maintained by:** Architect updates as children are added or completed

---

## Purpose

Maps a branch node's children — what sub-actions exist, what each one covers, and their current status. Follows the same pattern as the knowledge tree's index files: orient the reader and point them to the right child.

---

## Format

```markdown
# <Action Name> — Sub-actions

> Parent gatekeep: <one-line summary of this node's gatekeep>

| Sub-action | Gatekeep summary | Status |
|---|---|---|
| <name> | <one-line gatekeep> | Active / Achieved / Pending |
| <name> | <one-line gatekeep> | Active / Achieved / Pending |
```

---

## Notes

- Leaf nodes don't have an `index.md` — there's nothing to map.
- When a leaf grows into a branch (children added), create `index.md` at that point.
- See [action-tree.md](../action-tree.md) for how the tree grows organically.
