# Memory

Memory is the project's durable record. Without it, every AI session starts from zero; with it, session 10 benefits from everything sessions 1 through 9 learned.

This file is the index of the memory layer: what the components are, which are mandatory, and how memory flows across sessions. The mechanics of each component live in its own sub-pillar, cited below.

## The five components

`{lore_dir}/memory/` holds five components, three mandatory and two optional:

| Component          | Role                                                             | Required |
| ------------------ | ---------------------------------------------------------------- | -------- |
| **Status**         | Entry point — where every session starts. Thin tracker.          | Yes      |
| **Journal**        | Continuity wire — session records and handovers.                 | Yes      |
| **Blueprint**      | Production rules and standing contracts for the Payload.         | Yes      |
| **Action tree**    | Intention — decomposition for focuses too large for one tracker. | Optional |
| **Knowledge tree** | Long-term learning — curated insights that compound.             | Optional |

```
{lore_dir}/memory/
├── memory.index.md                ← navigation root
├── status/                        ← entry point
│   ├── status.index.md
│   └── focus/
│       └── focus.index.md
├── journal/                       ← continuity
│   ├── journal.index.md
│   ├── live/
│   │   └── live.index.md
│   └── archive/
│       └── archive.index.md
├── blueprint/                     ← production rules + contracts
│   └── blueprint.index.md
├── action-tree/                   ← intention, optional
│   └── action-tree.index.md
└── knowledge-tree/                ← long-term learning, optional
    ├── knowledge-tree.index.md
    ├── reconciled/
    │   └── reconciled.index.md
    ├── working/
    │   └── working.index.md
    └── notepad/
        └── notepad.index.md
```

Every folder under `memory/` carries its own `[folder-name].index.md` without exception — the shape honors tree-discipline's index-per-folder rule uniformly across all memory components.

Status, journal, and blueprint are mandatory — without them, continuity and production are broken. Status orients the session, the journal hands the work over between sessions, and the blueprint tells the session what the Payload must honor. Action tree and knowledge tree are optional infrastructure: present when the work needs tracked decomposition or accumulated learning, absent when it doesn't. A simple project runs on status + journal + blueprint.

**Across all five components, emptiness is a valid state.** An empty knowledge tree, an absent action tree, a blueprint with placeholder-only sections — none of these are gaps. They mean the project has not yet committed to anything in that area. Memory grows organically as commitments accumulate; nothing is required to be populated for a project to operate. The session reads what is there at face value and does not flag absence as non-compliance.

**Status and focus** are covered by the [Tracker pillar](../tracker/tracker.index.md) — both are instances of the tracker primitive. **Journal mechanics** (session files, handover protocol, rolling) live in the [Journal sub-pillar](./journal.md). **Production rules and contracts** live in the [Blueprint sub-pillar](./blueprint.md). **Knowledge tree branches** (reconciled, working, notepad) live in the [Knowledge tree sub-pillar](./knowledge-tree.md). **Action tree mechanics** (node types, growing, archival) live in the [Action tree sub-pillar](./action-tree.md). **Index grammar, reference headers, naming, linking, append-forward** — the rules that keep any memory tree navigable — live in the [Tree discipline sub-pillar](./tree-discipline.md).

## How Memory loads

The Memory pillar has five sub-pillars. They split into a mandatory spine that loads with the pillar and two optional leaves loaded only when the work touches them.

**Mandatory spine — loaded with `memory.index.md`:**

- [`journal.md`](./journal.md) — every session opens and closes against the journal protocol, so it must be in context from the start.
- [`tree-discipline.md`](./tree-discipline.md) — every write into any memory tree follows these rules, so it must be in context from the start.
- [`blueprint.md`](./blueprint.md) — every session reads the project's production rules and standing contracts at open, so it must be in context from the start.

**Load on demand — loaded when the work touches them:**

- [`knowledge-tree.md`](./knowledge-tree.md) — loaded when the session reads or writes the knowledge tree.
- [`action-tree.md`](./action-tree.md) — loaded when the active focus uses an action tree.

A session that never touches the KT or an AT-decomposed focus runs on the spine (`memory.index.md` + `journal.md` + `tree-discipline.md` + `blueprint.md`) and nothing else from this subtree. The two optional sub-pillars enter context only when the current work demands them.

## Where things live

A session writes into three places as work happens. The boundaries:

- **The journal** — temporal narrative. What happened in this session: decisions, blockers, process notes. One file per session.
- **The notepad** — focus-scoped observations. What was noticed during execution that doesn't belong in the temporal record or in curated KT nodes yet. One node per focus.
- **The knowledge tree** — curated, durable insights. What will matter to future sessions. Organized by topic.

The action tree holds intention and gates — never narrative, observations, or design knowledge.

Once content lives somewhere in memory, [verbs](../operating-rules.md#verbs) are how the Human Lead operates on it — reshape a trusted body whose shape has drifted, rewrite one that can no longer be carried forward, digest one whose trust is in question.

