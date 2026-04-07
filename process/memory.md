# The Memory Model

> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Conventions | [conventions.md](./conventions.md) |
> | Workflow | [workflow.md](./workflow.md) |

AI-Lore gives your project durable memory. This is the central mechanism — everything else in the methodology serves it. Without persistent memory, every AI session starts from zero. With it, session 10 benefits from every lesson learned in sessions 1 through 9.

The memory model has an **entry point** and **three layers**:

| Component | Role | Required |
|---|---|---|
| **Status** | Entry point — where every session starts. Current state, active focus, mode. | Yes |
| **Journal** | Continuity wire — session records and handovers. | Yes |
| **Action Tree** | Intention — work decomposition for complex focuses. | Optional |
| **Knowledge Tree** | Long-term memory — curated knowledge that compounds. | Optional |

```
.ai-lore/memory/
├── status/                        ← entry point
│   ├── status.md                  ← live pointer: active focus, mode, last journal
│   └── focus/                     ← focus files (one per active focus)
│       ├── current-focus.md
│       └── archive/
├── journal/                       ← layer 1: continuity
│   ├── live/                      ← current session files
│   └── archive/                   ← processed sessions
├── action-tree/                   ← layer 2: intention (optional)
│   ├── action-tree.index.md       ← structural overview
│   └── archive/
└── knowledge-tree/                ← layer 3: long-term memory (optional)
    ├── knowledge-tree.index.md    ← root index, points to the three branches
    ├── curated/                   ← durable insights by area
    ├── notepad/                   ← action-scoped scratch space
    └── payload/                   ← product description, plugin-defined
```

The structural conventions that all components share — the typed file system, the index navigation grammar, reference headers, and hierarchy discipline — are defined in [conventions.md](./conventions.md). These conventions are designed for token efficiency: indexes tell the AI what to load and in what order, reference headers declare dependencies, and hierarchy discipline keeps trees shallow. The result is that sessions load less and orient faster as the project matures. See [principles.md — Token Efficiency by Design](./principles.md#token-efficiency-by-design).

---

## Status — The Entry Point

Every session starts here. Every project has one, regardless of domain, complexity, or which memory layers it uses. Status is not a memory layer — it's above them, the front door to the project.

**`status.md`** is the live pointer — the project's current state:

- **Active focus** — which focus file is current, or headless with a brief description
- **Mode** — Planning, Executing, or Reflecting (when focused); absent when headless
- **Last journal** — link to the most recent session entry

The `focus/` subfolder holds one file per focus. Each focus file carries a gate, a mode, a state pointer, and context links. Focuses stack for interrupts and archive on completion. See [focus.md](./focus.md) for the full definition and [workflow.md](./workflow.md) for how focuses are orchestrated.

status.md is mutable — updated every session. It tracks current state, not history. The journal is the historical record.

---

## The Journal — Continuity Wire

The journal (`journal/`) is the session-to-session continuity wire. Each session produces a single file that captures what happened, links to artifacts created elsewhere, and carries the handover — telling the next session where work was left. See [journaling.md](./journaling.md).

Two subfolders: `live/` for current sessions, `archive/` for processed ones. Processing is on-demand — the human triggers it.

The journal is mandatory. Even the simplest project benefits from session continuity through handovers. This is the minimum viable memory.

---

## The Action Tree — Intention

The action tree (`action-tree/`) captures what you intend to do — work in progress, decomposed into trackable units. Each node carries its own completion criteria. When an action completes, its subtree moves to `archive/` and insights worth keeping migrate to the knowledge tree.

The AT is intentionally lightweight. It holds intention, status, and gates — never design knowledge, analysis, or context documents. All knowledge lives in the knowledge tree from day one, referenced from the AT via pointers. This separation keeps the AT cheap to reshape (see [updating-trees.md — Reconciliation](./updating-trees.md#reconciliation)) and ensures knowledge survives action archival.

The AT is optional infrastructure — powerful when a focus needs decomposition into tracked stages, absent when it doesn't. See [action-tree.md](./action-tree.md).

---

## The Knowledge Tree — Long-Term Memory

The knowledge tree (`knowledge-tree/`) holds all persistent knowledge. It has three branches, all present from project bootstrapping:

| Branch | Function |
|---|---|
| **Curated** | Durable, structured insights — patterns, decisions, techniques, constraints. Grows organically as work touches new areas. |
| **Notepad** | Unstructured observations captured in-flight — things noticed during execution that don't yet belong in a curated node. Low-friction intake. |
| **Payload** | How the product itself is structured. Core defines that this branch exists; the plugin defines its shape (an SDLC project's payload looks nothing like a TTRPG campaign's). |

The KT is optional infrastructure — but it's where the compound curve lives. Without it, sessions still have continuity (journal), but they don't accumulate domain knowledge. See [knowledge-tree.md](./knowledge-tree.md).

---

## How Memory Flows

```
┌─────────────────────────────────────────────────────┐
│                     STATUS                           │
│                                                      │
│  Every session reads status.md first.               │
│  Active focus, mode, last journal — the front door. │
│                                                      │
└────────────────────┬─────────────────────────────────┘
                     │
                     │  Points to:
                     │
                     ▼
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
│  Optional      │  │  Payload — product structure      │
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

- **Every session** — starts at status, reads the journal handover to orient, then works. The journal captures what happens during the session.
- **On demand** — the human triggers journal processing. Review `journal/live/`, extract decisions and insights to the appropriate tree, move processed files to `journal/archive/`.
- **On action completion** — journal entries from the action are reviewed. Insights worth keeping migrate to the knowledge tree. The action subtree moves to `archive/`.
