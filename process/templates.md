# File Templates & Conventions

> Reference for the project memory structure. Each project gets its own memory repo following these templates.

---

## Project Memory Structure

```
my-project-memory/
├── STATUS.md                      ← Where are we now + active stack (single source of truth)
├── CONTEXT.md                     ← Lightweight map: repo structure + pointers to knowledge
├── journal/                       ← Cross-cutting annotations (weekly rolling files)
│   ├── 2026-W10.md
│   ├── 2026-W11.md
│   └── ...
│
├── knowledge/                     ← Knowledge tree: long-term memory (mirrors codebase)
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
├── actions/                       ← Action tree: short-term memory (active and pending work)
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
│   │   │           ├── SPEC.md
│   │   │           └── impl/
│   │   │               ├── PLAN.md
│   │   │               └── 01-map-all-routes.md
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
│               ├── SPEC.md
│               └── impl/
│
└── archive/                       ← Completed or abandoned action subtrees
    └── fix-csv-date-format/
        ├── gatekeep.md
        ├── log.md
        └── phases/
            └── ...
```

One structure for all projects. Action nodes are named by the user — no required prefixes or tier labels. Active work lives in `actions/`; when an action is completed or abandoned, its subtree moves to `archive/`. The knowledge it produced already lives in the knowledge tree — the archived folder is the append-forward historical record.

---

## File Purposes and Update Cadence

### Project-level files

| File | Purpose | Updated |
|---|---|---|
| `STATUS.md` | Single source of truth: mode, active stack, roadmap | Every session |
| `CONTEXT.md` | Lightweight map: repo structure, key files, pointers into `knowledge/` | When code structure changes |
| `journal/` | Cross-cutting annotations: project-level decisions, process changes, observations spanning multiple actions | When cross-cutting events occur |
| `knowledge/` | Knowledge tree (long-term memory): curated insights mirroring codebase — what we've learned about each area | Organically, as insights migrate from completed actions |

### Action node files

| File | Required | Purpose | Created |
|---|---|---|---|
| `gatekeep.md` | **Yes** | Completion criteria for this node | When creating the action |
| `context.md` | No | What this action is about + links to relevant knowledge tree nodes | When the action touches multiple codebase areas |
| `index.md` | No | Maps child actions — what each covers, how they relate | When a node gets children (becomes a branch) |
| `log.md` | No | Session-by-session record of what happened | When work begins on this action |
| `KEY_INSIGHTS.md` | No | Working scratchpad: insights that will migrate to knowledge tree on completion | As insights emerge during work |
| `phases/` | No | Implementation structure (SPEC.md, impl/) | When the action has implementable work |

### Phase-level files

| File | Purpose | Created |
|---|---|---|
| `SPEC.md` | Phase plan: steps, test cases, done criteria | Before phase begins |
| `impl/PLAN.md` | Prompt plan: sequence of bounded goals with dependencies | After spec is approved |
| `impl/NN-*.md` | Numbered implementation prompts for the Developer | Just in time, per the prompt plan |

---

## The Journal

The journal is a folder of weekly rolling files. It captures cross-cutting annotations — things that don't belong to a specific action node. Project-level decisions, process changes, observations that span multiple actions. The journal is also the key input for the Curator: the raw material from which long-term knowledge is distilled.

Detailed session history lives in the action node's `log.md`, not in the journal.

### Journal file naming

Files are named by ISO week: `YYYY-WNN.md` (e.g., `2026-W10.md`). A new file is created at the start of each week. Old files are never modified — they are the historical record.

### Journal entry types

Every entry is tagged with one of three types:

- `[decision]` — a non-trivial project-level decision with context and reasoning
- `[observation]` — something noticed that spans multiple actions or affects the project broadly
- `[process]` — a change to how the team works, tooling updates, methodology adjustments

### Weekly journal file template

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

---

## The Action Log

Each action node can have a `log.md` that captures the session-by-session history of work on that action. This is the action's short-term memory — it tells the next session where the previous one left off.

Logs live at the nodes where work happens. The Human Lead and the active role look up the tree when broader context is needed.

### Action log template

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

---

## Knowledge Tree

The `knowledge/` folder is a hierarchy that mirrors your codebase. Each node contains markdown files with curated insights about that area — patterns, decisions, pitfalls, conventions. This is the project's long-term memory. See [principles.md](./principles.md) for the full model.

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
**Source:** <action log or journal reference for full context>

## <Another insight>

...
```

The **Source** field links back to the action log or journal entry for full context. The insight itself is a distillation — short enough to scan, specific enough to act on.

### Who maintains the knowledge tree

The Human Lead and the Architect build the tree together through conversation. The Architect proposes where an insight belongs and drafts the content. The Human Lead confirms, redirects, or refines. The **Curator** periodically audits the tree — reading action logs and the journal to distill insights, propose editorial changes, promotions, retirements, and reorganisation. You maintain final authority over what stays.

### What the Architect loads

When starting a session, the Architect reads `CONTEXT.md` and the active action's `context.md` to identify which knowledge tree nodes are relevant, then loads those nodes. This replaces scanning logs or the journal — a few curated files instead of a growing chronological record.

### Working scratchpads (KEY_INSIGHTS.md)

During an action, `KEY_INSIGHTS.md` serves as a working scratchpad — accumulating learnings as they emerge. This is temporary. When an action completes, anything worth keeping migrates to the appropriate node in the knowledge tree. The action archives; the knowledge lives on in the tree.

---

## Templates

### STATUS.md — Inception (new project)

A freshly bootstrapped project has no actions, no stack, and no phases. The Bootstrapper creates STATUS.md using this template:

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

Once the first action is defined, the Architect updates STATUS.md to Planning mode using the full template below.

### STATUS.md — Active project

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
| → | auth-redesign/new-token-model | Implementing phase 2 | [context](./actions/auth-redesign/new-token-model/context.md) |
| | auth-redesign | Children in progress | [context](./actions/auth-redesign/context.md) |

*→ marks the current top of stack.*

## Action Tree

| Action | Gatekeep | Status | Detail |
|---|---|---|---|
| auth-redesign | All sub-actions complete + integration clean | Active | [gatekeep](./actions/auth-redesign/gatekeep.md) |
| ∟ audit-endpoints | All endpoints catalogued with auth patterns | Achieved | [archive](./archive/audit-endpoints/) |
| ∟ new-token-model | Token refresh works, all tests pass | Active | [gatekeep](./actions/auth-redesign/new-token-model/gatekeep.md) |
| ∟ migrate-sessions | Existing sessions migrated without downtime | Pending | [gatekeep](./actions/auth-redesign/migrate-sessions/gatekeep.md) |
| fix-csv-date-format | CSV dates match ISO 8601 | Achieved | [archive](./archive/fix-csv-date-format/) |

## Roadmap — <Active Action Name>

| Phase | Name | One-liner | Detail | Status |
|---|---|---|---|---|
| 1 | Token schema | Define the new token structure | [SPEC.md](...) | ✅ Complete |
| 2 | Refresh flow | Implement token refresh endpoint | [SPEC.md](...) | 🔨 Implementing |
| 3 | Client integration | Update client SDK | | ❌ Not planned yet |

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
| <area> | [knowledge/<path>](../../knowledge/<path>/index.md) | <how this knowledge applies> |

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

### Phase SPEC.md

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

### Prompt Plan

The Tech Lead produces a prompt plan before writing the first detailed prompt. See [prompts.md](./prompts.md) for the full just-in-time prompting model. For simple actions with 1–2 prompts, the plan is optional — the prompts themselves are sufficient.

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
- Action folders: `kebab-case-name/` — named by the user, no required prefixes (e.g., `auth-redesign/`, `fix-csv-date-format/`, `q2-platform-work/`)
- Phase folders: `N-kebab-case-name/` (e.g., `1-baseline-tests/`)
- Implementation prompts: `NN-kebab-case-description.md` (e.g., `01-test-infrastructure.md`)
- Journal files: `YYYY-WNN.md` (e.g., `2026-W10.md`)

### Status indicators

Use in STATUS.md roadmap tables:

- `✅ Complete` — done and verified
- `🔨 Implementing` — prompts being executed
- `📐 Planning` — spec being written or reviewed
- `❌ Not planned yet` — future phase, no spec exists
- `⏸️ Paused` — work stopped, reason logged

### Action status indicators

Use in STATUS.md action tree table:

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
