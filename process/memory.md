# The Memory Model

> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Action tree | [action-tree.md](./action-tree.md) |
> | Knowledge tree | [knowledge-tree.md](./knowledge-tree.md) |
> | Recording system | [journaling.md](./journaling.md) |
> | Stances | [roles.md](./roles.md) |

AI-SDLC gives your project durable memory through three layers and a typed file system. This is the central mechanism — everything else in the methodology serves it. Without persistent memory, every AI session starts from zero. With it, session 10 benefits from every lesson learned in sessions 1 through 9.

---

## The Three Layers

### The Journal — Temporal Intake

The journal (`journal/`) is the intake buffer. A chronological stream of session records — what happened, what was decided, what was observed. Each session produces a folder in `journal/live/`, named by date and session number (e.g., `2026-03-19_02/`). Each folder contains a session index, one or more entry files, and a handover — a targeted message for the next session working on that action. See [journaling.md](./journaling.md) for the full structure.

Two subfolders: `live/` for current session folders, `archive/` for processed ones. Processing is on-demand — the Human Lead triggers it by asking the Architect to review `live/` and extract what belongs in the trees. Processed folders move to `archive/`.

The journal is not a lesser version of the trees. It exists because there's a real gap between "something just happened" and "this belongs in a tree." The journal removes the pressure to route prematurely. The handover adds a second function: session continuity. It tells the next session where work was left, complementing status.md which tells where the project stands.

### The Action Tree — Short-Term Memory

The action tree (`action-tree/`) holds work in progress. Organised into topics (strategic, nestable), phases (execution units), and tasks (lightweight single-file quick wins). Each node carries its own completion criteria and context. When an action completes, its subtree moves to `archive/` and any insights worth keeping migrate to the knowledge tree.

See [action-tree.md](./action-tree.md) for the full structure — topics, phases, tasks, gatekeeping, the active stack.

### The Knowledge Tree — Long-Term Memory

The knowledge tree (`knowledge-tree/`) is a folder hierarchy organised by the boundaries where different knowledge applies. Each node holds curated insights — patterns to follow, pitfalls to avoid, architectural decisions that constrain future work. The tree grows organically as work touches new areas.

See [knowledge-tree.md](./knowledge-tree.md) for the structural guide.

---

## How Memory Flows

```
┌─────────────────────────────────────────────────────┐
│                     JOURNAL                          │
│                                                      │
│  Sessions produce entries in journal/live/:           │
│    • What happened (session narrative)               │
│    • Decisions made                                  │
│    • Observations and insights                       │
│                                                      │
└────────────────────┬─────────────────────────────────┘
                     │
                     │  On demand (human triggers):
                     │  Architect reviews live journal,
                     │  extracts to the right tree,
                     │  processed entries → journal/archive/
                     │
            ┌────────┴────────┐
            ▼                 ▼
┌────────────────┐  ┌──────────────────────────────────┐
│  ACTION TREE   │  │       KNOWLEDGE TREE              │
│                │  │                                    │
│  Topics,       │  │  Curated, durable insights        │
│  Phases &      │  │  at the right structural node     │
│  Tasks         │  │                                    │
│  Temporary     │  │  Permanent and living              │
│                │  │                                    │
└───────┬────────┘  └──────────────────────────────────┘
        │                          ▲
        │  On action completion:   │
        │  insights reviewed,      │
        │  worth-keeping migrate ──┘
        │  action → archive/
        ▼
```

The flow is continuous, not ceremonial:

- **During sessions** — the journal captures what happens. The Architect may also write directly to the knowledge tree when an insight is immediately clear and well-placed.
- **On demand** — the human triggers journal processing. The Architect reads `journal/live/`, extracts decisions and insights to the appropriate tree, and processed entries move to `journal/archive/`.
- **On action completion** — journal entries from the action are reviewed. Insights worth keeping migrate to the knowledge tree. The action subtree moves to `archive/`.

---

## The Index — Navigation Primitive

The index file is the core mechanism of the memory model. Every orientation decision the AI makes flows through an index. When the AI enters a folder, it reads the index. When it needs to decide what to load next, it follows links from the index. The index is not a bureaucratic requirement — it's the interface between the AI and the project's memory.

Every folder has `[folder-name].index.md`. No exceptions. The index uses a three-section navigation grammar:

**References** — external context this folder depends on. The parent index, relevant knowledge tree nodes, relevant journal entries. References point up and sideways — they tell the AI what else it needs to understand this node. References appear on all files (not just indexes), but they're the first section of every index.

**Siblings** — typed companion files in the same folder. A goal's index lists its gatekeep and context files. A KT node's index lists its spec files. Siblings are listed with a brief role description so the AI knows what each file contributes without opening it.

**Children** — nodes below this one in the hierarchy. Child folders or files, listed with brief descriptions. In the AT, children may include a status indicator. Children are the downward navigation path — the AI follows them when the task requires going deeper.

The grammar is the same everywhere: AT indexes, KT indexes, journal folder indexes. The AI uses the same pattern to navigate: find the index, read References to understand context, scan Siblings to see companion files, scan Children to decide whether to go deeper.

A KT leaf node has `caching-strategy.index.md` and nothing else — the index IS the content. An AT goal node has `auth-redesign.index.md` plus `auth-redesign.gatekeep.md` and `auth-redesign.context.md` — the index's Siblings section lists these companions. A task is a single file (`N.task.name.md`) that needs no folder or index.

---

## The Typed File System

Every file in the memory system follows one naming convention: **`[name].[type].md`**. The type suffix tells you what the file is without opening it.

### Valid types

| Type | Purpose | Used in |
|---|---|---|
| `index` | Navigation primitive for every folder. Entry point, lists references, siblings, and children. | All trees, all folders |
| `spec` | Curated knowledge — patterns, insights, architectural decisions. In the AT, a change spec for a step. | Knowledge tree, Action tree |
| `gatekeep` | Completion criteria — what "done" means. | Action tree |
| `context` | What an action is about + pointers to relevant KT nodes (domain nodes and the action's notepad node, if one exists). | Action tree |
| `task` | Lightweight single-file action — a quick win that doesn't need a folder. | Action tree |

### Naming in the Action Tree

The action tree uses typed names to distinguish all five node types — goals, topics, phases, steps, and tasks:

```
action-tree/
├── action-tree.index.md
├── status.md
├── 05.goal.v021-release/
│   ├── v021-release.index.md
│   ├── v021-release.gatekeep.md
│   ├── 05.step.interaction-modes/
│   │   └── interaction-modes.index.md
│   ├── 10.step.index-architecture/
│   │   └── index-architecture.index.md
│   └── 15.task.version-bump.md
├── 10.topic.auth-redesign/
│   ├── auth-redesign.index.md
│   ├── auth-redesign.gatekeep.md
│   ├── auth-redesign.context.md
│   ├── 05.phase.audit-endpoints/
│   │   └── audit-endpoints.index.md
│   ├── 10.phase.new-token-model/
│   │   └── new-token-model.index.md
│   └── 15.task.update-env-docs.md
└── archive/
```

Folder prefixes use the local two-digit ID (`05.`, `10.`) — see [action-tree.md — Numbering Convention](./action-tree.md#numbering-convention) for the full scheme. The type (`goal`, `topic`, `phase`, `step`, or `task`) is declared in the name. Folders contain files following `[name].[type].md`. Tasks are single files — no folder needed. In `status.md` and cross-references, nodes use their full hierarchical address (`05.10`) for unambiguous identification.

### What about simple actions?

A simple fix that doesn't need strategic decomposition can be a single phase at the root:

```
action-tree/
├── action-tree.index.md
├── status.md
├── 05.phase.fix-csv-date-format/
│   └── fix-csv-date-format.index.md
```

Even simpler — a task at the root:

```
action-tree/
├── action-tree.index.md
├── status.md
├── 05.task.fix-csv-date-format.md
```

No topic wrapper, no folder needed. The two-digit numbering keeps order and insertion room; the type keeps clarity. Only create structure you need.

---

## Reference Headers

Every file in the memory system has a reference header that declares its dependencies — what other files need to be read to understand this one. Content lives in exactly one place; references point to it. In index files, this is the References section of the navigation grammar (see [The Index — Navigation Primitive](#the-index--navigation-primitive)). In non-index files, it serves the same purpose: declare what the reader needs to load for context.

```markdown
> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Parent context | [../auth-redesign.index.md](../auth-redesign.index.md) |
> | Testing conventions | [testing/testing.spec.md](./testing/testing.spec.md) |
```

Conventions: groups are labeled (why the reference matters), ordered by importance (reading strategy for the AI), and point up and sideways (downward traversal is implicit — the AI reads children when the task requires it).

When a file moves, update the references that point to it. Single-source means there's nothing else to update.

---

## Hierarchy Discipline

Well-structured trees keep references short and navigation efficient. This is a human responsibility — the process signals when the hierarchy is degraded, but only the human decides how to restructure.

### What makes a good node

A node earns its folder when it has a distinct concern that's loaded independently. In the KT, that means the information is needed for work in this area but not in sibling areas. In the AT, that means the work has its own gatekeep and its own lifecycle.

Bad nodes: folders that exist "just in case" (empty), folders that duplicate their parent at finer grain (the split didn't separate concerns), folders where the boundary is arbitrary.

### Signals the hierarchy needs attention

- A file exceeds ~200 lines — split into children.
- A folder has more than 5–7 direct children — add intermediate grouping.
- A reference header has more than 4–5 entries — the hierarchy isn't carrying enough context implicitly.
- The same information appears in multiple siblings — cross-cutting concern should move up.

### How each stance contributes

- The **Architect** is the primary hierarchy steward — notices overcrowding, misplacement, missing structure during design work.
- The **Tech Lead** encounters issues during implementation — specs reference scattered knowledge, or decomposition doesn't match natural boundaries.
- The **Auditor** evaluates hierarchy health as part of process health — is the tree serving sessions efficiently?

The Human Lead owns the tree shape. AI stances propose; the human confirms, redirects, or restructures.
