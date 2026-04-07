# The Action Tree

> **References**
>
> | Group | File |
> |---|---|
> | Memory model | [memory.md](./memory.md) |
> | Conventions | [conventions.md](./conventions.md) |
> | Recording system | [journaling.md](./journaling.md) |
> | Workflow | [workflow.md](./workflow.md) |

> **Slot:** Domain node types — the plugin defines specific node types on top of core's container/leaf primitives (e.g., SDLC's goal, topic, phase, step, task). See [plugins.md](./plugins.md).

The action tree (`action-tree/`) captures intention — what you plan to do and how the work decomposes. When a focus is complex enough to need tracked stages spanning multiple sessions, the AT provides the structure. It breaks a focus into nodes with their own gates and lifecycle, making progress visible and resumable.

The AT is optional infrastructure. Simple focuses don't need it — a focus file with a gate is sufficient. The AT earns its place when work needs decomposition: multiple stages, dependencies between parts, progress that must survive session boundaries. See [workflow.md — The Action Tree](./workflow.md#the-action-tree--optional-infrastructure).

---

## Core Mechanics

### Containers and Leaves

Every AT node is either a **container** (a folder with an index and children) or a **leaf** (a single file, no children). Containers decompose; leaves are atomic. The tree is built from these two primitives — plugins define the specific node types layered on top.

### Gates

Some nodes are **gated** — they have explicit completion criteria that the human evaluates. Other nodes are ungated, covered by their parent's gate. The gate is the verification boundary: at every gated level, you can answer "is this done?"

Gates follow the same principle as the focus gate (see [focus.md — The Gate](./focus.md#the-gate)): concrete, evaluable, committed to when the node is created. The human decides what kind of gate fits — concrete ("all tests pass") or subjective ("I'm satisfied with the result").

**Branch gates** have two parts: all children pass their own gates, AND the branch's own gate passes. The branch gate can be stricter than the sum of its children.

### When gates are unclear

If you cannot write a gate, the scope is probably wrong. Refine until "done" is articulable — even if that means "I'll know it when I see it, and here's roughly what I'm looking for."

---

## Structure

All AT nodes follow the conventions defined in [conventions.md](./conventions.md): the typed file system (`[name].[type].md`), the index navigation grammar, reference headers. Every container has an index. All session narrative goes to the journal — the action tree holds intention and structure, not narrative.

Plugins define the specific node types available in the AT — what each type means, which can contain which, and what files each carries. The core provides the infrastructure; the plugin provides the vocabulary.

### The AT Root Index

The AT root has one orientation file:

**`action-tree.index.md`** — the structural overview. The full tree with status for each node, dependencies, and cross-references. Updated when nodes are added, completed, or restructured.

The AT root index is a structural map — it shows what's in the tree and how the pieces relate. The live project state (active focus, mode, next step) lives in `status.md`, not in the AT. See [workflow.md — Status](./workflow.md#status--the-entry-point).

### Numbering Convention

Node ordering uses a two-digit ID scheme designed for stable, gap-friendly numbering.

**Base rules:** two-digit IDs at every level — `05`, `10`, `15`, `20`, ... Start at `05`, increment by `5`. Lower number = higher priority. This leaves four insertion slots between any two consecutive nodes.

**Insertion:** when a node needs to go between two existing nodes, use the integers in the gap. Between `05` and `10`, insert `06`, `07`, `08`, or `09`. This avoids renumbering existing nodes and preserves link stability.

**Parking-lot:** low-priority or future work counts down from `95` — `95`, `90`, `85`, ... Active work lives at the top of the numbering range; speculative or deferred work lives at the bottom.

**Folder names use the local ID.** On disk, a child folder is just `NN.type.name/` — the parent prefix does not appear in the folder name.

**Hierarchical addressing for cross-references.** When referring to a node outside its immediate folder — in `status.md`, journal entries, or prose — use the dot-separated path of local IDs: `05.05` means "child 05 inside parent 05." This extends to any depth: `05.10.05`.

---

## Growing the Tree

The tree grows organically. You don't scaffold a deep hierarchy upfront.

**Starting simple.** Most work starts with a single gated container and a few children. If the work stays simple, the tree stays shallow.

**Decomposing as needed.** As work progresses, new nodes are added. When a node's scope grows, it gains children. The tree IS the record of how the work evolved — there's no promotion mechanic, no ceremony.

---

## Completion and Archival

When a gated node is done — its gate passes:

1. Review journal entries from the action. Anything flagged as insightful and worth keeping migrates to the appropriate knowledge tree node.
2. Review the action's notepad node (if one exists in `knowledge-tree/notepad/`). Durable findings migrate to their domain home in the KT. The notepad node moves to `knowledge-tree/notepad/archive/`.
3. The action subtree moves to `archive/`. The full record goes together.
4. `status.md` and `action-tree.index.md` update — focus completed, status marked achieved.
5. The journal gets a completion note if relevant.

For branch nodes, completion means all children are done and the branch gate passes. You can archive children individually as they finish, or the entire subtree at once.

Completed subtrees move to `archive/`. This keeps the active tree clean — only in-progress and pending work lives at the top level. The archive preserves the full record. The knowledge the action produced already lives in the knowledge tree. The archive is the append-forward historical record.
