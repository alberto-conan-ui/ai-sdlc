# The Action Tree

> **References**
>
> | Group | File |
> |---|---|
> | Memory model | [memory.md](./memory.md) |
> | Recording system | [journaling.md](./journaling.md) |
> | Workflow | [workflow.md](./workflow.md) |

The action tree (`action-tree/`) is the project's short-term memory — what you're doing right now. It holds the work in progress: topics being planned, phases being executed, tasks being knocked off. When an action completes, the subtree moves to `archive/` and any insights worth keeping (flagged in the journal) migrate to the knowledge tree.

---

## Three Node Types

The action tree has three structural node types, following the typed file system convention defined in [memory.md](./memory.md).

### Topics

Topics are the Architect's unit. Strategic, organisational, outcome-oriented. A topic defines *what* needs to happen and *why*, without specifying *how*.

Gatekeeps on topics are abstract and outcome-oriented: "repo public, quickstart in repo, launch post live." Topics can nest sub-topics and can contain phases and tasks. The Architect and Human Lead design topics together.

Folder naming: `N.topic.name/` (e.g., `1.topic.auth-redesign/`).

### Phases

Phases are the execution unit. Planned by the Architect, implemented by the Tech Lead. Each phase has a spec (the index file) with a clear goal, concrete steps, and done criteria.

Gatekeeps on phases are practical and verification-oriented: "migration script passes, tests green, no regressions." Phases can nest sub-phases and can contain tasks, but cannot contain topics.

Folder naming: `N.phase.name/` (e.g., `1.phase.audit-endpoints/`).

### Tasks

Tasks are the lightweight unit — quick wins that don't need a folder, a spec, or a gatekeep. A task is a single file: `N.task.name.md`. It contains a brief description of what needs doing and is marked complete in `status.md` when done.

Tasks can live anywhere: at the AT root (standalone quick wins), inside a topic (small things discovered while working), or inside a phase (a sub-step worth tracking but not worth a sub-phase). Tasks are always leaves — they hold nothing.

File naming: `N.task.name.md` (e.g., `3.task.update-env-docs.md`).

Tasks follow the same lifecycle as everything else — numbered, journaled, and archived on completion. The only difference is weight: no folder, no children, no gatekeep.

### The containment rule

Topics can hold topics, phases, or tasks. Phases can hold phases or tasks. Tasks hold nothing — they are always leaves. The direction is always strategic → executable → atomic.

```
1.topic.auth-redesign/              ← strategic: "redesign the auth flow"
├── 1.phase.audit-endpoints/        ← executable: bounded work
├── 2.phase.new-token-model/        ← executable: bounded work
├── 3.phase.migrate-sessions/       ← executable: bounded work
└── 4.task.update-env-docs.md       ← atomic: quick win
```

A topic with sub-topics:

```
1.topic.platform-v2/                ← strategic umbrella
├── 1.topic.auth-redesign/          ← strategic sub-area
│   ├── 1.phase.audit-endpoints/
│   └── 2.phase.new-token-model/
├── 2.topic.api-modernisation/      ← strategic sub-area
│   ├── 1.phase.openapi-spec/
│   └── 2.phase.versioning/
└── 3.task.update-readme.md         ← quick win inside the umbrella
```

### When to use which

Most work starts as a topic with phases inside it. Use a bare phase at the root for simple, bounded work that doesn't need strategic framing — a bug fix, a config change, a quick improvement. Use a task for the simplest things — a one-off fix, a quick update, anything that can be described and completed in a single sitting.

If you're unsure, start with a topic. You can always simplify later.

---

## Node Files

Every node follows the `[name].[type].md` convention. Only `[name].index.md` and `[name].gatekeep.md` are required for topics. For phases, only `[name].index.md` is required (the index IS the spec). Tasks are a single file. Everything else is created when useful.

### For topics

| File | Purpose |
|---|---|
| `name.index.md` | **Required.** What this topic is about, its children, how they relate. |
| `name.gatekeep.md` | **Required.** Completion criteria — what "done" means for this topic. |
| `name.context.md` | Links to relevant knowledge tree nodes. The bridge between what you're doing (AT) and what you know (KT). |

All session narrative — what happened, decisions made, insights — goes to the journal (`journal/live/`). The action tree holds structure, not narrative. See [journaling.md](./journaling.md).

### For phases

| File | Purpose |
|---|---|
| `name.index.md` | **Required.** The phase spec: goal, steps, test cases, done criteria. This IS the spec — no separate file needed. |

A phase's index file serves double duty: it's both the folder's authority file and the execution spec. The Architect writes it; the Tech Lead implements from it.

### For tasks

A task is a single file: `N.task.name.md`. It contains a brief description of what needs doing — no spec structure required. The task is marked complete in `status.md` and archived like everything else.

---

## Gatekeeping

Every topic has a `[name].gatekeep.md`. Phases define their done criteria within their index (the spec). At every level, you can answer "is this done?"

**For a leaf topic or bare phase,** the gatekeep is whatever "done" means for that work. Concrete ("the date format matches ISO 8601") or subjective ("I'm satisfied the flow is clear"). The Human Lead decides what kind of gatekeep fits.

**For a branch topic,** the gatekeep has two parts: all children pass their own gatekeeps, AND the branch's own gatekeep passes. The branch gatekeep can be stricter than the sum of its children — "all three phases work" is necessary but the branch gatekeep might add "and they integrate cleanly."

**Status is computable.** Walk the tree from the leaves up. Each leaf is either done or not. Each branch is done when all children are done and its own gatekeep passes.

### When gatekeeps are unclear

If you cannot write a gatekeep, the scope is probably wrong. Refine until "done" is articulable — even if that means "I'll know it when I see it, and here's roughly what I'm looking for."

---

## The Active Stack

A push/pop model that tracks what you're working on and the path you took to get there.

**Push** when you start working on a node. **Pop** when you're done or switching away. The stack is readable — it tells you where you are now and the order you got there. `status.md` tracks the stack.

The stack works across trees (interrupt `auth-redesign` for a critical bug fix) and within trees (push from a topic into one of its phases). This mirrors how humans actually work: depth-first with interruptions. The stack makes interruptions traceable.

```
Stack (top = current):
  → auth-redesign/new-token-model    (TL implementing phase 2)
  → auth-redesign                     (planned 3 phases, started first two)
```

An interrupt pushes onto the stack:

```
Stack (top = current):
  → fix-csv-date-format              (critical bug — just came in)
  → auth-redesign/new-token-model    (paused mid-phase)
  → auth-redesign                     (paused — phases in progress)
```

After the fix, pop back:

```
Stack (top = current):
  → auth-redesign/new-token-model    (resuming phase 2)
  → auth-redesign                     (phases in progress)
```

---

## The AT Root: Index + Status

The action tree's root folder has two orientation files:

**`action-tree.index.md`** — the structural overview. The full tree with status for each node, dependencies, and cross-action relationships. Updated when nodes are added, completed, or restructured.

**`status.md`** — the live pointer. Current state, active stack, SDLC version, and a "what to do next" narrative. Updated every session — this is what every session reads first.

These are the only files in the memory system that genuinely mutate — they're live pointers to the project's current state. Everything else is append-forward.

---

## Growing the Tree

The tree grows organically. You don't scaffold a deep hierarchy upfront.

**Starting simple.** Most work starts as a topic folder with a gatekeep and one or two phases. If the work stays simple, the topic stays shallow. No overhead.

**Adding phases.** As work progresses, the Architect and Human Lead design new phases. Each phase gets its own folder with a spec (the index file). Phases are numbered for sequence.

**Decomposing topics.** When a topic's scope grows, it can gain sub-topics. The original topic becomes a strategic umbrella; the sub-topics get their own gatekeeps and phases.

There's no promotion mechanic, no ceremony. The tree IS the record of how the work evolved.

---

## Action Completion

When an action is done — its gatekeep passes:

1. Review journal entries from the action. Anything flagged as insightful and worth keeping migrates to the appropriate knowledge tree node.
2. The action subtree moves to `archive/`. The full record goes together.
3. `status.md` and `action-tree.index.md` update — action popped from the stack, status marked achieved.
4. The journal gets a completion note if relevant.

For branch topics, completion means all children are done and the branch gatekeep passes. You can archive children individually as they finish, or the entire subtree at once.

---

## Archiving

Completed subtrees move to `archive/`. This keeps the active tree clean — only in-progress and pending work lives at the top level. The archive preserves the full record: specs, gatekeeps, context files, tasks — everything.

The knowledge the action produced already lives in the knowledge tree. The archive is the append-forward historical record — if you need to understand why a decision was made or how work evolved, the archive and journal together tell the story.
