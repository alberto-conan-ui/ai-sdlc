---
type: process
audience: [human, ai]
depends_on: [memory.md]
---

# The Knowledge Tree

The knowledge tree (`knowledge-tree/`) is the project's long-term memory. It's a folder hierarchy where each node holds curated, actionable insights about an area of your project — patterns to follow, pitfalls to avoid, architectural decisions that constrain future work. The tree typically mirrors your codebase structure, but the organising principle is **the boundaries where different knowledge applies**, not the file system itself. Cross-cutting concerns (testing strategy, deployment patterns, error handling philosophy) get their own nodes even when they don't map to a single folder in the code.

The knowledge tree is what makes session 10 cheaper than session 1. When the AI loads the relevant nodes for the area it's about to work in, it starts with everything previous sessions have learned — without re-reading the codebase, re-discovering the constraints, or re-learning the patterns.

For how the knowledge tree fits into the broader memory model — including how insights flow from the action tree, how the journal bridges the two, and the Curator's audit process — see [memory.md](./memory.md).

> **Depends on:** [memory.md](./memory.md)
> **Extended by:** [file-types/knowledge-index.md](./file-types/knowledge-index.md), [file-types/knowledge-spec.md](./file-types/knowledge-spec.md)
> **See also:** [action-tree.md](./action-tree.md), [roles/curator.md](../roles/curator.md)

---

## Structure

The tree typically follows your codebase's meaningful boundaries — but it's organised by where different knowledge applies, not by file paths. Each node is a folder with an `index.spec.md` that maps what's there. Leaf files hold deep knowledge about a specific concern and use the `.spec.md` extension to mark them as knowledge specs. The structure tells the AI where to look — loading `knowledge-tree/api/index.spec.md` is enough to orient it on API patterns without loading the entire tree.

```
knowledge-tree/
├── index.spec.md                ← project-wide: cross-cutting patterns, architectural decisions
├── auth/
│   ├── index.spec.md            ← how auth works, key patterns, session model
│   └── session-handling.spec.md ← deep knowledge about session lifecycle
├── api/
│   ├── index.spec.md            ← API design patterns, endpoint conventions
│   └── validation.spec.md       ← validation pipeline specifics
└── tooling/
    └── index.spec.md            ← build system, CI, testing infrastructure
```

### The index.spec.md at each level

Every node has an `index.spec.md` (a knowledge spec file). It serves two purposes: orienting the reader on what this area covers, and mapping the sub-areas so the AI knows whether to go deeper.

```markdown
# <Area>

> Last updated: YYYY-MM-DD

## Overview

<What this area of the codebase does. 2-3 sentences — enough to orient someone
who hasn't worked here before.>

## Sub-areas

| Node | What it covers |
|---|---|
| [<child>/](./child/index.spec.md) | <one-line description> |
| [<specific>.spec.md](./specific.spec.md) | <one-line description> |

## Insights

<Insights that apply to this area broadly — not specific enough
for a sub-area file, but important for anyone working here.>
```

The root `knowledge-tree/index.spec.md` is the project-wide level: cross-cutting patterns, architectural decisions, conventions that apply everywhere.

### Leaf files

When a specific concern accumulates enough knowledge to warrant its own file, it gets one. `auth/session-handling.spec.md` exists because sessions are complex enough that their knowledge doesn't fit neatly in `auth/index.spec.md`. The threshold is judgement — if the index is getting long or mixing concerns, split.

For detailed documentation of each knowledge tree file type, see the [File Type Catalogue](./file-types/) — specifically [knowledge-index](./file-types/knowledge-index.md) and [knowledge-spec](./file-types/knowledge-spec.md).

---

## How the Tree Grows

The tree grows organically. You don't scaffold a deep hierarchy upfront — you start with what you know and let the structure emerge from the work.

**A new project starts almost empty.** The Bootstrapper creates `knowledge-tree/index.spec.md` and nothing else. The tree is a blank slate.

**Nodes appear as work touches new areas.** When the Architect works on authentication for the first time, `knowledge-tree/auth/` gets created. When a second action touches auth and produces different insights, the node grows. The structure follows the work, not a predetermined taxonomy.

**Depth follows complexity.** An area that's been worked on once might have just an `index.spec.md` with two insights. An area that's been worked on across ten actions might have an index, three sub-area files, and a dozen curated insights. Both are correct — the tree reflects what the project has learned, not what it might learn.

**Splitting is a sign of health.** When `api/index.spec.md` grows to the point where validation patterns and error handling patterns are interleaved and hard to scan, split them into `api/validation.spec.md` and `api/error-handling.spec.md`. The index becomes a map; the detail moves to dedicated files.

---

## Monorepo and Multi-Package Patterns

For larger codebases, the knowledge tree mirrors the structural boundaries that matter — packages, services, or domains.

### Monorepo with packages

```
knowledge-tree/
├── index.spec.md                    ← cross-cutting patterns, shared conventions
├── packages/
│   ├── index.spec.md                ← how packages relate, shared infrastructure
│   ├── core/
│   │   ├── index.spec.md            ← core library patterns
│   │   └── state-management.spec.md
│   ├── ui/
│   │   ├── index.spec.md            ← component patterns, styling conventions
│   │   └── accessibility.spec.md
│   └── api-client/
│       └── index.spec.md            ← API client patterns, caching, error handling
├── infrastructure/
│   └── index.spec.md                ← CI/CD, deployment, environment config
└── testing/
    └── index.spec.md                ← test patterns, fixtures, shared utilities
```

### Service-oriented architecture

```
knowledge-tree/
├── index.spec.md                    ← cross-service patterns, communication contracts
├── services/
│   ├── index.spec.md                ← service boundaries, shared patterns
│   ├── auth-service/
│   │   └── index.spec.md
│   ├── billing-service/
│   │   └── index.spec.md
│   └── notification-service/
│       └── index.spec.md
├── shared/
│   ├── index.spec.md                ← shared libraries, common utilities
│   └── event-schema.spec.md         ← event contracts between services
└── infrastructure/
    └── index.spec.md                ← deployment, orchestration, observability
```

### What to mirror and what to flatten

The knowledge tree mirrors the codebase's *meaningful* boundaries, not its file system. If a monorepo has 30 packages but only 4 have been worked on, the tree has 4 package nodes — not 30 empty ones. If two packages share so many patterns that their knowledge overlaps heavily, consider a shared node rather than duplicating insights.

The guiding principle: **match the boundaries where different knowledge applies.** If working in `packages/ui/` requires knowing different things than working in `packages/core/`, they deserve separate nodes. If they follow the same patterns, a shared node at `packages/index.md` might be enough.

---

## Knowledge File Format

Every insight follows the same format — actionable, sourced, and concise:

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

The **Source** field links back to the action log or journal entry for full context. This is what makes the Curator's audit possible — every insight is traceable to where it was learned.

**Good insights are prescriptive, not descriptive:**

Bad: "Refactoring was hard."
Good: "Before any refactor that moves code between modules, write automated tests that assert current behaviour. Run them before and after. If they pass without test changes, the refactor preserved behaviour."

Bad: "The API is tricky."
Good: "The validation API silently swallows errors when passed an empty array — always check for empty inputs before calling."

---

## What Belongs at Each Level

Not every insight belongs in the knowledge tree, and not every knowledge tree insight belongs at the same level.

**Project-wide** (`knowledge-tree/index.spec.md`) — patterns and decisions that apply everywhere. Naming conventions, error handling philosophy, testing strategy, architectural constraints. If it matters regardless of which area you're working in, it's project-wide.

**Area-level** (`knowledge-tree/<area>/index.spec.md`) — patterns specific to that area. How auth tokens are structured, what the API validation pipeline expects, how the build system resolves dependencies. If it matters when working in this area but not elsewhere, it's area-level.

**Deep knowledge** (`knowledge-tree/<area>/<specific>.spec.md`) — detailed knowledge about a narrow concern within an area. Session lifecycle edge cases, the specific validation rules for user input, a complex migration pattern. If the area index is getting crowded, the detail moves here.

**Not in the knowledge tree** — insights that are specific to a single action and won't apply to future work. These stay in the action's `KEY_INSIGHTS.md` during the work and get discarded on completion. The working scratchpad is for working; the knowledge tree is for what endures.

---

## Maintenance

The knowledge tree is a living resource — not a write-once archive.

**Every role contributes** as part of normal work. When you encounter something worth knowing beyond the current session, propose placing it in the knowledge tree at the right node. See [memory.md](./memory.md) for the operational details.

**The Curator audits** periodically, using the journal as the audit trail. The Curator catches what was missed during the work — insights logged but never promoted, stale entries invalidated by later work, entries at the wrong structural level. See [curator.md](../roles/curator.md) for the audit process.

**The Human Lead owns** the final quality. The AI proposes; the human reviews, refines, and approves. An AI-written insight that says "the refactor was complex" teaches nothing. One the human refines to say "before moving validators between modules, write assertion tests for current behaviour first" teaches permanently.

**Retirement is healthy.** When an insight no longer applies — the code changed, the pattern was replaced, the constraint was removed — retire it. The journal and archive preserve the historical context. The knowledge tree reflects the current truth.
