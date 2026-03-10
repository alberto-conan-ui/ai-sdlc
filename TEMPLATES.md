# AI-SDLC: File Templates & Conventions

> Reference for the project journal structure. Each project gets its own journal repo following these templates.

---

## Project Journal Structure

```
my-project-journal/
├── STATUS.md                      ← Where are we now + roadmap (single source of truth)
├── KEY_INSIGHTS.md                ← Project-level insights (curated, universal to this project)
├── CONTEXT.md                     ← Codebase reference (repo structure, key files, patterns)
├── journal/                       ← Raw chronological log (weekly rolling files)
│   ├── 2026-W10.md
│   ├── 2026-W11.md
│   └── ...
│
└── actions/
    ├── task-fix-login-bug/
    │   ├── TASK.md                ← Lightweight: problem + done-when
    │   ├── KEY_INSIGHTS.md        ← Action-level insights (if any emerge)
    │   └── phases/
    │       └── 1-fix/
    │           ├── SPEC.md
    │           ├── KEY_INSIGHTS.md
    │           └── impl/
    │               └── 01-fix-redirect.md
    │
    ├── epic-refactor-validation/
    │   ├── EPIC.md                ← Problem + vision + concrete gatekeep
    │   ├── KEY_INSIGHTS.md        ← Action-level insights
    │   └── phases/
    │       ├── 1-baseline-tests/
    │       │   ├── SPEC.md
    │       │   ├── KEY_INSIGHTS.md
    │       │   └── impl/
    │       │       ├── PLAN.md
    │       │       ├── 01-test-infrastructure.md
    │       │       └── 02-assertion-coverage.md
    │       └── 2-lookup-table/
    │           ├── SPEC.md
    │           └── impl/
    │
    └── goal-plugin-architecture/
        ├── GOAL.md                ← Problem + vision + principles + abstract gatekeep
        ├── KEY_INSIGHTS.md        ← Action-level insights
        └── phases/
            └── ...                ← Same structure as epic
```

One structure for all projects. The tier prefix (`task-`, `epic-`, `goal-`) makes the action type visible at a glance without opening any files.

---

## File Purposes and Update Cadence

### Project-level files

| File | Purpose | Updated |
|---|---|---|
| `STATUS.md` | Single source of truth: mode, active action, active phase, next action, roadmap | Every session |
| `KEY_INSIGHTS.md` | Curated insights applicable across all actions — promoted from journal entries | When insights are identified or become obsolete |
| `CONTEXT.md` | Codebase reference: repo structure, key files, patterns | When code structure changes |
| `journal/` | Raw chronological log: sessions, decisions, lessons — everything that happens | Every session (current week's file) |

### Action-level files

| File | Purpose | Created |
|---|---|---|
| `TASK.md` | Task definition: problem statement, done-when criteria | When creating a task |
| `EPIC.md` | Epic definition: problem, vision, concrete gatekeep | When creating an epic |
| `GOAL.md` | Goal definition: problem, vision, design principles, abstract gatekeep | When creating a goal |
| `KEY_INSIGHTS.md` | Curated insights applicable across all phases of this action | When insights are identified |

### Phase-level files

| File | Purpose | Created |
|---|---|---|
| `SPEC.md` | Phase plan: steps, test cases, done criteria | Before phase begins |
| `KEY_INSIGHTS.md` | Tactical insights specific to this phase | When insights are identified |
| `impl/PLAN.md` | Prompt plan: sequence of bounded goals with dependencies | After spec is approved |
| `impl/NN-*.md` | Numbered implementation prompts for the Developer | Just in time, per the prompt plan |

---

## The Journal

The journal is a folder of weekly rolling files. Every session, decision, and lesson goes here in chronological order. It is the single canonical record of what happened.

### Journal file naming

Files are named by ISO week: `YYYY-WNN.md` (e.g., `2026-W10.md`). A new file is created at the start of each week. Old files are never modified — they are the historical record.

### Journal entry types

Every entry is tagged with one of three types:

- `[session]` — what happened in a work session
- `[decision]` — a non-trivial decision with context and reasoning
- `[lesson]` — something learned the hard way, stated prescriptively

Tags enable filtering. Any role can scan for `[decision]` entries when the Human Lead asks about a past choice, or `[lesson]` entries when flagging a repeated mistake.

**Promotion entries** are tagged as `[decision]` with context explaining the promotion:

```markdown
## YYYY-MM-DD — <Active Role> [decision]

Promoted task-login-bug to epic-login-auth-overhaul.

**Context:** The login redirect fix revealed that the entire auth flow has inconsistent redirect handling across 4 endpoints.
**Reason:** This needs multiple phases — one per endpoint group — plus integration tests. No longer a one-phase fix.
**Continuation:** epic-login-auth-overhaul continues the work. Original task artefacts preserved as-is.
```

### Weekly journal file template

```markdown
# Journal — Week of YYYY-MM-DD

---

## YYYY-MM-DD — <Role> [session]

<One-line summary: what was accomplished.>

**Detail:** *(optional — include for complex sessions, skip for simple ones)*
- **Action:** <tier> — <name>
- **Phase:** N — <name>
- **Files touched:** <paths>
- **Open threads:** <anything pending>

---

## YYYY-MM-DD — <Role> [decision]

<What was decided.>

**Context:** <What prompted this decision.>
**Reason:** <Why this option was chosen.>

---

## YYYY-MM-DD — <Role> [lesson]

<Lesson title — imperative, actionable.>

**Context:** <The specific situation — what happened.>
**Lesson:** <What to do differently — prescriptive, not descriptive.>
```

---

## Key Insights

KEY_INSIGHTS.md files exist at three levels: project, action, and phase. They are curated distillations from the journal — not append-only logs. Each one contains only the insights that are currently relevant at that scope.

### How promotion works

Something happens in a session → it goes in the weekly journal file. If any role recognises it as a reusable insight, it gets written directly to the appropriate KEY_INSIGHTS.md:

- A lesson about a specific API quirk in this phase → **phase-level**
- A pattern that applies across all phases of this action → **action-level**
- A lesson about the codebase's testing infrastructure that applies everywhere → **project-level**

Insights can also be demoted or removed when they're no longer relevant. A phase-level insight about a workaround becomes obsolete once the phase is complete. An action-level insight about an API limitation might be resolved by a later phase. The KEY_INSIGHTS.md files are living documents, not archives.

### Who maintains them

The AI writes insights directly to the appropriate KEY_INSIGHTS.md per `roles/common.md`, regardless of stance. The **Architect** typically writes project-level and action-level insights (broadest context). The **Tech Lead** typically writes phase-level insights (tactical details). The **Curator** periodically audits all levels and proposes promotions, demotions, and retirements. You review insights as they appear and maintain final authority over what stays.

### KEY_INSIGHTS.md template

The same template is used at all three levels. The scope line changes.

```markdown
# Key Insights — <Scope Name>

> Scope: Project / Action (<tier>) — <name> / Phase N
> Curated from journal entries. Remove when no longer relevant.

## <Insight title — imperative, actionable>

**Context:** <The specific situation or pattern.>
**Insight:** <What to do or avoid — prescriptive, not descriptive.>
**Source:** journal/YYYY-WNN.md, YYYY-MM-DD

## <Another insight>

...
```

The **Source** field links back to the journal entry for full context. The insight itself is a distillation — short enough to scan, specific enough to act on.

### What the Architect loads

When starting a session, the Architect loads KEY_INSIGHTS.md at three levels:

1. Project-level `KEY_INSIGHTS.md` — always
2. Active action's `KEY_INSIGHTS.md` — always
3. Active phase's `KEY_INSIGHTS.md` — if one exists

This replaces scanning the full journal. Three small, curated files instead of a growing chronological log.

---

## Templates

### STATUS.md

```markdown
# <Project Name> — Status

> Single source of truth. Every role reads this for orientation.

## Current State

| Field | Value |
|---|---|
| **Mode** | **PLANNING** / **IMPLEMENTATION** |
| **Active action** | <tier>: <name> (e.g., "epic: refactor-validation") |
| **Active phase** | Phase N — <name> |
| **Active prompt** | Prompt NN (Implementation mode only) |
| **Next action** | <what to do next> |

## Actions

| # | Action | Tier | Gatekeep | Status | Detail |
|---|---|---|---|---|---|
| 1 | Fix login redirect | Task | Login redirects to /dashboard | Achieved | [task-fix-login-bug/](./actions/task-fix-login-bug/) |
| 2 | Refactor validation pipeline | Epic | Switch statements removed, tests pass, API backward-compatible | Active | [epic-refactor-validation/](./actions/epic-refactor-validation/) |
| 3 | Plugin architecture | Goal | Human Lead satisfied that third-party extensions work without core changes | Pending | [goal-plugin-architecture/](./actions/goal-plugin-architecture/) |

## Action History

| Date | From | To | Reason |
|---|---|---|---|
| YYYY-MM-DD | task-fix-login-bug (Achieved) | epic-refactor-validation (Active) | Task complete, moving to next priority |

## Roadmap — <Active Action Name>

| Phase | Name | One-liner | Detail | Status |
|---|---|---|---|---|
| 1 | Baseline tests | Assert current behaviour before refactoring | [SPEC.md](./actions/epic-refactor-validation/phases/1-baseline-tests/SPEC.md) | ✅ Complete |
| 2 | Lookup table | Replace switch with dynamic lookup | [SPEC.md](./actions/epic-refactor-validation/phases/2-lookup-table/SPEC.md) | 🔨 Implementing |
| 3 | Migration | Move existing validators to new pattern | | ❌ Not planned yet |

## Code Repository

**Location:** `{code}/`
**Branch:** `<branch>`
```

### CONTEXT.md

```markdown
# Codebase Reference — <Project Name>

> Last updated: YYYY-MM-DD

## Repo Structure

<Relevant parts of the repo tree, annotated.>

## Key Files

<Table of important files and their purposes.>

## How Things Work

<Architecture overview. Brief. Focus on patterns the AI needs to follow.>
```

### TASK.md

```markdown
# Task — <Name>

> Status: Active / Achieved / Paused
> Done when: <concrete, verifiable condition>

## The Problem

<What's wrong or what needs to be done. Brief — a task's problem statement should be 1-3 paragraphs.>

## Done When

- [ ] <specific, verifiable criterion>
- [ ] <specific, verifiable criterion>
- [ ] Tests pass
```

### EPIC.md

```markdown
# Epic — <Name>

> Status: Active / Achieved / Paused
> Gatekeep: <concrete, measurable conditions>
> Promoted from: <original action, if applicable — e.g., "task-fix-login-bug (journal 2026-W11)">

## The Problem

<What problem does this epic solve? Why does it matter?>

## The Vision

<What does "done" look like? Concrete, measurable outcome.>

## Gatekeep Checklist

- [ ] <measurable condition>
- [ ] <measurable condition>
- [ ] <measurable condition>
```

### GOAL.md

```markdown
# Goal — <Name>

> Status: Active / Achieved / Paused
> Gatekeep: <who decides it's achieved, what they're evaluating>
> Promoted from: <original action, if applicable>

## The Problem

<What problem does this goal solve? Why does it matter?>

## The Vision

<What does "done" look like? Concrete example if possible.>

## Design Principles

<Numbered principles that guide decisions for this goal.>

## Known Design Debts

<Architectural issues to address as the work matures.>
```

### Phase SPEC.md

```markdown
# Phase N — <Name>

> Action: <tier> — <name>
> Status: Planning | Implementing | Complete
> Revision: v1

## Problem / Goal

<What this phase achieves and why it matters now.
Self-contained — a new reader should understand this without reading other files.
Reference the action this phase serves.>

## Steps

<Numbered concrete steps. File paths, code references, specific changes.>

## Test Cases / Validation

<How we know it's correct. Specific inputs and expected outputs where possible.>

## Done Criteria

Technical completion:
- [ ] <criterion>
- [ ] <criterion>
- [ ] Tests pass
- [ ] Type-checker clean

Action evaluation:
- [ ] Human Lead confirms this phase moves toward the action's gatekeep
```

### Prompt Plan

The Tech Lead produces a prompt plan before writing the first detailed prompt. See [PROMPTS.md](./PROMPTS.md) for the full just-in-time prompting model. For tasks with 1–2 prompts, the plan is optional — the prompts themselves are sufficient.

```markdown
## Prompt Plan — Phase N

| # | Goal | Dependencies | Risk |
|---|---|---|---|
| 01 | <bounded goal in one line> | None | Low / Medium / High — <reason if not Low> |
| 02 | <bounded goal> | 01 complete | <risk> |
| 03 | <bounded goal> | 02 complete | <risk> |
```

### Implementation Prompt

See [PROMPTS.md](./PROMPTS.md) for the full guide on writing effective prompts.

```markdown
# Prompt NN — <Short Description>

> Phase: N — <Name>
> Prereqs: Prompt NN-1 complete (or "None")

## Goal

<One paragraph: what this prompt achieves.>

## Steps

<Numbered, specific steps. File paths, code to change, commands to run.>

## If unexpected

<Per-prompt rules for handling discrepancies. What to adapt, what to flag, what to STOP on.>
- <condition> → adapt silently, note in receipt
- <condition> → STOP, report back
- <condition> → adapt if intent is clear, flag in receipt

## Verify

<Exact commands. Expected output. What success looks like.>

## Done when

- [ ] <criterion>
- [ ] <criterion>
```

### Session Receipt (produced by Developer after each prompt)

```markdown
## Session Receipt
- **Role:** Developer
- **Prompt:** NN — <Short Description>
- **Status:** Complete / Partial / Blocked
- **Accomplished:** <what was done>
- **Files created/modified:** <paths>
- **State changes:** <structural changes the next prompt needs to know — new directories, changed exports, renamed files, altered type signatures>
- **Open issues:** <anything unexpected, flagged discrepancies, adaptations made>
```

---

## Conventions

### Naming

- Project journal repo: `<project-name>-journal/` (e.g., `formforge-journal/`)
- Action folders: `<tier>-kebab-case-name/` (e.g., `task-fix-login-bug/`, `epic-refactor-validation/`, `goal-plugin-architecture/`)
- Phase folders: `N-kebab-case-name/` (e.g., `1-baseline-tests/`)
- Implementation prompts: `NN-kebab-case-description.md` (e.g., `01-test-infrastructure.md`)
- Journal files: `YYYY-WNN.md` (e.g., `2026-W10.md`)

### Status indicators

Use in STATUS.md roadmap tables:

- `✅ Complete` — done and verified
- `🔨 Implementing` — prompts being executed
- `📐 Planning` — spec being written or reviewed
- `❌ Not planned yet` — future phase, no spec exists
- `⏸️ Paused` — work stopped, reason logged in journal

### Action status indicators

Use in STATUS.md actions table:

- `Active` — currently being worked on (only one at a time)
- `Achieved` — gatekeep met, work complete
- `Paused` — work stopped temporarily, reason in journal
- `Pending` — defined but not yet started
- `Promoted` — superseded by a higher-tier action (append-forward)

### Key insights format

Every insight must be actionable:

- **Title:** short, imperative (e.g., "Baseline every code path the refactor touches")
- **Context:** the specific situation or pattern
- **Insight:** what to do or avoid, stated prescriptively
- **Source:** link to the journal entry for full context

Bad: "Refactoring was hard."
Good: "Before any refactor that moves code between modules, write automated tests that assert current behaviour. Run them before and after. If they pass without test changes, the refactor preserved behaviour."

### Promoting insights

Insights flow upward through the hierarchy:

- Journal entry → phase KEY_INSIGHTS.md → action KEY_INSIGHTS.md → project KEY_INSIGHTS.md

When an insight from one phase proves applicable to other phases within the same action, promote it to the action level. When it proves applicable across actions, promote it to the project level. Keep the original at the lower level if it has phase-specific context that would be lost in the promotion.

When an insight from one project proves applicable to other projects, copy it into the project-level KEY_INSIGHTS.md of those projects.
