# File Templates & Conventions

> Reference for the project memory structure. When you need to create a file, look here for the template. For detailed documentation of each file type — purpose, ownership, format, and notes — see the [File Type Catalogue](./file-types/).

---

## Project Memory Structure

```
my-project-memory/
├── journal/                       ← Cross-cutting annotations (weekly rolling files)
│   ├── 2026-W10.md
│   ├── 2026-W11.md
│   └── ...
│
├── knowledge-tree/                ← Long-term memory (organised by knowledge boundaries)
│   ├── index.spec.md              ← Project overview, repo structure, cross-cutting knowledge
│   ├── auth/
│   │   ├── index.spec.md          ← Auth subsystem patterns and decisions
│   │   └── session-handling.spec.md    ← Deep knowledge about sessions
│   ├── api/
│   │   ├── index.spec.md
│   │   └── validation.spec.md
│   └── tooling/
│       └── index.spec.md          ← Build, CI, testing infrastructure
│
├── action-tree/                   ← Short-term memory (active and pending work)
│   ├── STATUS.md                  ← Single source of truth: mode, active stack, roadmap
│   ├── auth-redesign/
│   │   ├── gatekeep.md            ← Completion criteria (required at every node)
│   │   ├── context.md             ← What this is about + links to knowledge tree
│   │   ├── index.md               ← Maps children
│   │   ├── audit-endpoints/
│   │   │   ├── gatekeep.md
│   │   │   ├── context.md
│   │   │   ├── log.md             ← Session-by-session history for this action
│   │   │   ├── KEY_INSIGHTS.md    ← Working scratchpad → migrates to knowledge tree
│   │   │   └── phases/
│   │   │       └── 1-catalogue-endpoints/
│   │   │           ├── phase.md
│   │   │           ├── prompt-plan.md
│   │   │           ├── 01-map-all-routes.md
│   │   │           └── 01-map-all-routes.receipt.md
│   │   ├── new-token-model/
│   │   │   ├── gatekeep.md
│   │   │   └── ...
│   │   └── migrate-sessions/
│   │       ├── gatekeep.md
│   │       └── ...
│   └── fix-csv-date-format/
│       ├── gatekeep.md
│       ├── log.md
│       └── phases/
│           └── 1-fix-format/
│               ├── phase.md
│               ├── prompt-plan.md
│               ├── 01-fix-date-format.md
│               └── 01-fix-date-format.receipt.md
│
└── archive/                       ← Completed or abandoned action subtrees
    └── fix-csv-date-format/
        ├── gatekeep.md
        ├── log.md
        └── phases/
            └── ...
```

For how these pieces connect: [memory.md](./memory.md) defines the full memory model, [action-tree.md](./action-tree.md) covers the action tree structure and gatekeeping, [knowledge-tree.md](./knowledge-tree.md) covers knowledge organisation and growth patterns.

---

## Templates

### knowledge-tree/index.spec.md — Inception skeleton

The Bootstrapper creates a minimal root index (a knowledge spec file) from a few questions asked to the user. It does not explore the codebase:

```markdown
# <Project Name>

> Last updated: YYYY-MM-DD
> This is the root of the knowledge tree. Project-wide knowledge lives here;
> area-specific knowledge lives in sub-nodes.

## What This Is

<One or two sentences: what the project does.>

## Tech Stack

<A few lines: language, framework, major dependencies.>

## Repo

<URL>

## Repo Structure

<!-- To be filled by the Architect in the first working session. -->

## Sub-areas

<!-- Populated as the knowledge tree grows. -->

| Node | What it covers |
|---|---|
| | |

## Insights

<!-- Project-wide cross-cutting insights go here. -->
```

### knowledge-tree/index.spec.md — Full (populated by Architect)

The Architect deepens the root index during the first working session and updates it as the codebase evolves. It stays lightweight — structure and pointers, not detailed explanations. When the Architect encounters something worth documenting in depth, it goes in a sub-node, and the index maps to it.

```markdown
# <Project Name>

> Last updated: YYYY-MM-DD

## What This Is

<One or two sentences: what the project does.>

## Tech Stack

<Language, framework, major dependencies.>

## Repo Structure

<Relevant parts of the repo tree, annotated.>

## Key Files

<Table of important files and their purposes.>

## Sub-areas

| Node | What it covers |
|---|---|
| [auth/](./auth/index.spec.md) | Auth flow, session handling, OAuth patterns |
| [api/](./api/index.spec.md) | Validation pipeline, endpoint conventions |
| [tooling/](./tooling/index.spec.md) | Build system, CI, testing infrastructure |

## Insights

<Project-wide cross-cutting insights — patterns, decisions, and conventions
that apply regardless of which area you're working in.>
```

### action-tree/STATUS.md — Inception (new project)

A freshly bootstrapped project has no actions, no stack, and no phases:

```markdown
# <Project Name> — Status

> Single source of truth. Every role reads this for orientation.

## Current State

| Field | Value |
|---|---|
| **Mode** | **INCEPTION** |
| **Next step** | Invoke the Architect to define the first action |

## Active Stack

*Empty — no active work.*

## Action Tree

*No actions defined yet.*

## Code Repository

**Location:** `{code}/`
**Branch:** `main`
```

Once the first action is defined, the Architect updates STATUS.md to Planning mode. Roadmap references should point to the new flat phase structure with `phase.md` files instead of nested `SPEC.md`.

### action-tree/STATUS.md — Active project

```markdown
# <Project Name> — Status

> Single source of truth. Every role reads this for orientation.

## Current State

| Field | Value |
|---|---|
| **Mode** | **PLANNING** / **IMPLEMENTATION** |
| **Active phase** | Phase N — <name> (Implementation mode only) |
| **Active prompt** | Prompt NN (Implementation mode only) |
| **Next step** | <what to do next> |

## Active Stack

| # | Action | Status | Detail |
|---|---|---|---|
| → | auth-redesign/new-token-model | Implementing phase 2 | [context](./auth-redesign/new-token-model/context.md) |
| | auth-redesign | Children in progress | [context](./auth-redesign/context.md) |

*→ marks the current top of stack.*

## Action Tree

| Action | Gatekeep | Status | Detail |
|---|---|---|---|
| auth-redesign | All sub-actions complete + integration clean | Active | [gatekeep](./auth-redesign/gatekeep.md) |
| ∟ audit-endpoints | All endpoints catalogued with auth patterns | Achieved | [archive](../archive/audit-endpoints/) |
| ∟ new-token-model | Token refresh works, all tests pass | Active | [gatekeep](./auth-redesign/new-token-model/gatekeep.md) |
| ∟ migrate-sessions | Existing sessions migrated without downtime | Pending | [gatekeep](./auth-redesign/migrate-sessions/gatekeep.md) |
| fix-csv-date-format | CSV dates match ISO 8601 | Achieved | [archive](../archive/fix-csv-date-format/) |

## Roadmap — <Active Action Name>

| Phase | Name | One-liner | Detail | Status |
|---|---|---|---|---|
| 1 | Token schema | Define the new token structure | [phase.md](...) | ✅ Complete |
| 2 | Refresh flow | Implement token refresh endpoint | [phase.md](...) | 🔨 Implementing |
| 3 | Client integration | Update client SDK | | ❌ Not planned yet |

## Code Repository

**Location:** `{code}/`
**Branch:** `<branch>`
```

### Journal — Weekly file

Files are named by ISO week: `YYYY-WNN.md` (e.g., `2026-W10.md`). Entries are tagged `[decision]`, `[observation]`, or `[process]`. See [memory.md](./memory.md) for the journal's role in the memory model.

```markdown
# Journal — Week of YYYY-MM-DD

---

## YYYY-MM-DD — <Role> [decision]

<What was decided.>

**Context:** <What prompted this decision.>
**Reason:** <Why this option was chosen.>

---

## YYYY-MM-DD — <Role> [observation]

<What was noticed — cross-cutting pattern, recurring issue, something worth tracking.>

**Actions affected:** <which action nodes this touches>
**Implication:** <what this means for future work>

---

## YYYY-MM-DD — [process]

<What changed in how we work.>

**Reason:** <Why the change was made.>
```

### Action log (log.md)

```markdown
# Log — <Action Name>

---

## YYYY-MM-DD — <Role>

<One-line summary: what was accomplished.>

**Detail:** *(optional — include for complex sessions, skip for simple ones)*
- **Phase:** N — <name>
- **Files touched:** <paths>
- **Open threads:** <anything pending>
- **Next:** <what to pick up next session>

---

## YYYY-MM-DD — <Role>

...
```

### gatekeep.md

```markdown
# <Action Name>

> Status: Active / Achieved / Paused / Pending

## Done When

<What "done" means for this action. Can be concrete, measurable, or subjective —
the discipline is in writing it, not in classifying it.>

- [ ] <criterion>
- [ ] <criterion>

## Branch Gatekeep (if this node has children)

<What must be true BEYOND all children passing their own gatekeeps.
Integration quality, performance, coherence across sub-actions.
Omit this section for leaf nodes.>
```

### context.md (action node)

```markdown
# Context — <Action Name>

> Last updated: YYYY-MM-DD

## What This Is

<What this action is about. Brief — enough for someone starting a new session
to understand the work without reading everything else.>

## Knowledge

| Area | Node | Why it matters here |
|---|---|---|
| <area> | [knowledge-tree/<path>](../../knowledge-tree/<path>/index.spec.md) | <how this knowledge applies> |

## Scope

<What's in scope and what's explicitly out of scope for this action.>
```

### index.md (action branch node)

```markdown
# <Action Name> — Sub-actions

> Parent gatekeep: <one-line summary of this node's gatekeep>

| Sub-action | Gatekeep summary | Status |
|---|---|---|
| <name> | <one-line gatekeep> | Active / Achieved / Pending |
| <name> | <one-line gatekeep> | Active / Achieved / Pending |
```

### phase.md

The phase design document sits flat in the phase folder (not in a subfolder).

```markdown
# Phase N — <Name>

> Action: <action path>
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

### prompt-plan.md

The prompt plan sits flat in the phase folder alongside phase.md. The Tech Lead produces it before writing the first detailed prompt. See [prompts.md](./prompts.md) for the full just-in-time prompting model. For simple actions with 1–2 prompts, the plan is optional.

```markdown
# Prompt Plan — Phase N

| # | Goal | Dependencies | Risk |
|---|---|---|---|
| 01 | <bounded goal in one line> | None | Low / Medium / High — <reason if not Low> |
| 02 | <bounded goal> | 01 complete | <risk> |
| 03 | <bounded goal> | 02 complete | <risk> |
```

### NN-description.md (Implementation Prompt)

Implementation prompts sit flat in the phase folder with no `impl/` subfolder prefix. See [prompts.md](./prompts.md) for the full guide on writing effective prompts.

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

### NN-description.receipt.md (Session Receipt)

Session receipts are formal files paired with each implementation prompt by name. They sit flat in the phase folder alongside the prompts.

```markdown
# Session Receipt — NN-description

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
- Action folders: `kebab-case-name/` — named by the user, no required prefixes (e.g., `auth-redesign/`, `fix-csv-date-format/`, `q2-platform-work/`)
- Phase folders: `N-kebab-case-name/` (e.g., `1-baseline-tests/`)
- Implementation prompts: `NN-kebab-case-description.md` (e.g., `01-test-infrastructure.md`)
- Journal files: `YYYY-WNN.md` (e.g., `2026-W10.md`)

### Phase status indicators

- `✅ Complete` — done and verified
- `🔨 Implementing` — prompts being executed
- `📐 Planning` — spec being written or reviewed
- `❌ Not planned yet` — future phase, no spec exists
- `⏸️ Paused` — work stopped, reason logged

### Action status indicators

- `Active` — currently being worked on (on the active stack)
- `Achieved` — gatekeep met, work complete
- `Paused` — work stopped temporarily, reason in action log
- `Pending` — defined but not yet started

### Key insights format

Every insight must be actionable:

- **Title:** short, imperative (e.g., "Baseline every code path the refactor touches")
- **Context:** the specific situation or pattern
- **Insight:** what to do or avoid, stated prescriptively
- **Source:** link to the action log or journal entry for full context

Bad: "Refactoring was hard."
Good: "Before any refactor that moves code between modules, write automated tests that assert current behaviour. Run them before and after. If they pass without test changes, the refactor preserved behaviour."
