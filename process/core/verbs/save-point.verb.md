---
type: verb
name: save-point
title: save-point — seal a milestone
family: acknowledgement
track: full
invoker: human-lead
home_only: true
writes:
  - commits on home's branches, both repos, payload-first
  - the accumulator sealed into a dated ledger entry; a fresh next opened
  - save-points index
contracts:
  - golden-rule
  - ack-pairing
updated: 2026-07-02
---

# save-point

The formal milestone: commit home's state, **seal the open next-save-point
accumulator into a dated ledger entry**, check the contracts, open the next
accumulator. Home-only; requires every child track closed — a save-point is a
coherent project state, one trunk, no in-flight branches.

## When to invoke

- A release ships, a focus closes, a migration lands — a state the project may want
  to return to, forever.
- After the last [`merge-track`](./merge-track.verb.md) closes the last child (merge
  often ends by suggesting this verb).
- NOT for everyday acknowledgement — that is the [`ack`](./ack.verb.md) family; a
  save-point that marks nothing memorable devalues the ledger.

## The ledger and the accumulator

`memory/save-points/` is **append-only and never rolls** — entries stay reachable
forever (journal files roll; that is why milestones cannot live there).

Between save-points, one entry is always **open**: `next.save-point.md`, the
accumulator. Every ack-family commit appended a row as it happened — date, verb,
track, **branch**, payload hash, summary — each row's lore commit self-identifying.
The accumulator is a shared surface (child tracks append too; append-shaped rows
merge cheap), which is exactly what makes every cross-repo, cross-branch pair
resolvable from one file.

**Sealing** turns the open entry into the milestone: rename to
`YYYY-MM-DD_<slug>.save-point.md`, frontmatter gains `date`, `lore_commit`,
`payload_commit` (the final pins — this verb's own closing pair), the body gains the
milestone description above the accumulated rows — which remain, as the milestone's
*story*: everything acknowledged since the last save-point, already written. Then a
fresh, empty `next.save-point.md` opens. The seal and the fresh-open ride in this
verb's own lore commit.

**The contract check.** Before sealing, walk the accumulated contracts (all levels —
they accumulate down the resolution chain): does the Payload honor each? A violation
stops the seal — the Human Lead either fixes forward or records a conscious override
in the entry (an override on the record is honest; a silent one is rot).

## The operation

1. **Verify the invoker** is the Human Lead; home-mounted; **every child track
   closed** (else refuse — merge or abandon first).
2. **Confirm the verb** (golden rule).
3. **Contract check**; stop on violations unless overridden on the record.
4. **Commit the drift** payload-first with the milestone message (this commit's row
   goes into the entry as its closing line).
5. **Seal**: rename, pin `date`/`lore_commit`/`payload_commit`, write the milestone
   description; **open the fresh next**; wire the save-points index.
6. **Commit lore** carrying seal + fresh-open. Offer
   [`archive-focus`](./archive-focus.verb.md) for any `done` focuses this milestone
   closes out.
7. **State the milestone**: entry name, pins, and the story's row count.

## Refusals

- Not the Human Lead → refuse; sessions never self-save-point.
- Child tracks open → refuse; consolidation means consolidated.
- Not home → refuse.
- Contract violations unaddressed → refuse the seal.

## Related

[`ack`](./ack.verb.md) / [`ack-and-continue`](./ack-and-continue.verb.md) fill the
accumulator · [`merge-track`](./merge-track.verb.md) unlocks this verb ·
[`archive-focus`](./archive-focus.verb.md) the offered follow-up ·
[`close-session`](./close-session.verb.md) independent, as ever.
