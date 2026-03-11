# *.spec.md (Knowledge Spec)

**Type name:** knowledge-spec
**File:** `<name>.spec.md`
**Location:** Any node in `knowledge-tree/` alongside its `index.spec.md`
**Required:** No — created when a concern accumulates enough knowledge to warrant its own file
**Created by:** Any role proposing insights; Human Lead approves placement
**Maintained by:** All roles contribute; Curator audits

---

## Purpose

Deep knowledge about a specific concern within an area. When `index.spec.md` is getting long or mixing concerns, the detail moves to a dedicated spec file. The index then maps to it.

Examples: `session-handling.spec.md` under `auth/`, `validation.spec.md` under `api/`, `event-schema.spec.md` under `shared/`.

---

## Format

Open format. The content should be actionable and sourced. Each insight follows:

```markdown
# <Topic>

> Last updated: YYYY-MM-DD

## <Insight title — imperative, actionable>

**Context:** <The specific situation or pattern.>
**Insight:** <What to do or avoid — prescriptive, not descriptive.>
**Source:** <action log or journal reference for full context>

## <Another insight>

...
```

---

## Notes

- Insights must be prescriptive, not descriptive (see [knowledge-tree.md — Knowledge File Format](../knowledge-tree.md#knowledge-file-format) for examples and the full quality bar).
- The **Source** field makes the Curator's audit possible — every insight is traceable.
- Splitting is healthy: when a concern outgrows the index, give it its own `.spec.md`.
- Retirement is also healthy: when an insight no longer applies, remove it. The journal and archive preserve the historical context.
- See [knowledge-tree.md](../knowledge-tree.md) for the full guide on what belongs at each level.
