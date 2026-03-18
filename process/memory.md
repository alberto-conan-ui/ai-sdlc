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

The journal (`journal/`) is the intake buffer. A flat, chronological stream of session records — what happened, what was decided, what was observed. One file per session, named by date and session number (e.g., `2026-03-17_01.md`). No hierarchy, no tags, no structure beyond completeness.

Two subfolders: `live/` for current entries, `archive/` for processed ones. Processing is on-demand — the Human Lead triggers it by asking the Architect to review `live/` and extract what belongs in the trees. Processed entries move to `archive/`.

The journal is not a lesser version of the trees. It exists because there's a real gap between "something just happened" and "this belongs in a tree." The journal removes the pressure to route prematurely.

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

## The Typed File System

Every file in the memory system follows one naming convention: **`[name].[type].md`**. The type suffix tells you what the file is without opening it.

### Valid types

| Type | Purpose | Used in |
|---|---|---|
| `index` | Mandatory authority file for every folder. Describes the folder's purpose and lists its contents. | All trees, all folders |
| `spec` | Curated knowledge — patterns, insights, architectural decisions. | Knowledge tree |
| `gatekeep` | Completion criteria — what "done" means. | Action tree |
| `context` | What an action is about + pointers to relevant knowledge tree nodes. | Action tree |
| `task` | Lightweight single-file action — a quick win that doesn't need a folder. | Action tree |

### The mandatory index

Every folder has `[folder-name].index.md`. No exceptions. The index describes the folder's purpose and lists its contents — sibling typed files and child folders. This is the entry point for any AI loading this folder.

A KT leaf node has `caching-strategy.index.md` and nothing else — the index IS the content. An action node has `process-redesign.index.md` plus `process-redesign.gatekeep.md` and `process-redesign.context.md` — the index describes the action and references its typed companions. A task is a single file (`N.task.name.md`) that needs no folder or companions.

### Naming in the Action Tree

The action tree uses typed names to distinguish topics, phases, and tasks:

```
action-tree/
├── action-tree.index.md
├── status.md
├── 1.topic.auth-redesign/
│   ├── auth-redesign.index.md
│   ├── auth-redesign.gatekeep.md
│   ├── auth-redesign.context.md
│   ├── 1.phase.audit-endpoints/
│   │   └── audit-endpoints.index.md
│   ├── 2.phase.new-token-model/
│   │   └── new-token-model.index.md
│   ├── 3.phase.migrate-sessions/
│   │   └── migrate-sessions.index.md
│   └── 4.task.update-env-docs.md
└── archive/
```

Order prefixes (`1.`, `2.`) are local to the folder — no cascading parent prefixes. The type (`topic`, `phase`, or `task`) is declared in the name. Folders contain files following `[name].[type].md`. Tasks are single files — no folder needed.

### What about simple actions?

A simple fix that doesn't need strategic decomposition can be a single phase at the root:

```
action-tree/
├── action-tree.index.md
├── status.md
├── 1.phase.fix-csv-date-format/
│   └── fix-csv-date-format.index.md
```

Even simpler — a task at the root:

```
action-tree/
├── action-tree.index.md
├── status.md
├── 1.task.fix-csv-date-format.md
```

No topic wrapper, no folder needed. The numbering keeps order; the type keeps clarity. Only create structure you need.

---

## Reference Headers

Every file in the memory system has a reference header that declares its dependencies — what other files need to be read to understand this one. Content lives in exactly one place; references point to it.

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
