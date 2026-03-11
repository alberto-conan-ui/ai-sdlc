# KEY_INSIGHTS.md

**Type name:** key-insights
**File:** `KEY_INSIGHTS.md`
**Location:** Action nodes in `action-tree/`
**Required:** No — created when insights emerge during implementation
**Created by:** Any role (except Developer) during active work
**Maintained by:** All roles contribute; reviewed on action completion; Curator audits
**Engagement mode:** Working only. In Shaping, insights go directly to the knowledge tree — there is no need for the intermediate scratchpad.

---

## Purpose

Working scratchpad for insights that emerge during implementation. Patterns discovered, pitfalls encountered, decisions that might matter beyond this action. KEY_INSIGHTS.md exists because knowledge tree curation is not permitted in Working mode, so insights need a place to accumulate until the next Shaping session. When the action completes, anything worth keeping migrates to the appropriate knowledge tree node. KEY_INSIGHTS.md is temporary; the knowledge tree is permanent.

---

## When to Write

Write immediately when you encounter something during implementation that matters beyond the current session. Don't wait to see if it'll matter; write it and let review sort it out. The cost of writing a transient insight is low. The cost of losing a durable one is high.

---

## Lifecycle

1. **Write immediately** when the insight surfaces during Working mode.
2. **Review on action completion** — switch to Shaping. Everything still in KEY_INSIGHTS.md gets evaluated: keep (migrate to knowledge tree), discard (turned out to be transient), or revise (needs sharpening).
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

## Notes

- Insights must be prescriptive, not descriptive (see [knowledge-tree.md — Knowledge File Format](../knowledge-tree.md#knowledge-file-format) for examples and the full quality bar).
- The **Source** field links the insight back to where it was learned. This is what makes the Curator's audit possible. Every insight in the knowledge tree must be traceable to its origin.
- See [memory.md](../memory.md) for the broader memory model. See [journaling.md](../journaling.md) for how recording flows per engagement mode.
