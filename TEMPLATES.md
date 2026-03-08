# AI-SDLC: File Templates & Conventions

> Reference for the project journal structure. Each project gets its own journal repo following these templates.

---

## Project Journal Structure

### Full Mode (6+ phases, multiple goals possible)

```
my-project-journal/
├── STATUS.md                      ← Where are we now + roadmap (single source of truth)
├── JOURNAL.md                     ← Session history (summary + detail)
├── DECISIONS.md                   ← Why we chose X (what, context, reason)
├── LESSONS_LEARNED.md             ← What to do differently (actionable)
├── CONTEXT.md                     ← Codebase reference (repo structure, key files, patterns)
│
└── goals/
    └── N-goal-name/
        ├── GOAL.md                ← The goal: outcome, gatekeep, vision, design principles
        └── phases/
            └── N-phase-name/
                ├── SPEC.md        ← Phase spec (steps, tests, done criteria)
                └── impl/
                    ├── 01-description.md
                    ├── 02-description.md
                    └── ...
```

### Lite Mode (1-5 phases, single goal)

```
my-project-journal/
├── STATUS.md                      ← Where are we now + inline roadmap + inline phase specs
├── JOURNAL.md                     ← Session history
├── DECISIONS.md                   ← Decisions log
├── LESSONS_LEARNED.md             ← Lessons
└── CONTEXT.md                     ← Codebase reference
```

In lite mode, the goal definition, roadmap, and phase specs all live inline in STATUS.md. No goals/ folder needed. See the Scaling the Process section in [PROCESS.md](./PROCESS.md) for when to use each mode.

---

## File Purposes and Update Cadence

### Project-level files (both modes)

| File | Purpose | Updated |
|---|---|---|
| `STATUS.md` | Single source of truth: mode, active goal, active phase, next action, roadmap | Every session |
| `JOURNAL.md` | Session history: one-line summary + optional detail per entry | Every session |
| `DECISIONS.md` | Decisions with context and reasoning | When decisions are made |
| `LESSONS_LEARNED.md` | Actionable lessons learned the hard way | When learned |
| `CONTEXT.md` | Codebase reference: repo structure, key files, patterns | When code structure changes |

### Goal-level files (full mode only)

| File | Purpose | Created |
|---|---|---|
| `GOAL.md` | Goal definition: outcome, gatekeep, vision, design principles | During Inception |

### Phase-level files (full mode only)

| File | Purpose | Created |
|---|---|---|
| `SPEC.md` | Phase plan: steps, test cases, done criteria | Before phase begins |
| `impl/NN-*.md` | Numbered implementation prompts for the Developer | After spec is approved |

---

## Templates

### STATUS.md

```markdown
# <Project Name> — Status

> Single source of truth. The Orchestrator reads this first, every time.

## Current State

| Field | Value |
|---|---|
| **Mode** | **INCEPTION** / **PLANNING** / **IMPLEMENTATION** |
| **Active goal** | Goal #N — <goal in plain language> |
| **Active phase** | Phase N — <name> |
| **Active prompt** | Prompt NN (Implementation mode only) |
| **Next action** | <what to do next> |

## Goals

| # | Goal | Gatekeep | Status | Detail |
|---|---|---|---|---|
| 1 | <human-defined outcome> | <who decides, what they evaluate> | Active / Achieved / Paused | [goals/1-name/](./goals/1-name/) |

## Goal History

| Date | From | To | Reason |
|---|---|---|---|
| YYYY-MM-DD | Goal #N (Paused) | Goal #M (Active) | <why the swap happened> |

## Roadmap — <Active Goal Name>

| Phase | Name | One-liner | Detail | Status |
|---|---|---|---|---|
| 1 | <name> | <description> | [SPEC.md](./goals/N-name/phases/1-name/SPEC.md) | <status> |
| 2 | <name> | <description> | | ❌ Not planned yet |

## Code Repository

**Location:** `../<repo-folder-name>/`
**Branch:** `<branch>`
```

### Lite Mode STATUS.md (inline specs)

```markdown
# <Project Name> — Status

> Single source of truth. The Orchestrator reads this first, every time.

## Current State

| Field | Value |
|---|---|
| **Mode** | **INCEPTION** / **PLANNING** / **IMPLEMENTATION** |
| **Active goal** | <goal in plain language> |
| **Gatekeep** | <who decides, what they evaluate> |
| **Active phase** | Phase N — <name> |
| **Active prompt** | Prompt NN (Implementation mode only) |
| **Next action** | <what to do next> |

## Vision

<What does "done" look like for this goal? Design principles if relevant.>

## Roadmap

| Phase | Name | Status |
|---|---|---|
| 1 | <name> | <status> |
| 2 | <name> | <status> |

---

## Phase 1 — <Name>

**Goal:** <What this phase achieves and how it serves the overall goal.>

**Steps:**
1. <step>
2. <step>

**Done when:**
- [ ] <criterion>
- [ ] <criterion>

---

## Phase 2 — <Name>

...

## Code Repository

**Location:** `../<repo-folder-name>/`
**Branch:** `<branch>`
```

### JOURNAL.md

```markdown
# Project Journal

> Session history. One entry per session. Summary line for scanning, detail block when needed.

---

## YYYY-MM-DD — <Role>

<One-line summary: what was accomplished.>

**Detail:** *(optional — include for complex sessions, skip for simple ones)*
- **Phase:** N — <name>
- **Files touched:** <paths>
- **Open threads:** <anything pending>

---

## YYYY-MM-DD — <Role>

<One-line summary.>
```

### DECISIONS.md

```markdown
# Decisions Log

> Every non-trivial decision with context and reasoning.
> All decisions live here — one canonical location.

| Date | Decision | Context | Reason |
|---|---|---|---|
| YYYY-MM-DD | <what was decided> | <what prompted it> | <why this option> |
```

### LESSONS_LEARNED.md

```markdown
# Lessons Learned — <Project Name>

> Each entry must be actionable — not "X was hard" but "do Y instead of Z because..."
> Entries that prove broadly applicable should be copied to other relevant project journals.

## <Category>

### <Lesson title>

**Context:** <The specific situation — what happened.>

**Lesson:** <What to do differently — prescriptive, not descriptive.>
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

### GOAL.md (full mode only)

```markdown
# Goal #N — <Goal Name>

> Status: Active / Achieved / Paused
> Gatekeep: <who decides it's achieved, what they're evaluating>

## The Problem

<What problem does this goal solve? Why does it matter?>

## The Vision

<What does "done" look like? Concrete example if possible.>

## Design Principles

<Numbered principles that guide decisions for this goal.>

## Known Design Debts

<Architectural issues to address as the work matures.>
```

### Phase SPEC.md (full mode only)

```markdown
# Phase N — <Name>

> Goal: #N — <which goal this phase serves>
> Status: Planning | Implementing | Complete
> Revision: v1

## Problem / Goal

<What this phase achieves and why it matters now.
Self-contained — a new reader should understand this without reading other files.
Reference the human-defined goal this phase serves.>

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

Goal evaluation:
- [ ] Human Lead confirms this phase moves toward the goal's gatekeep
```

### Implementation Prompt (full mode only)

See [PROMPTS.md](./PROMPTS.md) for the full guide on writing effective prompts.

```markdown
# Prompt NN — <Short Description>

> Phase: N — <Name>
> Prereqs: Prompt NN-1 complete (or "None")

## Goal

<One paragraph: what this prompt achieves.>

## Steps

<Numbered, specific steps. File paths, code to change, commands to run.>

## Verify

<Exact commands. Expected output. What success looks like.>

## Done when

- [ ] <criterion>
- [ ] <criterion>
```

---

## Conventions

### Naming

- Project journal repo: `<project-name>-journal/` (e.g., `formforge-journal/`)
- Goal folders: `N-kebab-case-name/` (e.g., `1-plugin-architecture/`, `2-onboarding-dx/`)
- Phase folders: `N-kebab-case-name/` (e.g., `1-baseline-tests/`)
- Implementation prompts: `NN-kebab-case-description.md` (e.g., `01-test-infrastructure.md`)

### Status indicators

Use in STATUS.md roadmap tables:

- `✅ Complete` — done and verified
- `🔨 Implementing` — prompts being executed
- `📐 Planning` — spec being written or reviewed
- `❌ Not planned yet` — future phase, no spec exists

### Lessons learned format

Every lesson must be actionable:

- **Title:** short, imperative (e.g., "Baseline every code path the refactor touches")
- **Context:** the specific situation that taught this lesson
- **Lesson:** what to do differently, stated prescriptively

Bad: "Refactoring was hard."
Good: "Before any refactor that moves code between modules, write automated tests that assert current behaviour. Run them before and after. If they pass without test changes, the refactor preserved behaviour."

### Promoting lessons

When a lesson from one project proves applicable beyond that project, copy it into the LESSONS_LEARNED.md of other relevant project journals. Keep the original in the source project journal for context — the copied version can be condensed.
