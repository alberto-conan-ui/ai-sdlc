# KEY_INSIGHTS.md

**Type name:** key-insights
**File:** `KEY_INSIGHTS.md`
**Location:** Action nodes in `action-tree/`
**Required:** No — created when insights emerge during implementation
**Created by:** Any role (except Developer) during active work
**Maintained by:** All roles contribute; reviewed on action completion; Curator audits
**Used by:** Tech Lead (implementation only). Design roles (Architect, Curator) write insights directly to the knowledge tree — there is no need for the intermediate scratchpad.

---

## Purpose

Working scratchpad for insights that emerge during implementation. Patterns discovered, pitfalls encountered, decisions that might matter beyond this action. KEY_INSIGHTS.md exists because the Tech Lead's focus is execution, not knowledge tree curation — insights need a place to accumulate until an Architect or Curator session reviews them. When the action completes, anything worth keeping migrates to the appropriate knowledge tree node. KEY_INSIGHTS.md is temporary; the knowledge tree is permanent.

---

## When to Write

Write immediately when you encounter something during implementation that matters beyond the current session. Don't wait to see if it'll matter; write it and let review sort it out. The cost of writing a transient insight is low. The cost of losing a durable one is high.

**KEY_INSIGHTS vs log.md:** If a future session working in the same area of the codebase would benefit from knowing this, it's an insight. If it's only relevant to understanding what happened in this session, it's a log entry.

---

## Lifecycle

1. **Write immediately** when the insight surfaces during implementation.
2. **Review on action completion** — in an Architect or Curator session, everything still in KEY_INSIGHTS.md gets evaluated: keep (migrate to knowledge tree), discard (turned out to be transient), or revise (needs sharpening).
3. **Discard is fine** — the scratchpad is for working. The action's `log.md` preserves historical context if needed.

### Where insights go

- Specific to this action's work → stays in `KEY_INSIGHTS.md` until completion review
- About a specific area of the codebase → knowledge tree node matching that area
- Cross-cutting, project-wide → `knowledge-tree/index.spec.md`

If you're unsure about placement, propose it and let the Human Lead confirm or redirect.

---

## Format

```markdown
# Key Insights — <Action Name>

## <Insight title — imperative, actionable>

**Context:** <the specific situation or pattern>
**Insight:** <what to do or avoid — prescriptive, not descriptive>
**Source:** journal/YYYY-WNN.md, YYYY-MM-DD (or action log reference)
```

---

## Real Example

From a real project — a monorepo action that moved a pipeline between libraries. Names anonymised.

```markdown
# Key Insights — move-pipeline-to-shared

## KT rules that name exceptions invite those exceptions

**Context:** The pass-through property rule stated "No aliases, no semantic
renaming" but then named a convenience type as a permitted exception. The
Tech Lead read the exception as the rule and wrote a prompt preserving
the convenience type with a mapping table — the exact pattern the rule
was meant to prevent.
**Insight:** When writing KT rules, don't illustrate exceptions by naming
the very thing you want eliminated. State the rule, state what the correct
pattern looks like, stop. Examples of the wrong approach validate that
approach in the reader's mind.
**Source:** log.md, 2026-03-12 (Tech Lead session)

## Subtype selectors are no-ops — the matching context strips the fields they need

**Context:** Precedence tests discovered that subtype selectors never match
any widget. Their matchers filter on `d.type === 'text'` (or 'number',
'boolean'), but the matching context only exposes `{ itemType, tags, uid }`
— the decorator's type field is absent during matching.
**Insight:** The matching context is deliberately minimal to avoid leaking
the full decorator. Any selector that needs to filter on decorator data
fields cannot work with the current architecture. This is a design gap,
not a simple bug fix — either the matching context needs selective
expansion, or subtype selectors need a different mechanism.
**Source:** Prompt 03 receipt, 2026-03-12 (Developer session)
```

The first insight is a process lesson (migrated to project-level KT). The second is a technical design gap (scoped out to a separate action, documented but not migrated — the gap is unresolved).

---

## Notes

- Insights must be prescriptive, not descriptive (see [knowledge-tree.md — Knowledge File Format](../knowledge-tree.md#knowledge-file-format) for examples and the full quality bar).
- The **Source** field links the insight back to where it was learned. This is what makes the Curator's audit possible. Every insight in the knowledge tree must be traceable to its origin.
- See [memory.md](../memory.md) for the broader memory model. See [journaling.md](../journaling.md) for how recording flows per role.
