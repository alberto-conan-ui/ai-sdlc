# SDLC Plugin — Action Tree Structure

> **Joins:** [action-tree.md](../../action-tree.md) — Addendum: load core AT first (containers, leaves, gates, numbering, completion), then layer this file for the five SDLC node types, containment rules, file templates, and gate taxonomy.
>
> **References**
>
> | Group | File |
> |---|---|
> | Core AT | [action-tree.md](../../action-tree.md) |
> | Conventions | [conventions.md](./conventions.md) |

Core AT defines containers, leaves, gates, numbering, and completion. This adds the five SDLC node types, containment rules, file templates, and gate taxonomy.

---

## Node Types

Five node types, built on the core's container/leaf and gated/ungated primitives:

| Type | Container | Gated | Gate nature |
|---|---|---|---|
| Goal | yes | yes | Strategic — abstract real-world outcomes, human-judged |
| Topic | yes | yes | Strategic — scoped to an area, tangible but broad |
| Phase | yes | yes | Technical — implementation correctness, verifiable outcomes |
| Step | yes | no | — |
| Task | no | no | — |

### Goals and Topics — strategic containers (gated)

Goals and topics are the same structurally — all rules apply identically. Use "goal" (`NN.goal.name/`) when the node represents a top-level objective. Use "topic" (`NN.topic.name/`) when it represents a strategic area of concern. The choice is cosmetic.

They define *what* needs to happen and *why*, without specifying *how*. Goals and topics can nest sub-goals/topics, phases, steps, and tasks.

Folder naming: `NN.goal.name/` or `NN.topic.name/` (e.g., `05.topic.auth-redesign/`, `10.goal.v021-release/`).

### Phases — execution containers (gated)

Phases are bounded work with independently verifiable outcomes. Each phase has a spec (the index file) with a clear goal, concrete steps, and done criteria. Phases can nest sub-phases, steps, and tasks, but cannot contain goals or topics.

Folder naming: `NN.phase.name/` (e.g., `05.phase.audit-endpoints/`).

### Steps — structural containers (ungated)

Steps break a parent into manageable chunks without introducing their own gate. A step has the same folder structure as any other container — a folder with an index, able to hold children — but no gate file. Only the parent's gate matters.

The insight: gates should verify real-world effects, not restate work as checkbox items. Forcing a gate onto every decomposition level produces meaningless checklists and dilutes what a gate means. Steps exist to decompose; goals, topics, and phases exist to verify.

Steps can hold steps or tasks. They cannot contain goals, topics, or phases.

Folder naming: `NN.step.name/` (e.g., `05.step.interaction-modes/`).

### Tasks — leaves (ungated)

Tasks are the lightweight unit — quick wins that don't need a folder, a spec, or a gate. A task is a single file: `NN.task.name.md`. It contains a brief description of what needs doing.

Tasks can live anywhere: at the AT root (standalone quick wins), inside any node type (small things discovered while working). Tasks are always leaves — they hold nothing.

File naming: `NN.task.name.md` (e.g., `15.task.update-env-docs.md`).

Tasks follow the same lifecycle as everything else — numbered, journaled, and archived on completion. The only difference is weight: no folder, no children, no gate.

---

## Containment Rules

Goals/topics can hold goals/topics, phases, steps, or tasks. Phases can hold phases, steps, or tasks. Steps can hold steps or tasks. Tasks hold nothing — they are always leaves. The direction is always strategic → executable → decomposition → atomic.

```
10.goal.v021-release/                ← strategic: "ship v0.21 changes"
├── 05.step.interaction-modes/       ← decomposition: structural chunk
├── 10.step.index-architecture/      ← decomposition: structural chunk
├── 15.step.journal-evolution/       ← decomposition: structural chunk
└── 20.task.version-bump.md          ← atomic: quick win
```

A topic with phases:

```
05.topic.auth-redesign/              ← strategic: "redesign the auth flow"
├── 05.phase.audit-endpoints/        ← executable: bounded work with gate
├── 10.phase.new-token-model/        ← executable: bounded work with gate
├── 15.phase.migrate-sessions/       ← executable: bounded work with gate
└── 20.task.update-env-docs.md       ← atomic: quick win
```

A topic with sub-topics:

```
05.topic.platform-v2/                ← strategic umbrella
├── 05.topic.auth-redesign/          ← strategic sub-area
│   ├── 05.phase.audit-endpoints/
│   └── 10.phase.new-token-model/
├── 10.topic.api-modernisation/      ← strategic sub-area
│   ├── 05.phase.openapi-spec/
│   └── 10.phase.versioning/
└── 15.task.update-readme.md         ← quick win inside the umbrella
```

### When to use which

Most work starts as a goal or topic. Use phases inside them for bounded work that needs its own gate — independently verifiable outcomes. Use steps for structural decomposition that doesn't need independent verification — the parent's gate covers the whole. Use a bare phase at the root for simple, bounded work that doesn't need strategic framing. Use a task for the simplest things — a one-off fix, a quick update, anything that can be described and completed in a single sitting.

If you're unsure whether something is a phase or a step, ask: "Does this chunk produce an independently verifiable result?" If yes, it's a phase. If it's just a manageable piece of a bigger whole, it's a step.

---

## Node Files

Every node follows the `[name].[type].md` convention. All session narrative goes to the journal; the action tree holds structure, not narrative.

### For goals and topics

| File | Purpose |
|---|---|
| `name.index.md` | **Required.** What this goal/topic is about. References, siblings, children. |
| `name.gatekeep.md` | **Required.** Completion criteria — what "done" means. |
| `name.context.md` | Links to relevant knowledge tree nodes — both domain nodes and the action's notepad node (if one exists). The bridge between what you're doing (AT) and what you know (KT). |
| `name.spec.md` | Design specification — the detailed plan when the index overview isn't enough. |

### For phases

| File | Purpose |
|---|---|
| `name.index.md` | **Required.** The phase spec: goal, steps, test cases, done criteria. This IS the spec — no separate file needed. |
| `name.gatekeep.md` | Done criteria, if complex enough to warrant a separate file. Otherwise, done criteria live in the index. |

A phase's index file serves double duty: it's the folder's navigation entry point and the execution spec.

### For steps

| File | Purpose |
|---|---|
| `name.index.md` | **Required.** What this step covers, its children. |
| `name.spec.md` | Change spec — what to modify and how. Created when the step's scope warrants detailed planning. |

Steps have no gate file. The parent's gate covers the entire decomposition.

### For tasks

A task is a single file: `NN.task.name.md`. It contains a brief description of what needs doing — no spec structure required.

---

## Gatekeeping Details

The core AT defines gates as completion criteria evaluated by the human (see [action-tree.md — Gates](./action-tree.md#gates)). This plugin adds the distinction between gate natures:

**Strategic gates** (goals, topics) verify real-world outcomes and require human judgment — "repo public, quickstart works, launch post live." These are abstract but rigorous.

**Technical gates** (phases) verify implementation correctness and are largely mechanically verifiable — "migration script passes, tests green, no regressions."

**Ungated nodes** (steps, tasks) are covered by their parent's gate. Steps are a convenience for organising work, not a verification boundary.

**Status is computable.** Walk the tree from the leaves up. Each leaf is either done or not. Each branch is done when all children are done and its own gate passes.
