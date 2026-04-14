# Action tree

The action tree (`{lore_dir}/memory/action-tree/`) captures intention — what you plan to do and how the work decomposes. AT nodes are [trackers](../tracker/tracker.index.md), the same primitive as status and focus, extended with whatever the work needs. When a focus is complex enough to need tracked stages spanning multiple sessions, the AT provides the structure.

The AT is optional infrastructure. Simple focuses don't need it — a focus file with a gate is sufficient. The AT earns its place when work needs decomposition across sessions.

## AT nodes are trackers

Every AT node inherits the four tracker fields from the [Tracker pillar](../tracker/tracker.index.md#fields) — stack, active child pointer, journal trail, gate — and extends with domain content.

AT nodes carry intention, status, and gates — never design knowledge, analysis, or context documents. All knowledge lives in the knowledge tree, referenced from the AT. This keeps the AT cheap to reshape and ensures knowledge survives action archival.

## Structural primitives

The AT has two structural shapes:

- **Container** — a folder with children, represented by its `[name].index.md`. Can hold other containers or leaves.
- **Leaf** — a single file, no children. Atomic work.

Named types are an optional vocabulary layered on top of these primitives — labels like "goal," "topic," "phase," or "step" tell the reader the intent level without changing the structure. When used, the project declares its own vocabulary.

## Gates

Some AT nodes are gated; others are ungated and covered by a parent's gate. Gates follow the same principle as the focus gate (see [Tracker — Gates](../tracker/tracker.index.md#gates)): concrete, evaluable, committed to when the node is created.

Branch gates have two parts: all children pass their own gates AND the branch's own gate passes.

## The AT root

The AT has one orientation file at its root: `action-tree.index.md` — the structural overview, with status for each node. Updated when nodes are added, completed, or restructured. Live project state (active focus, mode, next step) lives in `memory/status/status.index.md`, not in the AT.

## Growing the tree

The tree grows organically. You don't scaffold a deep hierarchy upfront.

Most work starts with a single gated node and a few children. If the work stays simple, the tree stays shallow. As work progresses, new nodes are added — the tree itself is the record of how the work evolved.

Test: if the AT has more maintenance cost than the focus it serves, it is over-structured.

## Completion and archival

When a gated node's gate passes:

1. Review journal entries from the node. Insights worth keeping migrate to the knowledge tree.
2. Review the node's notepad (if one exists). Durable findings migrate to their domain home in the KT.
3. The subtree moves to `archive/`.
4. `status.index.md` and `action-tree.index.md` update.
5. The journal records the completion if relevant.
