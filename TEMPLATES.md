# AI-SDLC: File Templates & Conventions

> Reference for the project journal structure. Each project gets its own journal repo following this template.

---

## Project Journal Structure

The project journal is its own git repository, separate from both the code repo and the ai-sdlc methodology repo. See [SETUP.md](./SETUP.md) for the workspace convention.

```
my-project-sdlc/                   ← Project journal repo (its own git repository)
├── INDEX.md                       ← Project status + navigation
├── JOURNAL.md                     ← Timeline (one-line entries per session)
├── DECISIONS.md                   ← Decisions log (what, why, when)
├── LESSONS_LEARNED.md             ← Project-scoped lessons
└── <workstream>/                  ← One folder per workstream
    ├── SPEC.md                    ← Why — the problem, the vision, design principles
    ├── CONTEXT.md                 ← What — codebase reference, file map, current state
    ├── PLAN.md                    ← How — roadmap of phases with status
    ├── SESSION_LOG.md             ← History — what was done, by whom, files touched
    ├── LESSONS_LEARNED.md         ← Workstream-specific lessons
    └── phases/
        └── N-name/
            ├── SPEC.md            ← The phase plan (problem, steps, tests, done criteria)
            └── impl/              ← Numbered implementation prompts
                ├── 01-description.md
                ├── 02-description.md
                └── ...
```

The ai-sdlc methodology repo (shared across projects) holds only:

```
ai-sdlc/
├── PROCESS.md                     ← The methodology guide
├── TEMPLATES.md                   ← This file
├── SETUP.md                       ← Workspace setup guide
└── lessons-learned/
    └── GLOBAL.md                  ← Cross-project lessons (promoted from project journals)
```

---

## File Purposes and Update Cadence

### Project-level files (in the project journal repo)

| File | Purpose | Updated when |
|---|---|---|
| `INDEX.md` | Current status, active workstream, navigation links | Start/end of each session |
| `JOURNAL.md` | One-line timeline entries | Every session |
| `DECISIONS.md` | Cross-cutting decisions (tooling, naming, process) | When decisions are made |
| `LESSONS_LEARNED.md` | Project-scoped lessons | When something is learned the hard way |

### Workstream-level files

| File | Purpose | Updated when |
|---|---|---|
| `SPEC.md` | The vision — problem statement, design principles, known debts | Design changes |
| `CONTEXT.md` | Codebase reference — repo structure, key files, component inventory | Code changes |
| `PLAN.md` | Roadmap — phase table with status and links to phase docs | Phase starts/completes |
| `SESSION_LOG.md` | What was done, by whom, which files were touched, open threads | End of each session |
| `LESSONS_LEARNED.md` | Architecture and design lessons specific to this workstream | When something is learned |

### Phase-level files

| File | Purpose | Created when |
|---|---|---|
| `SPEC.md` | The phase plan: problem/goal, steps, test cases, done criteria | Before phase begins (planning stage) |
| `impl/01-*.md` | Numbered implementation prompts for the executor | After spec is reviewed and approved |

### Global files (in the ai-sdlc methodology repo)

| File | Purpose | Updated when |
|---|---|---|
| `lessons-learned/GLOBAL.md` | Cross-project lessons (process, testing, documentation) | When a project lesson proves broadly applicable |

---

## Templates

### INDEX.md

```markdown
# <Project Name> — AI Knowledge Home

> AI-assisted development knowledge base for <project name>.

---

## Project Status

| Field | Value |
|---|---|
| **Mode** | **PLANNING** or **IMPLEMENTING** |
| **Active workstream** | <workstream name> |
| **Active phase** | Phase N — <name> |
| **Next action** | <what to do next> |

---

## Active Workstream

**<Workstream Name>** → [<workstream>/](./<workstream>/)

---

## Code Repository

**Location:** `../<repo-folder-name>/`
**Branch:** `<branch>`
```

### JOURNAL.md

```markdown
# Project Journal

> Timeline across all workstreams. One or two lines per entry.

---

| Date | Who | Entry |
|---|---|---|
| YYYY-MM-DD | <who> | <one-line summary with link to session log> |
```

### DECISIONS.md

```markdown
# Decisions Log

> Decisions that affect the project broadly or span multiple workstreams.
> Workstream-specific decisions live in their workstream's PLAN.md.

---

| Date | Decision | Context | Reason |
|---|---|---|---|
| YYYY-MM-DD | <what was decided> | <what prompted it> | <why this option> |
```

### LESSONS_LEARNED.md (project-scoped)

```markdown
# Lessons Learned — <Project Name>

> Lessons from this project that might apply to others.
> Each entry should be actionable — not "X was hard" but "do Y instead of Z because..."
> Entries that prove broadly applicable should be promoted to ai-sdlc/lessons-learned/GLOBAL.md.

---

## <Category>

### <Lesson title>

**Context:** <What happened — the specific situation.>

**Lesson:** <What to do differently — prescriptive, not descriptive.>
```

### Workstream SPEC.md

```markdown
# <Workstream Name> — Specification & Design Rationale

> Last updated: YYYY-MM-DD

---

## The Problem

<What problem does this workstream solve? Why does it matter?>

## The Vision

<What does "done" look like? Include a concrete example if possible.>

## Design Principles

<Numbered list of principles that guide decisions in this workstream.>

## Known Design Debts

<Architectural issues to address as the work matures.>

## Glossary

<Terms specific to this workstream.>
```

### Workstream CONTEXT.md

```markdown
# Codebase Reference — <Workstream Name>

> Last updated: YYYY-MM-DD

---

## Repo Structure

<Relevant parts of the repo tree, annotated.>

## Key Files

<Table of important files and their purposes.>

## How Things Work

<Brief explanation of the architecture relevant to this workstream.>
```

### Workstream PLAN.md

```markdown
# Current Plan — <Workstream Name>

> Last updated: YYYY-MM-DD (version)
> Active branch: <branch>

---

## Current Focus

**Phase N — <Name> — <Status emoji>**

<One paragraph on what's happening now.>

---

## Roadmap

| Phase | Name | One-liner | Detail | Status |
|---|---|---|---|---|
| 1 | <name> | <one-line description> | [phases/1-name/](./phases/1-name/) | <status> |

---

## Workstream Decisions Log

| Date | Decision | Reason |
|---|---|---|
| YYYY-MM-DD | <what> | <why> |
```

### Phase SPEC.md

```markdown
# Phase N — <Name>

> Workstream: <workstream>
> Status: <Planning | Implementing | Complete>
> Revision: v1

---

## Problem / Goal

<What this phase achieves and why it matters now.
Self-contained — a new reader should understand this without reading other files.>

## Steps

<Numbered list of concrete steps. Include file paths, code references, specific changes.>

## Test Cases / Validation

<How we know it's correct. Include specific inputs and expected outputs where possible.>

## Done Criteria

<Explicit checklist. Each item is binary — done or not done.>

- [ ] <criterion>
- [ ] <criterion>
- [ ] Tests pass
- [ ] Type-checker clean
```

### Implementation Prompt (impl/NN-description.md)

```markdown
# Prompt NN — <Short Description>

> Phase: N — <Name>
> Prereqs: Prompt NN-1 complete (or "None" for the first prompt)

---

## Goal

<One paragraph: what this prompt achieves.>

## Steps

<Numbered, specific steps. File paths, code to write/change, commands to run.>

## Verify

<How to confirm this prompt succeeded. Include exact commands.>

## Done when

- [ ] <criterion>
- [ ] <criterion>
```

---

## Conventions

### Naming

- Project journal repo: `<project-name>-sdlc/` (e.g., `formforge-sdlc/`)
- Phase folders: `N-kebab-case-name/` (e.g., `1-baseline-demos-tests/`)
- Implementation prompts: `NN-kebab-case-description.md` (e.g., `01-test-infrastructure.md`)
- Workstream folders: `kebab-case/` (e.g., `dx/`, `auth-layer/`)

### Status indicators

Use in PLAN.md roadmap tables:

- `✅ Complete` — phase is done and verified
- `🔨 Implementing` — implementation prompts are being executed
- `📐 Planning` — spec is being written or reviewed
- `❌ Not planned yet` — future phase, no spec exists

### Lessons learned format

Every lesson must be actionable. Use this structure:

- **Title:** short, imperative (e.g., "Baseline every code path the refactor touches")
- **Context:** the specific situation that taught this lesson
- **Lesson:** what to do differently, stated prescriptively

Bad: "Refactoring was hard."
Good: "Before any refactor that moves code between modules, write automated tests that assert the current behaviour. Run them before and after. If they pass without test changes, the refactor preserved behaviour."

### Path references to code

From the project journal, reference code files using relative paths to the sibling code repo:

```
../my-project/path/to/file.ts
```

From implementation prompts (which are deeper in the folder structure):

```
../../../../my-project/path/to/file.ts
```

All paths resolve correctly because the workspace convention places all three repos as siblings under a shared parent folder (see [SETUP.md](./SETUP.md)).

### Promoting lessons

When a lesson learned in a project journal proves applicable beyond that project, copy it to `ai-sdlc/lessons-learned/GLOBAL.md`. Keep the original in the project journal for context — the global version can be condensed.
