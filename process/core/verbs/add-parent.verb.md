---
type: verb
name: add-parent
title: add-parent — inherit from an upstream project
family: outward
track: full
invoker: human-lead
writes:
  - memory/workspace.yaml (parents: list)
  - engine re-projection of the resolved artifact set
contracts:
  - golden-rule
updated: 2026-07-02
---

# add-parent

Declare a **parent** — an upstream AI-Lore project whose verbs, processes, and
contracts become invocable here. **Human-Lead-invoked**: inheriting authority over
what this project may do is the Human Lead's signature.

## When to invoke

- A team/org project publishes shared discipline (its `blueprint/`) that this
  project should run under.
- A reference turns out to be inherited-from in spirit —
  [`review-references`](./review-references.verb.md) proposes the promotion.
- NOT for consult-only context — that is
  [`add-reference`](./add-reference.verb.md).

## What a parent is

A line in the manifest: `parents:` in `memory/workspace.yaml`, **ordered** — a
path per entry to the parent project's root. Parents are **eager**: their exposed
`blueprint/{verbs,processes,contracts}/` must be known at orient/install for their
artifacts to be invocable — unlike lazy references.

**Resolution** (the full chain, once more, from the floor): by name, lowest level
wins — **core**, then **parents in declaration order** (earlier beats later among
same-level), then **project-local**. Many parents form a DAG; declaration order is
the diamond tiebreak. **Contracts accumulate** — every ancestor's bind; lowest-wins
applies only on direct name conflict. The floor never resolves away.

Adding a parent therefore changes the live verb set — new names appear, same-named
locals start shadowing *something*, and the parent's contracts start binding. The
verb walks that delta with the Human Lead **before** landing: here is what you are
about to be able to do, here is what will now bind you.

## The operation

1. **Verify the invoker**; **confirm the verb** (golden rule); mounted.
2. **Resolve the target**: an AI-Lore project whose `blueprint/` exposes artifacts;
   cycle-check the DAG (a project may not be its own ancestor).
3. **Compute and present the delta**: inherited artifacts, shadow relationships
   triggered, contracts that will accumulate. The Human Lead approves seeing it.
4. **Write the manifest line** (position = precedence, chosen deliberately).
5. **Re-project** the resolved set to the engine (new skills, new hooks).
6. **State the new resolution order.**

## Refusals

- Not the Human Lead → refuse.
- Target exposes no blueprint / is not an AI-Lore project → refuse.
- A cycle → refuse.
- The intent is consult-only → `add-reference`.

## Related

[`remove-parent`](./remove-parent.verb.md) ·
[`review-references`](./review-references.verb.md) audits the list ·
[`install`](./install.verb.md) projects the resolved set ·
[`upgrade`](./upgrade.verb.md) re-validates local shadows when *core* moves — the
same conversation applies when a parent moves.
