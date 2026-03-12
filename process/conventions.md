---
type: process
audience: [human, ai]
---

# Conventions & Templates

> Naming conventions, status indicators, and bootstrapper templates. For file type definitions (purpose, format, rules), see the [File Type Catalogue](./file-types/). For the project memory structure diagram, see [bootstrap/README.md](../bootstrap/README.md).

> **Depends on:** [file-types/](./file-types/), [bootstrap/README.md](../bootstrap/README.md)
> **Referenced by:** [roles/bootstrapper.md](../roles/bootstrapper.md)

---

## Naming Conventions

- Project memory folder: `.ai-sdlc/memory/` (nested inside the code repo, gitignored)
- Action folders: `kebab-case-name/` — named by the user, no required prefixes (e.g., `auth-redesign/`, `fix-csv-date-format/`, `q2-platform-work/`)
- Phase folders: `N-kebab-case-name/` (e.g., `1-baseline-tests/`)
- Implementation prompts: `NN-kebab-case-description.md` (e.g., `01-test-infrastructure.md`)
- Journal files: `YYYY-WNN.md` (e.g., `2026-W10.md`)

---

## Phase Status Indicators

- `✅ Complete` — done and verified
- `🔨 Implementing` — prompts being executed
- `📐 Planning` — spec being written or reviewed
- `❌ Not planned yet` — future phase, no spec exists
- `⏸️ Paused` — work stopped, reason logged

---

## Action Status Indicators

- `Active` — currently being worked on (on the active stack)
- `Achieved` — gatekeep met, work complete
- `Paused` — work stopped temporarily, reason in action log
- `Pending` — defined but not yet started

---

## Bootstrapper Templates

These templates are used once during project inception. The inception-specific STATUS.md template is also in the [file-type catalogue — status.md](./file-types/status.md); the templates below are kept here because the Bootstrapper role references this file during setup.

### knowledge-tree/index.spec.md — Inception skeleton

The Bootstrapper creates a minimal root index from a few questions asked to the user. It does not explore the codebase:

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

The Architect deepens the root index during the first working session and updates it as the codebase evolves. It stays lightweight — structure and pointers, not detailed explanations.

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

### action-tree/STATUS.md — Active project

```markdown
# <Project Name> — Status

> Single source of truth. Every role reads this for orientation.

## Current State

| Field | Value |
|---|---|
| **Engagement** | **SHAPING** / **WORKING** |
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

Once the first action is defined, the Architect updates STATUS.md to Planning mode. The Engagement field stays as SHAPING until the Human Lead declares the switch to WORKING (see [workflow.md — Engagement Modes](./workflow.md#engagement-modes)).
