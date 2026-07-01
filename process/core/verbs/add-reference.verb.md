---
type: verb
name: add-reference
title: add-reference — declare a consult-only link
family: outward
track: full
writes:
  - references/<name>.md + references index
contracts:
  - golden-rule
updated: 2026-07-02
---

# add-reference

Declare a **reference** — a consult-only link to another AI-Lore project on disk
this project looks at for context.

## When to invoke

- The project starts consulting a sibling, a reference implementation, a related
  effort.
- NOT for inheritance — a project whose *artifacts* should be invocable here is a
  **parent** ([`add-parent`](./add-parent.verb.md)); references are lazy and
  read-only, parents are eager and resolved.

## What a reference is

One file at `<lore>/references/<name>.md` (sibling to `memory/`, not inside it —
references are pointers outward, not the project's own thinking): frontmatter
(`type: reference`, `target_path`, `purpose` — one line, `scope` — what part
matters); body — how to consult it, when, caveats.

Three rules carry the whole design: **read-only by contract** (never write through
a reference; cross-project edits happen by opening the other project); **link
metadata only** (insights drawn from reading it belong in this project's own record
— notepad, then blueprint — with the reference as source; the file describes the
link or it becomes a competing journal); **not auto-loaded** (consulted when work
calls for it, never at session open).

## The operation

1. **Confirm the verb** (golden rule); mounted full track.
2. **Verify the target** — an AI-Lore project at `target_path`, readable, actually
   consulted for a reason one line can state.
3. **Author the file**; wire `references.index.md` (create the folder + index on
   first use — the folder is optional until then).
4. **State the link.**

## Refusals

- The intent is inheritance → `add-parent`.
- Nothing concrete to consult (a "might be useful someday" link) → notepad it;
  references earn their file by being used.

## Related

[`remove-reference`](./remove-reference.verb.md) ·
[`review-references`](./review-references.verb.md) ·
[`add-parent`](./add-parent.verb.md) the eager sibling ·
[`add-note`](./add-note.verb.md) holds what reading the reference taught.
