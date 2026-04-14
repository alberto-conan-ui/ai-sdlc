# Bootstrap session entry point

> Minimal session loader used exactly once per project, at the hand-off from [bootstrap Part 1](./bootstrap.index.md) to [bootstrap Part 2](./step2.md). The project has no Memory yet — there is nothing to orient against — so this loader reads only the pillars and the Migrator stance, and then directs the driver to execute Part 2. After Part 2 completes, the project's root-level `ai_readme.md` is the entry point for every session thereafter; this file is never read again.
>
> This file lives inside dist at `{lore_dir}/process/project-lifecycle/bootstrap/ai_readme-bootstrap.md`. All relative links below resolve against its location in dist — no path substitution is needed in this file itself.

---

## 1. Load the pillars

Read the six pillars in order. Each one is a core file that the build has placed in `{lore_dir}/process/`. When a pillar declares its own "load with me" contract (sub-pillars that are mandatory to load alongside the pillar itself), follow those declarations — the pillar is the authoritative source for what must be in context when it is loaded.

1. [`project-structure.md`](../../project-structure.md) — six-term vocabulary, disk layout, `workspace.yaml` manifest
2. [`stances.md`](../../stances.md) — stance concept, four dials, menu of protected infrastructure and example profiles
3. [`modes.md`](../../modes.md) — the four modes (Reflecting, Planning, Executing, Salvaging) and their transitions
4. [`operating-rules.md`](../../operating-rules.md) — runtime rules, the six verbs, session close
5. [`tracker/tracker.index.md`](../../tracker/tracker.index.md) — the tracker primitive
6. [`memory/memory.index.md`](../../memory/memory.index.md) — the memory model; this pillar declares a mandatory spine of sub-pillars (`journal.md`, `tree-discipline.md`, `blueprint.md`) that must be loaded with it

---

## 2. Load the Migrator stance

Read [`../../stances/migrator.md`](../../stances/migrator.md) and apply its dial profile. Then execute Migrator's own `## Load increment` directive — read every file the stance declares as bootstrap-time required reading (project-lifecycle docs, ai-spine, plugin source, upstream core, the composed process, release contract clauses). A literalist driver that skips the Load increment will miss material the stance needs to do its job; Migrator's increment is not optional.

Migrator is the only stance that runs in this pre-Memory state — its job is aligning project state with Upstream, and bootstrap Part 2 is the first-run case of exactly that.

---

## 3. Continue bootstrap Part 2

Read [`step2.md`](./step2.md) and execute Steps 4 through 7 of Part 2 in order. Step 7 installs the project's ongoing session entry point at the project root as its closing move, so do not perform any root-level `ai_readme.md` copy independently — Step 7 owns it.

When Step 7 completes, the project is operational. This file is not read again.
