# v0.21 Migration Prompt

> Give this prompt to the Architect at the start of a fresh session, after AUTO loads context.
> **Migrates from:** v0.2 → v0.21

---

The methodology has been updated to v0.21. Your job is to migrate this project's memory — action tree, knowledge tree, journal references, and all supporting files — to be fully consistent with the new process.

## What changed

Read the v0.21 process docs thoroughly before doing anything. The key changes you need to understand:

1. **Five node types, defined by properties.** Goals, topics, phases, steps, and tasks. Container/leaf × gatekept/ungatkept. Steps are structural containers without gatekeeps. Tasks are ungatkept leaves. Read `process/action-tree.md` — the property matrix at the top frames everything.

2. **Unified status vocabulary.** One set of statuses for all node types: Pending, Active, Paused, Review, Done, Achieved. No per-type status lists. Done for ungatkept nodes, Achieved for gatekept nodes. Nothing moves past Review without an explicit Human Lead decision. Read `process/conventions.md`.

3. **Interaction modes.** Planning and Executing are explicit modes recorded in `status.md`. Planning means artifacts are provisional. Executing means artifacts are authoritative. The transition is always a human decision. Read `process/principles.md` — Interaction Modes section.

4. **Workflow stage renamed.** The workflow stage is "Design", not "Planning." "Planning" now means exactly one thing: the interaction mode. Read `process/workflow.md`.

5. **Index as navigation primitive.** Every folder has `[name].index.md` with a three-section grammar: References, Siblings, Children. This applies to AT, KT, and journal folders. Read `process/memory.md` — The Index section.

6. **Journal folders with handover.** Each session produces a folder in `journal/live/` containing an index, entry files, and a `handover.md`. The handover is the session continuity mechanism. Read `process/journaling.md`.

7. **Session protocols.** Session open and close are defined in `roles/operating-rules.md`. Session close requires asking the Human Lead for status — not inferring it. The handover captures the stated assessment.

8. **status.md formatting.** The active action shows the full hierarchy breadcrumb: `Type N — [Name](link) / Type N — [Name](link) — Status`. The project overview shows the full tree with indented children, each node typed, named, linked, and with status. Read `process/action-tree.md` — The AT Root section for the full convention.

9. **Tasks have a relaxed workflow.** Inside a task, any stance can do the whole job. Interaction modes still apply. Workflow stages and stance handoffs don't.

10. **Typed file system.** Every file follows `[name].[type].md`. Folder naming uses `N.type.kebab-case-name/`. Tasks are `N.task.name.md` — single file, no folder.

## What you need to do

Follow the process. Read the relevant docs. Create a goal for this migration. Design it properly — spec, gatekeep, decomposition. Don't rush.

For every node in the action tree and knowledge tree, you need to evaluate:

- Does the folder and file naming match v0.21 conventions?
- Does every folder have a proper `[name].index.md` with the References/Siblings/Children grammar?
- Are reference headers present and accurate on every file?
- Do statuses use the unified vocabulary?
- Is `status.md` formatted with the breadcrumb active action and the full indented project overview?
- Is `action-tree.index.md` consistent with the tree structure?
- Do journal folders follow the new structure (index + entries + handover)?

This is not a find-and-replace job. Every file in the memory system needs to be read, understood, and brought into alignment with v0.21. Some files will need restructuring. Some will need new index files created. Some will need reference headers added or corrected. Think about each one.

Take your time. This is the foundation everything else builds on. A sloppy migration means every future session loads inconsistent context. Get it right.
