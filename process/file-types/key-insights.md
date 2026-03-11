# KEY_INSIGHTS.md

**Type name:** key-insights
**File:** `KEY_INSIGHTS.md`
**Location:** Action nodes in `action-tree/`
**Required:** No — created when insights emerge during the work
**Created by:** Any role (except Developer) during active work
**Maintained by:** All roles contribute; reviewed on action completion; Curator audits

---

## Purpose

Working scratchpad for insights that emerge during the work. Patterns discovered, pitfalls encountered, decisions that might matter beyond this action. When the action completes, anything worth keeping migrates to the appropriate knowledge tree node. KEY_INSIGHTS.md is temporary; the knowledge tree is permanent.

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

## Lifecycle

1. **Write immediately** when you encounter something that matters beyond the current session. Don't wait to see if it'll matter.
2. **Migrate early** if the insight is clearly about a specific codebase area and is durable — propose placing it in the knowledge tree. Human Lead confirms.
3. **Review on completion** — everything still in KEY_INSIGHTS.md gets evaluated: keep (migrate), discard (transient), or revise (needs sharpening).
4. **Discard is fine** — the scratchpad is for working. The action's `log.md` preserves historical context if needed.

---

## Notes

- Insights must be prescriptive, not descriptive. Bad: "Refactoring was hard." Good: "Before any refactor that moves code between modules, write automated tests that assert current behaviour."
- The **Source** field is what makes the Curator's audit possible.
- See [journaling.md — Key Insights](../journaling.md#key-insights) for the full lifecycle, placement rules, and how insights fit into the recording pipeline.
- See [memory.md](../memory.md) for the broader memory model.
