---
type: verb
name: add-new-focus
title: add-new-focus — open a unit of intent
family: status-tree
track: full
writes:
  - status tree structure (new focus folder + index)
  - focus body
  - status.stack.md (new row)
contracts:
  - golden-rule
updated: 2026-07-02
---

# add-new-focus

Open a **focus** — one unit of intent at the top of the status tree — and structure
it correctly from birth. This verb is the encyclopedia for everything a focus is;
nothing else creates one.

## When to invoke

- The project commits to a new piece of work — a release, a feature, a campaign, a
  document set.
- A backlog item graduates: the commitment moment. The item informs the focus and is
  removed from the backlog in the same operation.
- NOT for adding work *under* an existing focus — that is [`add-stage`](./add-stage.verb.md)
  / [`add-phase`](./add-phase.verb.md).

## What a focus is

The top level (L1) of the status tree at `memory/status/<focus>/`. The tree has three
positional levels — **focus → stage → phase** — and four shape rules with no
exceptions: depth names the level (a focus's children are always stages, a stage's
always phases); at most three deep; never skip, never rename; every level that exists
is a folder carrying a standard index. Emptiness is valid — a focus that needs no
breakdown stays a bare focus.

Every focus declares a **`focus_type`**:

- **`build`** — concrete delivery against an evaluable **gate** (a checklist the
  Human Lead can verify). The session moves work forward; only the Human Lead calls
  it done.
- **`goal`** — directional work against a **vision** (a subjective target). The
  session delivers *and* offers an opinionated critique; the Human Lead judges done.

A focus may carry a **`claim`** — the path prefixes it owns when a track works it.
The session proposes one from the focus's title, area, and references; the Human Lead
confirms or edits. A focus with no claim leaves its track's claim implicit.

Lifecycle status lives on the focus's row in `status.stack.md` (`draft` / `paused` /
`in progress` / `done`): registered `draft` here; moves to `in progress`
automatically on first work; `paused` via [`pause-focus`](./pause-focus.verb.md);
`done` only via the Human-Lead-only [`complete-focus`](./complete-focus.verb.md).

## The file shape

The focus folder holds `<name>.index.md` (pure wiring: References / Siblings /
Children — no narrative, ever) and `<name>.focus.md`:

| Frontmatter | Body sections |
|---|---|
| `type: focus`, `title`, `updated`, `status`, `focus_type`, `claim` (optional), `references` (Parent = the folder index; Predecessor if any) | Gate (build) or Vision (goal) · Context · Stack · Active child pointer · Journal trail |

Body discipline: the gate is a checklist, not prose; Context carries the *why* and
locked decisions; Stack lists children in work order once they exist; the journal
trail is newest-first one-liners. Write the minimum that carries the meaning — the
focus body is reviewed by the Human Lead.

## Naming and decomposition

Name the folder kebab-case after the intent (`v08-verb-discipline`, not a date or a
number). Decompose **late**: open the focus bare unless the work's batches are
already known; stages materialize via `add-stage` when the build starts, phases only
under stages that need buildable steps. A focus opened with a fully speculative
subtree is the rot v0.7 killed — don't resurrect it.

## The operation

1. **Confirm the verb** (golden rule): name `add-new-focus` and the target; the Human
   Lead confirms. Ensure a mounted full track whose claim covers `memory/status/`.
2. **Settle the design** with the Human Lead: name, `focus_type`, gate or vision,
   claim proposal. If graduating a backlog item, read it and carry its content in.
3. **Create the structure**: focus folder + spec index + focus body per the file
   shape above.
4. **Wire the parent**: add the folder to `status.index.md`'s Children.
5. **Register**: append the row to `status.stack.md` — link + `draft` + blank
   active-mark.
6. **If graduating**: delete the backlog item and its index entry (its content now
   lives in the focus — this is relocation, not loss).
7. **State what was created** and where the focus stands (draft, unmounted).

## Refusals

- No mounted full track, or the tree is outside the claim → refuse; the mount flow
  or the Human Lead resolves.
- A same-named focus exists (active or archived) → refuse; names are forever.
- Asked to create a stage/phase → route to `add-stage` / `add-phase`.

## Related

[`update-focus`](./update-focus.verb.md) amends the body ·
[`add-stage`](./add-stage.verb.md) decomposes ·
[`pause-focus`](./pause-focus.verb.md) / [`resume-focus`](./resume-focus.verb.md)
side-state · [`complete-focus`](./complete-focus.verb.md) the Done call ·
[`archive-focus`](./archive-focus.verb.md) relocates the finished subtree ·
[`review-focus-tree`](./review-focus-tree.verb.md) challenges what lingers ·
[`review-backlog`](./review-backlog.verb.md) proposes graduations.
