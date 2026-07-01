---
type: verb
name: add-verb
title: add-verb — author a verb (the authoring floor)
family: blueprint
track: full
floor: un-overridable
writes:
  - blueprint/verbs/ (new *.verb.md outside core/) + branch index
  - engine projection (verb → skill)
contracts:
  - golden-rule
updated: 2026-07-02
---

# add-verb

Author a **verb** — a new unit of *what to do*, or a **shadow** that overrides an
inherited one by name. Part of the un-overridable floor: this is the verb that keeps
the golden rule total (a write with no verb routes here, and the gap closes), so it
can never itself be shadowed away.

## When to invoke

- A kind of write recurs with no fitting verb — the tell:
  [`update-payload`](./update-payload.verb.md) keeps being reached for the same kind
  of edit. Define the specific verb; resolution will prefer it.
- A project disagrees with a core or parent verb → author the same-named shadow.
- NOT for orchestrations of existing verbs (that is
  [`add-process`](./add-process.verb.md)) and NOT for rules (that is
  [`add-contract`](./add-contract.verb.md)).

## What a verb is, and where it lives

A self-contained **encyclopedia**: everything a session needs to run the operation
correctly, loaded exactly when invoked. The shape (this file is itself the
template):

- **Typed frontmatter** — `type: verb`, `name` (kebab-case), `title`, `family`,
  `track` (required track type), `invoker` where Human-Lead-only, `writes` (exact
  surfaces), `contracts` (cited by name).
- **Sections** — *When to invoke* (with explicit NOT-routing to neighbors) · the
  encyclopedia proper (the entity knowledge, self-contained) · *The operation*
  (step-list, step 1 always the golden-rule confirmation) · *Refusals* · *Related*.

Placement is the resolution chain, physically: project-local verbs live at
`blueprint/verbs/<name>.verb.md` — **outside `core/`, which is never edited in
place**. Resolution is by name, lowest level wins: core, then parents (declaration
order), then local. A local file named like a core verb *is* the override — that is
the entire shadowing mechanism, no registration step. A shadow should say in one
line what it changes and why, for the upgrade-time re-validation
([`upgrade`](./upgrade.verb.md) walks every shadow against the new core).

**The floor exception:** `add-verb`, `add-process`, `add-contract`, and the
bootstrap cannot be shadowed. Authoring the authoring verb with itself is the one
circle the system refuses; everything else — core included — is open.

**Engine wiring rides along.** Authoring projects the artifact to the engine's
native form (verb → skill on Claude) in the same motion, per the project's binding —
the artifact is live when the verb finishes, not after a separate install. (A full
re-projection of everything remains [`install`](./install.verb.md)'s job.)

## The operation

1. **Confirm the verb** (golden rule): name `add-verb` and the verb-to-be; the Human
   Lead confirms. Mounted full track; claim covering `blueprint/verbs/`.
2. **Settle the design**: name (collision-checked against the resolved set — a
   collision with an inherited name means *shadow*, said out loud), family, track
   type, writes, contracts cited, encyclopedia scope.
3. **Author** per the shape above — self-contained, NOT-routed, refusals honest.
4. **Wire**: branch index entry; engine projection per the binding.
5. **State the addition** and where it now sits in the resolved set.

## Refusals

- Target is `core/` → never edited in place; author the shadow outside it.
- Target is the floor (`add-verb`/`add-process`/`add-contract` as shadows) → refuse;
  the floor is fixed.
- It's an orchestration or a rule → route to `add-process` / `add-contract`.

## Related

[`update-verb`](./update-verb.verb.md) amends what this authored ·
[`retire-verb`](./retire-verb.verb.md) removes it ·
[`add-process`](./add-process.verb.md) / [`add-contract`](./add-contract.verb.md)
the floor siblings · [`install`](./install.verb.md) re-projects everything ·
[`upgrade`](./upgrade.verb.md) re-validates shadows.
