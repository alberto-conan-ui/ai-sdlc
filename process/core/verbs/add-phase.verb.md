---
type: verb
name: add-phase
title: add-phase — name a buildable step under a stage
family: status-tree
track: full
writes:
  - status tree structure (new phase folder + index under a stage)
  - phase body scaffold
  - parent stage index + body (Stack / Active child pointer)
contracts:
  - golden-rule
updated: 2026-07-02
---

# add-phase

Attach a **phase** — a buildable step — under an existing stage. The finest grain the
status tree names; there is nothing below a phase.

## When to invoke

- A stage's work wants named, checkable steps — each leaving the work in a runnable
  state.
- NOT under a focus directly (never skip a level) and NOT below another phase (the
  tree ends at three).

## What a phase is

L3 of the status tree — always a stage's direct child. A phase is a **buildable
step**: when it completes, the work runs / reads / holds together; a phase that would
leave the Payload broken is cut wrong. Phases carry no children — if a phase wants
decomposition, it was a stage; recut with the Human Lead rather than nesting.

Most stages need no phases. Materialize them when a stage's batch is too big to hold
as one motion, or when parallel-feeling chunks want independent gates.

The phase folder holds `<name>.index.md` (pure wiring) and `<name>.phase.md`:

| Frontmatter | Body sections |
|---|---|
| `type: phase`, `title`, `updated`, `gated`, `status`, `references` (Parent = the folder index) | Intent · Gate · Journal trail (Stack optional and rare) |

Name kebab-case, sequence-prefixed where order matters (`p1-status-tree`).

## The operation

1. **Confirm the verb** (golden rule): name `add-phase`, the parent stage, and the
   step's intent; the Human Lead confirms. Ensure a mounted full track whose claim
   covers the focus.
2. **Verify the attach point** is a stage (L2). A focus → route to `add-stage`; a
   phase → refuse.
3. **Create the structure**: phase folder + spec index + body scaffold.
4. **Wire the parent**: the stage index's Children, and the stage body's Stack and
   Active child pointer as appropriate.
5. **State what was created.**

## Refusals

- Attach point is not a stage → route or refuse per the shape rules.
- No mounted full track / outside claim → refuse.
- The "phase" wants children → it is a stage; recut instead of nesting.

## Related

[`add-stage`](./add-stage.verb.md) the level above ·
[`complete-phase`](./complete-phase.verb.md) closes it ·
[`update-focus`](./update-focus.verb.md) amends its body later.
