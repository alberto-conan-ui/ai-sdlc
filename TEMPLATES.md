# AI-SDLC: File Templates & Conventions

> Reference for the project journal structure. Each project gets its own journal repo following these templates.

---

## Project Journal Structure

### Full Mode (6+ phases, multiple workstreams possible)

```
my-project-journal/
├── TRACKING.md                    ← Single source of truth: mode, active goal, next action
├── JOURNAL.md                     ← Timeline (one-line entries per session)
├── DECISIONS.md                   ← Decisions log (what, why, when)
├── LESSONS_LEARNED.md             ← Project-scoped lessons
└── <workstream>/                  ← One folder per workstream
    ├── SPEC.md                    ← Why — problem, vision, design principles
    ├── CONTEXT.md                 ← What — codebase reference, file map, current state
    ├── PLAN.md                    ← How — roadmap of phases with status
    ├── SESSION_LOG.md             ← History — what was done, by whom, files touched
    ├── LESSONS_LEARNED.md         ← Workstream-specific lessons
    └── phases/
        └── N-name/
            ├── SPEC.md            ← Phase plan (problem, steps, tests, done criteria)
            └── impl/
                ├── 01-description.md
                ├── 02-description.md
                └── ...
```

### Lite Mode (1-5 phases, single workstream)

```
my-project-journal/
├── TRACKING.md                    ← Single source of truth: mode, active goal, next action
├── JOURNAL.md                     ← Timeline
├── DECISIONS.md                   ← Decisions log
├── LESSONS_LEARNED.md             ← Lessons
└── PLAN.md                        ← Roadmap + inline phase specs
```

See the Scaling the Process section in [PROCESS.md](./PROCESS.md) for when to use each mode.

---

## File Purposes and Update Cadence

### Project-level files

| File | Purpose | Updated |
|---|---|---|
| `TRACKING.md` | Single source of truth: mode, active goal, active phase, next action | Start/end of session |
| `JOURNAL.md` | One-line timeline entries | Every session |
| `DECISIONS.md` | Cross-cutting decisions with context and reasoning | When decisions are made |
| `LESSONS_LEARNED.md` | Project-scoped actionable lessons | When learned the hard way |

### Workstream-level files (full mode only)

| File | Purpose | Updated |
|---|---|---|
| `SPEC.md` | Vision — problem, design principles, known debts | Design changes |
| `CONTEXT.md` | Codebase reference — repo structure, key files, patterns | Code changes |
| `PLAN.md` | Roadmap — phase table with status and links | Phase starts/completes |
| `SESSION_LOG.md` | What was done, by whom, files touched, open threads | End of session |
| `LESSONS_LEARNED.md` | Architecture and design lessons for this workstream | When learned |

### Phase-level files (full mode only)

| File | Purpose | Created |
|---|---|---|
| `SPEC.md` | Phase plan: goal, steps, test cases, done criteria | Before phase begins |
| `impl/NN-*.md` | Numbered implementation prompts for the Developer | After spec is approved |

---

## Templates

### TRACKING.md

```markdown
# <Project Name> — Tracking

> Single source of truth. Every session starts here.

## Current State

| Field | Value |
|---|---|
| **Mode** | **INCEPTION** / **PLANNING** / **IMPLEMENTATION** |
| **Active goal** | Goal #N — <goal in plain language> |
| **Gatekeep** | <who decides it's achieved, what they're evaluating> |
| **Active workstream** | <workstream name> (full mode only) |
| **Active phase** | Phase N — <name> |
| **Active prompt** | Prompt NN (Implementation mode only) |
| **Next action** | <what to do next> |

## Goals

| # | Goal | Gatekeep | Status |
|---|---|---|---|
| 1 | <human-defined, non-technical outcome> | <who decides, what they evaluate> | Active / Achieved / Paused / Deferred |

## Goal History

| Date | From | To | Reason |
|---|---|---|---|
| YYYY-MM-DD | Goal #N (Paused) | Goal #M (Active) | <why the swap happened> |

## Code Repository

**Location:** `../<repo-folder-name>/`
**Branch:** `<branch>`
```

### JOURNAL.md

```markdown
# Project Journal

> One or two lines per entry. Quick orientation for the next session.

| Date | Who | Entry |
|---|---|---|
| YYYY-MM-DD | <who> | <one-line summary with link to session log> |
```

### DECISIONS.md

```markdown
# Decisions Log

> Decisions that affect the project broadly or span workstreams.
> Workstream-specific decisions live in their PLAN.md.

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

### Workstream SPEC.md

```markdown
# <Workstream Name> — Specification & Design Rationale

> Last updated: YYYY-MM-DD

## The Problem

<What problem does this workstream solve? Why does it matter?>

## The Vision

<What does "done" look like? Concrete example if possible.>

## Design Principles

<Numbered principles that guide decisions in this workstream.>

## Known Design Debts

<Architectural issues to address as the work matures.>

## Glossary

<Terms specific to this workstream.>
```

### Workstream CONTEXT.md

```markdown
# Codebase Reference — <Workstream Name>

> Last updated: YYYY-MM-DD

## Repo Structure

<Relevant parts of the repo tree, annotated.>

## Key Files

<Table of important files and their purposes.>

## How Things Work

<Architecture relevant to this workstream. Brief.>
```

### Workstream PLAN.md

```markdown
# Current Plan — <Workstream Name>

> Last updated: YYYY-MM-DD (version)
> Active branch: <branch>

## Goal

<The human-defined, non-technical outcome this workstream serves. Reference goal # from TRACKING.md.>

**Gatekeep:** <Who decides it's achieved, what they're evaluating.>

## Current Focus

**Phase N — <Name> — <Status>**

<One paragraph on what's happening now.>

## Roadmap

| Phase | Name | One-liner | Detail | Status |
|---|---|---|---|---|
| 1 | <name> | <description> | [phases/1-name/](./phases/1-name/) | <status> |

## Workstream Decisions

| Date | Decision | Reason |
|---|---|---|
| YYYY-MM-DD | <what> | <why> |
```

### Lite Mode PLAN.md (inline specs)

```markdown
# Plan — <Project or Feature Name>

> Last updated: YYYY-MM-DD (version)

## Goal

<The human-defined, non-technical outcome this work serves.>

**Gatekeep:** <Who decides it's achieved, what they're evaluating.>

## Current Focus

**Phase N — <Name> — <Status>**

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
```

### Phase SPEC.md

```markdown
# Phase N — <Name>

> Workstream: <workstream>
> Serves goal: <which goal from TRACKING.md this phase serves>
> Status: Planning | Implementing | Complete
> Revision: v1

## Problem / Goal

<What this phase achieves and why it matters now.
Self-contained — a new reader should understand this without reading other files.
Reference the human-defined goal this phase serves and how completing it moves toward that goal.>

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
- [ ] Human Lead confirms this phase moves toward the goal (reference gatekeep from TRACKING.md or workstream PLAN.md)
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

## Verify

<Exact commands. Expected output. What success looks like.>

## Done when

- [ ] <criterion>
- [ ] <criterion>
```

### SESSION_LOG.md

```markdown
# Session Log — <Workstream Name>

> What was done, by whom, and what's pending. One entry per session.

---

## YYYY-MM-DD — Session N

**Who:** <human / AI tool name>
**Phase:** N — <name>
**Branch:** <branch>

**Done:**
- <what was accomplished>

**Files touched:**
- <file paths>

**Open threads:**
- <anything pending or unresolved for the next session>
```

---

## Conventions

### Naming

- Project journal repo: `<project-name>-journal/` (e.g., `formforge-journal/`)
- Workstream folders: `kebab-case/` (e.g., `dx/`, `auth-layer/`)
- Phase folders: `N-kebab-case-name/` (e.g., `1-baseline-tests/`)
- Implementation prompts: `NN-kebab-case-description.md` (e.g., `01-test-infrastructure.md`)

### Status indicators

Use in PLAN.md roadmap tables:

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
