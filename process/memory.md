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

### The Journal — Continuity Wire

The journal (`journal/`) is the session-to-session continuity wire. Each session produces a single file in `journal/live/`, named by date and session number (e.g., `2026-03-19_02.md`). The file contains header metadata (date, stance, mode, active action), the session narrative, and a handover section for the next session. See [journaling.md](./journaling.md) for the full structure.

Two subfolders: `live/` for current session files, `archive/` for processed ones. Processing is on-demand — the Human Lead triggers it by asking the Architect to review `live/` and extract what belongs in the trees. Processed files move to `archive/`.

The journal records what happened, links to artifacts created elsewhere (AT, KT), and carries the handover — telling the next session where work was left. The journal complements status.md: status.md says where the project stands, the handover says where this thread of work was left.

### The Action Tree — Intention

The action tree (`action-tree/`) captures what you intend to do — work in progress, decomposed into trackable units. Each node carries its own completion criteria. When an action completes, its subtree moves to `archive/` and any insights worth keeping migrate to the knowledge tree.

The AT is intentionally lightweight. It holds intention, status, and gatekeeps — never design knowledge, analysis, or context documents. All knowledge lives in the knowledge tree from day one, referenced from the AT via pointers. This separation keeps the AT cheap to reshape (see [updating-trees.md — Reconciliation](./updating-trees.md#reconciliation)) and ensures knowledge survives action archival.

See [action-tree.md](./action-tree.md) for the full structure.

### The Knowledge Tree — Long-Term Memory

The knowledge tree (`knowledge-tree/`) holds all persistent knowledge. It has three branches, all present from project bootstrapping:

| Branch | Function |
|---|---|
| **Curated** | Durable, structured insights at the right node — patterns, decisions, techniques, architectural constraints. Grows organically as work touches new areas. |
| **Notepad** | Unstructured observations captured in-flight — things noticed during execution that don't yet belong in a curated node. Low-friction intake that removes pressure to route prematurely. |
| **Payload** | How the product itself is structured — project files, conventions, organization. Core defines that this branch exists; the plugin defines its structure (an SDLC project's payload looks nothing like a TTRPG campaign's). |

The curated branch is where knowledge lives permanently. The notepad is where observations land before they're ready to be curated — on action completion, durable findings migrate from the notepad to curated nodes. The payload branch describes the thing being built, not knowledge about how to build it.

See [knowledge-tree.md](./knowledge-tree.md) for the structural guide.

---

## How Memory Flows

```
┌─────────────────────────────────────────────────────┐
│                     JOURNAL                          │
│                                                      │
│  Sessions produce files in journal/live/:            │
│    • What happened (links to artifacts)              │
│    • Decisions made                                  │
│    • Handover for the next session                   │
│                                                      │
└────────────────────┬─────────────────────────────────┘
                     │
                     │  On demand (human triggers):
                     │  review live journal,
                     │  extract to the right tree,
                     │  processed entries → journal/archive/
                     │
            ┌────────┴────────┐
            ▼                 ▼
┌────────────────┐  ┌──────────────────────────────────┐
│  ACTION TREE   │  │       KNOWLEDGE TREE              │
│                │  │                                    │
│  Intention     │  │  Curated — durable insights       │
│  Lightweight   │  │  Notepad — in-flight observations │
│  Temporary     │  │  Payload — product structure      │
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

- **During sessions** — the journal captures what happens. Knowledge may also be written directly to the KT when an insight is immediately clear and well-placed.
- **On demand** — the human triggers journal processing. Review `journal/live/`, extract decisions and insights to the appropriate tree, move processed files to `journal/archive/`.
- **On action completion** — journal entries from the action are reviewed. Insights worth keeping migrate to the knowledge tree. The action subtree moves to `archive/`.

---

## The Index — Navigation Primitive

The index file is the core mechanism of the memory model. Every orientation decision the AI makes flows through an index. When the AI enters a folder, it reads the index. When it needs to decide what to load next, it follows links from the index. The index is not a bureaucratic requirement — it's the interface between the AI and the project's memory.

Every folder has `[folder-name].index.md`. No exceptions. The index uses a three-section navigation grammar:

**References** — external context this folder depends on. The parent index, relevant knowledge tree nodes, relevant journal entries. References point up and sideways — they tell the AI what else it needs to understand this node. References appear on all files (not just indexes), but they're the first section of every index.

**Siblings** — typed companion files in the same folder. Siblings are listed with a brief role description so the AI knows what each file contributes without opening it.

**Children** — nodes below this one in the hierarchy. Child folders or files, listed with brief descriptions. Children are the downward navigation path — the AI follows them when the task requires going deeper.

The grammar is the same everywhere: AT indexes, KT indexes, journal indexes. The AI uses the same pattern to navigate: find the index, read References to understand context, scan Siblings to see companion files, scan Children to decide whether to go deeper.

---

## The Typed File System

Every file in the memory system follows one naming convention: **`[name].[type].md`**. The type suffix tells you what the file is without opening it. See [action-tree.md](./action-tree.md) and [knowledge-tree.md](./knowledge-tree.md) for the valid types and naming conventions in each tree.

---

## Reference Headers

Every file in the memory system has a reference header that declares its dependencies — what other files need to be read to understand this one. Content lives in exactly one place; references point to it. In index files, this is the References section of the navigation grammar (see [The Index — Navigation Primitive](#the-index--navigation-primitive)). In non-index files, it serves the same purpose: declare what the reader needs to load for context.

```markdown
> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Parent context | [../parent.index.md](../parent.index.md) |
```

Conventions: groups are labeled (why the reference matters), ordered by importance (reading strategy for the AI), and point up and sideways (downward traversal is implicit — the AI reads children when the task requires it).

When a file moves, update the references that point to it. Single-source means there's nothing else to update.

---

## Hierarchy Discipline

Well-structured trees keep references short and navigation efficient. This is a human responsibility — the process signals when the hierarchy is degraded, but only the human decides how to restructure.

### What makes a good node

A node earns its folder when it has a distinct concern that's loaded independently. In the KT, that means the information is needed for work in this area but not in sibling areas. In the AT, that means the work has its own completion criteria and its own lifecycle.

### Signals the hierarchy needs attention

- A file exceeds ~200 lines — split into children.
- A folder has more than 5–7 direct children — add intermediate grouping.
- A reference header has more than 4–5 entries — the hierarchy isn't carrying enough context implicitly.
- The same information appears in multiple siblings — cross-cutting concern should move up.

The Human Lead owns the tree shape. AI stances propose; the human confirms, redirects, or restructures.

