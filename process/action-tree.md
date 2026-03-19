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

## Node Types

The action tree has five node types, following the typed file system convention defined in [memory.md](./memory.md). Every node is defined by two properties: whether it's a **container** (folder with children) or a **leaf** (single file), and whether it has a **gatekeep** (explicit completion criteria verified by the Human Lead).

| Type | Container | Gatekept | Gatekeep nature |
|---|---|---|---|
| Goal | yes | yes | Strategic — abstract real-world outcomes, human-judged |
| Topic | yes | yes | Strategic — scoped to an area, tangible but broad |
| Phase | yes | yes | Technical — implementation correctness (tests pass, builds, no lint errors) |
| Step | yes | no | — |
| Task | no | no | — |

**Container** nodes are folders. They have an index file, can hold children, and represent a scope of work that decomposes further. **Leaf** nodes are single files — atomic, no children, no folder.

**Gatekept** nodes have explicit completion criteria. The gatekeep nature distinguishes two kinds: strategic gatekeeps (goals, topics) verify real-world outcomes and require human judgment — "repo public, quickstart works, launch post live." Technical gatekeeps (phases) verify implementation correctness and are largely mechanically verifiable — "migration script passes, tests green, no regressions." Ungatkept nodes (steps, tasks) are covered by their parent's gatekeep.

### Goals and Topics — strategic containers (gatekept)

Goals and topics are the same structurally — all rules apply identically. Use "goal" (`N.goal.name/`) when the node represents a top-level objective. Use "topic" (`N.topic.name/`) when it represents a strategic area of concern. The choice is cosmetic.

They define *what* needs to happen and *why*, without specifying *how*. Goals and topics can nest sub-goals/topics, phases, steps, and tasks. The Architect and Human Lead design them together.

Folder naming: `N.goal.name/` or `N.topic.name/` (e.g., `1.topic.auth-redesign/`, `2.goal.v021-release/`).

### Phases — execution containers (gatekept)

Phases are bounded work with independently verifiable outcomes. Each phase has a spec (the index file) with a clear goal, concrete steps, and done criteria. Phases can nest sub-phases, steps, and tasks, but cannot contain goals or topics.

Folder naming: `N.phase.name/` (e.g., `1.phase.audit-endpoints/`).

### Steps — structural containers (ungatkept)

Steps break a parent into manageable chunks without introducing their own gatekeep. A step has the same folder structure as any other container — a folder with an index, able to hold children — but no gatekeep file. Only the parent's gatekeep matters.

The insight: gatekeeps should verify real-world effects, not restate work as checkbox items. Forcing a gatekeep onto every decomposition level produces meaningless checklists and dilutes what a gatekeep means. Steps exist to decompose; goals, topics, and phases exist to verify.

Steps can hold steps or tasks. They cannot contain goals, topics, or phases.

Folder naming: `N.step.name/` (e.g., `1.step.interaction-modes/`).

### Tasks — leaves (ungatkept)

Tasks are the lightweight unit — quick wins that don't need a folder, a spec, or a gatekeep. A task is a single file: `N.task.name.md`. It contains a brief description of what needs doing.

Tasks can live anywhere: at the AT root (standalone quick wins), inside any node type (small things discovered while working). Tasks are always leaves — they hold nothing.

File naming: `N.task.name.md` (e.g., `3.task.update-env-docs.md`).

Tasks follow the same lifecycle as everything else — numbered, journaled, and archived on completion. The only difference is weight: no folder, no children, no gatekeep.

Inside a task, the full stance pipeline doesn't apply. Any stance can do the whole job — the Architect can write code, the Tech Lead can make a design call. Interaction modes still apply (you're still either shaping or executing). Workflow stages and stance handoffs don't. Tasks are the lightweight escape valve for small changes that don't warrant ceremony.

### The containment rule

Goals/topics can hold goals/topics, phases, steps, or tasks. Phases can hold phases, steps, or tasks. Steps can hold steps or tasks. Tasks hold nothing — they are always leaves. The direction is always strategic → executable → decomposition → atomic.

```
2.goal.v021-release/                ← strategic: "ship v0.21 changes"
├── 1.step.interaction-modes/       ← decomposition: structural chunk
├── 2.step.index-architecture/      ← decomposition: structural chunk
├── 3.step.journal-evolution/       ← decomposition: structural chunk
└── 4.task.version-bump.md          ← atomic: quick win
```

A topic with phases:

```
1.topic.auth-redesign/              ← strategic: "redesign the auth flow"
├── 1.phase.audit-endpoints/        ← executable: bounded work with gatekeep
├── 2.phase.new-token-model/        ← executable: bounded work with gatekeep
├── 3.phase.migrate-sessions/       ← executable: bounded work with gatekeep
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

Most work starts as a goal or topic. Use phases inside them for bounded work that needs its own gatekeep — independently verifiable outcomes. Use steps inside them for structural decomposition that doesn't need independent verification — the parent's gatekeep covers the whole. Use a bare phase at the root for simple, bounded work that doesn't need strategic framing. Use a task for the simplest things — a one-off fix, a quick update, anything that can be described and completed in a single sitting.

If you're unsure whether something is a phase or a step, ask: "Does this chunk produce an independently verifiable result?" If yes, it's a phase. If it's just a manageable piece of a bigger whole, it's a step.

---

## Node Files

Every node follows the `[name].[type].md` convention. The index file is always the entry point — the navigation primitive described in [memory.md](./memory.md#the-index--navigation-primitive). All session narrative goes to the journal; the action tree holds structure, not narrative. See [journaling.md](./journaling.md).

### For goals and topics

| File | Purpose |
|---|---|
| `name.index.md` | **Required.** What this goal/topic is about. References, siblings, children. |
| `name.gatekeep.md` | **Required.** Completion criteria — what "done" means. |
| `name.context.md` | Links to relevant knowledge tree nodes. The bridge between what you're doing (AT) and what you know (KT). |
| `name.spec.md` | Design specification — the detailed plan when the index overview isn't enough. |

### For phases

| File | Purpose |
|---|---|
| `name.index.md` | **Required.** The phase spec: goal, steps, test cases, done criteria. This IS the spec — no separate file needed. |
| `name.gatekeep.md` | Done criteria, if complex enough to warrant a separate file. Otherwise, done criteria live in the index. |

A phase's index file serves double duty: it's the folder's navigation entry point and the execution spec. The Architect writes it; the Tech Lead implements from it.

### For steps

| File | Purpose |
|---|---|
| `name.index.md` | **Required.** What this step covers, its children. |
| `name.spec.md` | Change spec — what to modify and how. Created when the step's scope warrants detailed planning. |

Steps have no gatekeep file. The parent's gatekeep covers the entire decomposition.

### For tasks

A task is a single file: `N.task.name.md`. It contains a brief description of what needs doing — no spec structure required. Tasks are tracked in `status.md` and archived like everything else.

---

## Gatekeeping

Goals, topics, and phases have gatekeeps. Steps and tasks do not.

Every goal/topic has a `[name].gatekeep.md`. Phases define their done criteria within their index (the spec), or in a separate gatekeep file for complex cases. Steps have no gatekeep — the parent's gatekeep covers the entire decomposition. At every gatekept level, you can answer "is this done?"

**For a leaf goal/topic or bare phase,** the gatekeep is whatever "done" means for that work. Concrete ("the date format matches ISO 8601") or subjective ("I'm satisfied the flow is clear"). The Human Lead decides what kind of gatekeep fits.

**For a branch goal/topic,** the gatekeep has two parts: all children pass their own gatekeeps, AND the branch's own gatekeep passes. The branch gatekeep can be stricter than the sum of its children — "all three phases work" is necessary but the branch gatekeep might add "and they integrate cleanly."

**Steps are covered by their parent.** A goal decomposed into steps has one gatekeep — the goal's. When verifying completion, the question is whether the goal's gatekeep passes, not whether each step is "done." Steps are a convenience for organising work, not a verification boundary.

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

**`status.md`** — the live pointer. Updated every session — this is what every session reads first. It contains:

- **Current state** — a table with SDLC version, mode (Planning or Executing), active action, and next step. Followed by a plain-language "where we are" summary and a relevant journal link.
- **Active action** — shows the full hierarchy breadcrumb so the reader sees exactly where work is focused. Each node in the path is a clickable link to its index or file. Format: `Type N — [Name](link) / Type N — [Name](link) — Status`. Example: `Goal 3 — [v0.21 Process Polish](link) / Task 1 — [Strategist Review Fixes](link) — Review`.
- **Active stack** — the push/pop stack of what you're working on.
- **Relevant journal** — curated links to the journal sessions that provide the most useful context. Not chronological — selected for relevance. These link to specific session indexes or entries, and their handovers are the session continuity mechanism.
- **Next step** — what the next session should do first.
- **Project overview** — the full action tree with every node visible. Each node shows its type, a human-readable name linked to its index, and its status. Children are indented under their parent. Format: `Type N — [Name](link) — Status`. Example:
  ```
  - **Goal 2** — [v0.21 Feedback Release](link) — **Achieved**
    - Step 1 — [Interaction Modes](link) — Done
    - Step 2 — [Index Architecture](link) — Done
    - Task 6 — [Skeleton AT Review](link) — Done
  ```
- **History** — summary of completed or archived actions.

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
