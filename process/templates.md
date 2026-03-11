# File Templates & Conventions

> Reference for the project memory structure. Each project gets its own memory repo following these templates.

---

## Project Memory Structure

```
my-project-memory/
├── STATUS.md                      ← Where are we now + roadmap (single source of truth)
├── CONTEXT.md                     ← Lightweight map: repo structure + pointers to knowledge
├── journal/                       ← Raw chronological log (weekly rolling files)
│   ├── 2026-W10.md
│   ├── 2026-W11.md
│   └── ...
│
├── knowledge/                     ← Curated knowledge tree (mirrors codebase structure)
│   ├── index.md                   ← Project-wide patterns, cross-cutting decisions
│   ├── auth/
│   │   ├── index.md               ← Auth subsystem patterns and decisions
│   │   └── session-handling.md    ← Deep knowledge about sessions
│   ├── api/
│   │   ├── index.md
│   │   └── validation.md
│   └── tooling/
│       └── index.md               ← Build, CI, testing infrastructure
│
├── actions/                       ← Active and pending actions only
│   └── epic-refactor-validation/
│       ├── EPIC.md                ← Problem + vision + concrete gatekeep
│       ├── KEY_INSIGHTS.md        ← Working scratchpad
│       └── phases/
│           ├── 1-baseline-tests/
│           │   ├── SPEC.md
│           │   ├── KEY_INSIGHTS.md ← Phase-level scratchpad
│           │   └── impl/
│           │       ├── PLAN.md
│           │       ├── 01-test-infrastructure.md
│           │       └── 02-assertion-coverage.md
│           └── 2-lookup-table/
│               ├── SPEC.md
│               └── impl/
│
└── archive/                       ← Completed, promoted, or abandoned actions
    ├── task-fix-login-bug/
    │   ├── TASK.md
    │   └── phases/
    │       └── ...
    └── goal-plugin-architecture/
        ├── GOAL.md
        └── phases/
            └── ...
```

One structure for all projects. The tier prefix (`task-`, `epic-`, `goal-`) makes the action type visible at a glance without opening any files. Active work lives in `actions/`; when an action is achieved, promoted, or abandoned, it moves to `archive/`. The knowledge it produced already lives in the knowledge tree — the archived folder is the append-forward historical record.

---

## File Purposes and Update Cadence

### Project-level files

| File | Purpose | Updated |
|---|---|---|
| `STATUS.md` | Single source of truth: mode, active action, active phase, next action, roadmap | Every session |
| `CONTEXT.md` | Lightweight map: repo structure, key files, pointers into `knowledge/` | When code structure changes |
| `journal/` | Raw chronological log: sessions, decisions, lessons — everything that happens | Every session (current week's file) |
| `knowledge/` | Curated knowledge tree mirroring codebase — what we've learned about each area | Organically, as insights emerge from work |

### Action-level files

| File | Purpose | Created |
|---|---|---|
| `TASK.md` | Task definition: problem statement, done-when criteria | When creating a task |
| `EPIC.md` | Epic definition: problem, vision, concrete gatekeep | When creating an epic |
| `GOAL.md` | Goal definition: problem, vision, design principles, abstract gatekeep | When creating a goal |
| `KEY_INSIGHTS.md` | Working scratchpad: insights during the action, migrates to knowledge/ when done | As insights emerge |

### Phase-level files

| File | Purpose | Created |
|---|---|---|
| `SPEC.md` | Phase plan: steps, test cases, done criteria | Before phase begins |
| `KEY_INSIGHTS.md` | Working scratchpad: tactical insights for this phase | As insights emerge |
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

## Knowledge Tree

The `knowledge/` folder is a hierarchy that mirrors your codebase. Each node contains markdown files with curated insights about that area — patterns, decisions, pitfalls, conventions. See [principles.md](./principles.md) for the full model.

### Structure

The tree grows organically. You don't scaffold it upfront. When work takes you into a new area of the codebase, the Architect creates the relevant node. An `index.md` at each level maps the sub-areas.

```
knowledge/
├── index.md                ← project-wide: cross-cutting patterns, architectural decisions
├── <area>/
│   ├── index.md            ← area overview: how it works, key patterns
│   └── <specific>.md       ← deep knowledge about a specific subsystem or concern
└── ...
```

### Knowledge file format

```markdown
# <Area or Topic>

> Last updated: YYYY-MM-DD

## <Insight title — imperative, actionable>

**Context:** <The specific situation or pattern.>
**Insight:** <What to do or avoid — prescriptive, not descriptive.>
**Source:** journal/YYYY-WNN.md, YYYY-MM-DD

## <Another insight>

...
```

The **Source** field links back to the journal entry for full context. The insight itself is a distillation — short enough to scan, specific enough to act on.

### Who maintains the knowledge tree

The Human Lead and the Architect build the tree together through conversation. The Architect proposes where an insight belongs and drafts the content. The Human Lead confirms, redirects, or refines. The **Curator** periodically audits the tree and proposes editorial changes — promotions, retirements, reorganisation. You maintain final authority over what stays.

### What the Architect loads

When starting a session, the Architect reads `CONTEXT.md` to identify which knowledge nodes are relevant, then loads those nodes. This replaces scanning the full journal — a few curated files instead of a growing chronological log.

### Working scratchpads (action and phase KEY_INSIGHTS.md)

During an action, `KEY_INSIGHTS.md` files at the action and phase level serve as working scratchpads — accumulating learnings as they emerge. These are temporary. When an action completes, anything worth keeping migrates to the appropriate node in the knowledge tree. The action folder becomes a historical record; the knowledge lives on in the tree.

---

## Templates

### STATUS.md — Inception (new project)

A freshly bootstrapped project has no actions, no roadmap, and no phases. The Bootstrapper creates STATUS.md using this template:

```markdown
# <Project Name> — Status

> Single source of truth. Every role reads this for orientation.

## Current State

| Field | Value |
|---|---|
| **Mode** | **INCEPTION** |
| **Active action** | None |
| **Active phase** | — |
| **Active prompt** | — |
| **Next action** | Invoke the Architect to define the first action |

## Actions

| # | Action | Tier | Gatekeep | Status | Detail |
|---|---|---|---|---|---|

## Action History

| Date | From | To | Reason |
|---|---|---|---|
| YYYY-MM-DD | — | Workspace initialised | Project onboarded to AI-SDLC |

## Code Repository

**Location:** `{code}/`
**Branch:** `main`
```

Once the first action is defined, the Architect updates STATUS.md to Planning mode using the full template below.

### STATUS.md — Active project

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

### CONTEXT.md — Inception skeleton

During setup, the Bootstrapper creates a minimal CONTEXT.md from a few questions asked to the user. It does not explore the codebase:

```markdown
# Codebase Reference — <Project Name>

> Last updated: YYYY-MM-DD
> This file is a lightweight map. Deep knowledge lives in knowledge/.

## What This Is

<One or two sentences: what the project does.>

## Tech Stack

<A few lines: language, framework, major dependencies.>

## Repo

<URL>

## Structure

<!-- To be filled by the Architect in the first working session. -->

## Knowledge Map

<!-- Populated as the knowledge tree grows. Points to knowledge/ nodes. -->
```

### CONTEXT.md — Full (populated by Architect)

The Architect deepens CONTEXT.md during the first working session and updates it as the codebase evolves. CONTEXT.md is a map, not an encyclopedia — it describes the repo structure and points into the knowledge tree for deeper understanding.

```markdown
# Codebase Reference — <Project Name>

> Last updated: YYYY-MM-DD
> This file is a lightweight map. Deep knowledge lives in knowledge/.

## Repo Structure

<Relevant parts of the repo tree, annotated.>

## Key Files

<Table of important files and their purposes.>

## Knowledge Map

| Area | Knowledge node | What it covers |
|---|---|---|
| Authentication | [knowledge/auth/](../knowledge/auth/index.md) | Auth flow, session handling, OAuth patterns |
| API layer | [knowledge/api/](../knowledge/api/index.md) | Validation pipeline, endpoint conventions |
| Tooling | [knowledge/tooling/](../knowledge/tooling/index.md) | Build system, CI, testing infrastructure |
```

**Guidance on depth:** CONTEXT.md stays lightweight — structure and pointers, not detailed explanations. When the Architect encounters something worth documenting in depth, it goes in the knowledge tree at the right node, and CONTEXT.md gets a pointer. For monorepos or large codebases, focus initially on the top-level structure and the knowledge map. Detail lives in the tree.

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

The Tech Lead produces a prompt plan before writing the first detailed prompt. See [prompts.md](./prompts.md) for the full just-in-time prompting model. For tasks with 1–2 prompts, the plan is optional — the prompts themselves are sufficient.

```markdown
## Prompt Plan — Phase N

| # | Goal | Dependencies | Risk |
|---|---|---|---|
| 01 | <bounded goal in one line> | None | Low / Medium / High — <reason if not Low> |
| 02 | <bounded goal> | 01 complete | <risk> |
| 03 | <bounded goal> | 02 complete | <risk> |
```

### Implementation Prompt

See [prompts.md](./prompts.md) for the full guide on writing effective prompts.

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

- Project memory repo: `<project-name>-memory/` (e.g., `formforge-memory/`)
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
