# v0.22 Migration Prompt

> Give this prompt to the Architect at the start of a fresh session, after AUTO loads context.
> **Migrates from:** v0.21 → v0.22

---

The methodology has been updated to v0.22. Your job is to migrate this project's memory — action tree, knowledge tree, journal references, and all supporting files — to be fully consistent with the new process.

## What changed

Read the v0.22 process docs thoroughly before doing anything. The key changes you need to understand:

1. **Hierarchical numbering convention.** AT nodes use two-digit IDs starting at `05`, incrementing by `5`. This creates insertion gaps. Parking-lot goals count down from `95`. Hierarchical addressing uses dot-separated parent-child IDs (e.g., node `10` inside goal `05` is `05.10`). Read `process/action-tree.md` — the Numbering Convention section.

2. **KT notepad branch.** A `notepad/` folder at the KT root provides low-friction scratch space for action-scoped observations. Any stance writes to it. On action completion, durable findings migrate to the KT proper; the notepad node archives. Read `process/knowledge-tree.md` — the Notepad Branch section.

3. **Reflection mode.** Three interaction modes now: Planning (shaping), Executing (building), Reflecting (evaluating). Use Reflecting after completing significant actions to assess what happened. Read `process/principles.md` — the Interaction Modes section.

4. **Developer stance removed.** Two core stances: Architect and Tech Lead. Auditor is situational. The Developer was never used in practice and added overhead without value. Read `process/roles.md`.

5. **Status history removed.** The `status.md` format no longer includes a History section. Journal and git log are the historical records. Read `process/action-tree.md` — the AT Root section.

## What you need to do

Follow the process. Read the relevant docs. Create a goal for this migration. Design it properly — spec, gatekeep, decomposition. Don't rush.

For every node in the action tree, you need to evaluate:

- **Numbering:** Does the folder and file numbering follow the two-digit convention (`05`, `10`, `15`)? Are there insertion gaps? Renumbering is the most labor-intensive step — every folder rename requires updating every file that links to it. Plan the renumbering before executing it.
- **Developer references:** Do any files reference the Developer stance? Update them. The Developer no longer exists. Two core stances remain.
- **Status.md:** Does `status.md` have a History section or table? Remove it. Only current state, active stack, and project overview remain.

For the knowledge tree:

- **Notepad structure:** Does `knowledge-tree/notepad/` exist with `notepad.index.md` and `notepad/archive/`? Create it if not. If there's an active action, consider whether it would benefit from a notepad node.

For `ai_readme.md`:

- Does it reference the Developer stance? Remove the reference.
- Does it mention only two interaction modes (Planning/Executing)? Add Reflecting.

For general consistency:

- Do any project files use "Developer" as a stance name? Update them.
- Do any files reference only two interaction modes? Add Reflecting where appropriate.

This is not a find-and-replace job. Every file in the memory system needs to be read, understood, and brought into alignment with v0.22. The renumbering in particular requires careful planning — map out the new numbers before renaming anything, then update all cross-references in a single pass.

Take your time. A sloppy migration means every future session loads inconsistent context. Get it right.
