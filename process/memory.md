---
type: process
audience: [human, ai]
depends_on: [principles.md]
---

# The Memory Model

> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Recording system | [journaling.md](./journaling.md) |
> | Action tree detail | [action-tree.md](./action-tree.md) |
> | Knowledge tree detail | [knowledge-tree.md](./knowledge-tree.md) |
> | Role definitions | [roles/](../roles/) |

AI-SDLC gives your project a durable memory through three complementary layers. This is the central mechanism — everything else in the methodology serves it. Without persistent memory, every AI session starts from zero. With it, session 10 benefits from every lesson learned in sessions 1 through 9.

---

## The Three Layers

The project memory holds three layers. They serve different purposes and follow different rules, but they feed each other continuously.

### The Journal — Temporal Intake

The journal (`journal/`) is the intake buffer. A flat, chronological stream of session records — what happened, what was decided, what was observed. One file per session, named by date and session number (e.g., `2026-03-17_01.md`). No hierarchy, no tags, no structure beyond completeness.

The journal has two subfolders:

- **`live/`** — current entries. Everything lands here first.
- **`archive/`** — processed entries. Once the Architect has reviewed a journal entry and extracted what belongs in the action tree or knowledge tree, the entry moves here.

The journal is NOT a lesser version of the trees. It's a different kind of memory — immediate, unfiltered, temporal. It exists because there's a real gap between "something just happened" and "this belongs in a tree." The previous process forced a premature routing decision; the journal removes that pressure.

Processing is on-demand. The human lead triggers it by asking the Architect to review the live journal and extract what belongs in the trees. This is a human responsibility — the process does not schedule it automatically.

### The Action Tree — Short-Term Memory

The action tree (`action-tree/`) holds the work in progress. Each action node carries the live state of the work: completion criteria, links to relevant knowledge, session logs, and phase specs. The action tree is temporary by design — when an action completes, its subtree moves to the action tree's own archive.

The action tree has its own archive subfolder:

- **`archive/`** — completed action subtrees. The full record moves here on completion.

See [action-tree.md](./action-tree.md) for the full tree structure, node files, gatekeeping model, and the active stack.

### The Knowledge Tree — Long-Term Memory

The knowledge tree (`knowledge-tree/`) is a folder hierarchy organised by the boundaries where different knowledge applies. Each node holds curated insights — patterns to follow, pitfalls to avoid, architectural decisions that constrain future work. The tree typically mirrors your codebase but also accommodates cross-cutting concerns.

Unlike the action tree, the knowledge tree is permanent and living. Insights get added, refined, moved to a different node, or retired. The tree grows organically as work takes you into different areas.

The knowledge tree has its own archive subfolder:

- **`archive/`** — retired insights and superseded structures. When an insight no longer applies or a node is restructured during migration, old content moves here.

See [knowledge-tree.md](./knowledge-tree.md) for the full structural guide.

---

## How Memory Flows

The three layers form a pipeline. Work produces raw material; the pipeline turns it into durable knowledge.

```
┌─────────────────────────────────────────────────────────┐
│                      JOURNAL                            │
│                                                         │
│  Sessions produce entries in journal/live/:              │
│    • What happened (session narrative)                  │
│    • Decisions made                                     │
│    • Observations and insights                          │
│                                                         │
└──────────────────────┬──────────────────────────────────┘
                       │
                       │  On demand (human triggers):
                       │  Architect reviews live journal,
                       │  extracts to the right tree,
                       │  processed entries → journal/archive/
                       │
              ┌────────┴────────┐
              ▼                 ▼
┌──────────────────┐  ┌──────────────────────────────────┐
│   ACTION TREE    │  │         KNOWLEDGE TREE            │
│                  │  │                                    │
│  Work-in-progress│  │  Curated, durable insights        │
│  Action-scoped   │  │  at the right structural node     │
│  Temporary       │  │  Permanent and living              │
│                  │  │                                    │
└────────┬─────────┘  └──────────────────────────────────┘
         │                          ▲
         │  On action completion:   │
         │  insights reviewed,      │
         │  worth-keeping migrate ──┘
         │  action → action-tree/archive/
         │
         ▼
```

The flow is continuous, not ceremonial. It happens as part of normal work:

- **During sessions** — the journal captures what happens. The Architect may also write directly to the knowledge tree when an insight is immediately clear and well-placed.
- **On demand** — the human triggers journal processing. The Architect reads `journal/live/`, extracts decisions and insights to the appropriate tree, and processed entries move to `journal/archive/`.
- **On action completion** — action-scoped insights are reviewed. Worth-keeping ones migrate to the knowledge tree. The action subtree moves to `action-tree/archive/`.

---

## Structural Conventions

### Reference Headers

Every file in the memory system has a metadata header that declares its dependencies — what other files need to be read to understand this one. This is the mechanism that prevents duplication: content lives in exactly one place, and references point to it.

The reference header appears as a table near the top of the file:

```markdown
> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Parent context | [../index.spec.md](../index.spec.md) |
> | Testing conventions | [testing/testing.spec.md](./testing/testing.spec.md) |
```

Conventions:

- **Groups are labeled** — each reference has a purpose label (e.g., "Foundation", "Parent context", "Testing conventions"). This tells the AI *why* a reference matters, not just that it exists.
- **Groups are ordered by importance** — the most critical references first. This gives the AI a reading strategy: what to load deeply vs. what to skim.
- **References point up and sideways** — to parents, siblings, and cross-cutting concerns. Downward traversal is implicit: the AI reads children when the task requires it, guided by the parent's description of its children.
- **YAML frontmatter `depends_on`** — the existing YAML frontmatter continues to declare technical dependencies for tooling. The reference header table is the human/AI-readable version with labels and ordering.

When a file moves, update the references that point to it. This is a mechanical task — a tier-3 model handles it in seconds. The single-source principle means there's nothing else to update (no duplicated content to find and fix).

### One File Per Folder (Action Tree and Knowledge Tree)

Every folder in the action tree and knowledge tree contains exactly one primary markdown file. That file is the authority for that level of the hierarchy. It describes:

1. What this node is about — its own content, the unique information at this level.
2. What its children are — a brief description of each child folder and what it covers.

If something deserves to exist as separate content, it gets its own child folder with its own file. No lateral sibling files within a folder.

When a file gets too long, that's the signal to split — create a child folder, move the specific concern down, replace it with a brief description in the parent.

**This does NOT apply to the journal**, which is a flat temporal structure with its own naming convention (`YYYY-MM-DD_NN.md` in `live/` and `archive/`).

**This does NOT apply to action tree node files that serve different purposes** — an action folder may contain `gatekeep.md`, `context.md`, `log.md`, and a `phases/` subfolder. These are different file types serving the action, not competing content at the same level.

### Hierarchy as Discipline

Well-structured trees keep references short and navigation efficient. If a node has too many children, it needs intermediate grouping. If a file has too many references in its header, the hierarchy isn't doing its job.

This is a human responsibility. The process can signal when the hierarchy is degraded (proliferating references, oversized files, nodes with too many children), but only the human can decide how to restructure.

---

## Recording Responsibilities

Memory maintenance is woven into every role's normal work. The specifics differ by stance, but the core pattern is shared: every role reads the relevant memory on session start and records what happens during the session.

For the full recording system — who writes what, the session checklists, and the recording anti-patterns — see [journaling.md](./journaling.md).
