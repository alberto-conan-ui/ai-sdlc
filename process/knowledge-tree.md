# The Knowledge Tree

> **References**
>
> | Group | File |
> |---|---|
> | Memory model | [memory.md](./memory.md) |
> | File types | [file-types/](./file-types/) |
> | Action tree | [action-tree.md](./action-tree.md) |

The knowledge tree (`knowledge-tree/`) is the project's long-term memory. A folder hierarchy where each node holds curated, actionable insights about an area of your project — patterns to follow, pitfalls to avoid, architectural decisions that constrain future work. The tree typically mirrors your codebase structure, but the organising principle is **the boundaries where different knowledge applies**, not the file system itself.

The knowledge tree is what makes session 10 cheaper than session 1. When the AI loads the relevant nodes, it starts with everything previous sessions learned — without re-reading the codebase or re-discovering constraints.

---

## Structure

The tree follows your codebase's meaningful boundaries. Each node is a folder with a `[name].index.md` that maps what's there. Additional `*.spec.md` files hold deep knowledge about specific concerns (the `spec` type is defined in the [typed file system](./memory.md)). The structure tells the AI where to look — loading `knowledge-tree/api/api.index.md` is enough to orient on API patterns without loading the entire tree.

```
knowledge-tree/
├── knowledge-tree.index.md        ← project-wide: cross-cutting patterns, architectural decisions
├── auth/
│   ├── auth.index.md              ← how auth works, key patterns, session model
│   └── session-handling.spec.md   ← deep knowledge about session lifecycle
├── api/
│   ├── api.index.md               ← API design patterns, endpoint conventions
│   └── validation.spec.md         ← validation pipeline specifics
└── tooling/
    └── tooling.index.md           ← build system, CI, testing infrastructure
```

### The index at each level

Every node has a `[name].index.md`. It orients the reader on what this area covers and maps the sub-areas so the AI knows whether to go deeper.

```markdown
# <Area>

> Last updated: YYYY-MM-DD

## Overview

<What this area of the codebase does. 2-3 sentences.>

## Sub-areas

| Node | What it covers |
|---|---|
| [<child>/](./<child>/<child>.index.md) | <one-line description> |
| [<specific>.spec.md](./<specific>.spec.md) | <one-line description> |

## Insights

<Insights that apply to this area broadly — not specific enough
for a sub-area file, but important for anyone working here.>
```

The root `knowledge-tree.index.md` is the project-wide level: cross-cutting patterns, architectural decisions, conventions that apply everywhere.

### Spec files

When a specific concern accumulates enough knowledge to warrant its own file, it gets a `[name].spec.md` alongside the index. The threshold is judgement — if the index is getting long or mixing concerns, split.

---

## How the Tree Grows

The tree grows organically. You don't scaffold a deep hierarchy upfront.

**A new project starts almost empty.** Setup creates `knowledge-tree.index.md` and nothing else.

**Nodes appear as work touches new areas.** When the Architect works on authentication for the first time, `knowledge-tree/auth/` gets created with `auth.index.md`. The structure follows the work, not a predetermined taxonomy.

**Depth follows complexity.** An area worked on once might have just an index with two insights. An area worked on across ten actions might have an index, three spec files, and a dozen curated insights. Both are correct.

**Splitting is a sign of health.** When an index grows to the point where patterns are interleaved and hard to scan, split into spec files. The index becomes a map; the detail moves to dedicated files.

---

## Monorepo and Multi-Package Patterns

For larger codebases, the tree mirrors the structural boundaries that matter.

```
knowledge-tree/
├── knowledge-tree.index.md            ← cross-cutting patterns
├── packages/
│   ├── packages.index.md              ← how packages relate
│   ├── core/
│   │   ├── core.index.md
│   │   └── state-management.spec.md
│   └── ui/
│       ├── ui.index.md
│       └── accessibility.spec.md
├── infrastructure/
│   └── infrastructure.index.md        ← CI/CD, deployment
└── testing/
    └── testing.index.md               ← test patterns, fixtures
```

The tree mirrors the codebase's *meaningful* boundaries, not its file system. If a monorepo has 30 packages but only 4 have been worked on, the tree has 4 nodes. If two packages share patterns, consider a shared node rather than duplicating insights.

---

## Knowledge File Format

Every insight follows the same format — actionable, sourced, concise:

```markdown
## <Insight title — imperative, actionable>

**Context:** <The specific situation or pattern.>
**Insight:** <What to do or avoid — prescriptive, not descriptive.>
**Source:** <journal entry or action reference for full context>
```

Good insights are prescriptive, not descriptive. "Before any refactor that moves code between modules, write automated tests that assert current behaviour" teaches permanently. "Refactoring was hard" teaches nothing.

---

## What Belongs at Each Level

**Project-wide** (`knowledge-tree.index.md`) — patterns that apply everywhere. Naming conventions, error handling philosophy, testing strategy.

**Area-level** (`<area>/<area>.index.md`) — patterns specific to that area. How auth tokens are structured, what the API validation pipeline expects.

**Deep knowledge** (`<area>/<specific>.spec.md`) — detailed knowledge about a narrow concern within an area. Session lifecycle edge cases, complex migration patterns.

**Not in the knowledge tree** — observations specific to a single action that won't apply to future work. These live in the journal as part of the session record and are naturally discarded (archived) when the action completes.

---

## Maintenance

The knowledge tree is a living resource — not a write-once archive.

**Every stance contributes** as part of normal work. When a loaded insight is stale, fix it or flag it. When you encounter something worth knowing beyond the current session, propose placing it at the right node.

**The Architect audits** as part of normal design work — catching insights flagged in the journal but never promoted, stale entries invalidated by later work, entries at the wrong level.

**The Human Lead owns** the final quality. The AI proposes; the human reviews, refines, and approves.

**Retirement is healthy.** When an insight no longer applies, retire it. The journal and archive preserve the historical context. The knowledge tree reflects the current truth.
