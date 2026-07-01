# Verbs — the map of operations

A **verb** is a named operation — the unit of *what to do*, chosen per write under
the golden rule (every write is confirmed to a verb; nothing writes unchosen). A
**bookend** runs intrinsically at session open and close. A **process** orchestrates
verbs, Human-Lead-started. This is the map; each verb is its own encyclopedia,
loaded when invoked, self-contained.

Verbs live in the resolution chain — core (this set) < parents < project-local,
by-name lowest-wins; contracts accumulate. Core is never edited in place; disagree
by shadowing ([`add-verb`](./add-verb.verb.md)). The un-overridable floor: the
bootstrap + `add-verb` / `add-process` / `add-contract`.

## Status tree

| Verb | One line |
|---|---|
| [`add-new-focus`](./add-new-focus.verb.md) | open a unit of intent (the focus encyclopedia) |
| [`update-focus`](./update-focus.verb.md) | amend bodies in a focus's subtree; discard guard |
| [`add-stage`](./add-stage.verb.md) / [`add-phase`](./add-phase.verb.md) | decompose: batch under focus / step under stage |
| [`complete-stage`](./complete-stage.verb.md) / [`complete-phase`](./complete-phase.verb.md) | close a batch / a step, evidence-gated |
| [`pause-focus`](./pause-focus.verb.md) / [`resume-focus`](./resume-focus.verb.md) | the side-state, out and back (staleness-checked) |
| [`complete-focus`](./complete-focus.verb.md) | the Done call — **Human-Lead-only** |
| [`archive-focus`](./archive-focus.verb.md) | relocate the finished subtree (HL) |
| [`review-focus-tree`](./review-focus-tree.verb.md) | grooming: challenge what lingers |

## Buffers

| Verb | One line |
|---|---|
| [`add-note`](./add-note.verb.md) | capture to the notepad — cheapest write (light-writable) |
| [`add-backlog-item`](./add-backlog-item.verb.md) | capture pre-focus work (light-writable) |
| [`integrate-notepad`](./integrate-notepad.verb.md) | grooming: drain the knowledge inbox (home) |
| [`review-backlog`](./review-backlog.verb.md) | grooming: polish the work inbox (home) |

## Blueprint (authoring)

| Verb | One line |
|---|---|
| [`add-verb`](./add-verb.verb.md) | author a verb / a shadow — **floor**; the shadowing encyclopedia |
| [`update-verb`](./update-verb.verb.md) / [`retire-verb`](./retire-verb.verb.md) | amend / remove an authored verb |
| [`add-process`](./add-process.verb.md) | author an orchestration — **floor**; steps are verb references only |
| [`update-process`](./update-process.verb.md) / [`retire-process`](./retire-process.verb.md) | amend / remove |
| [`add-contract`](./add-contract.verb.md) | author an inviolable rule — **floor**; the citation model |
| [`update-contract`](./update-contract.verb.md) / [`retire-contract`](./retire-contract.verb.md) | sharpen / release a rule (HL) |
| [`add-tooling`](./add-tooling.verb.md) / [`update-tooling`](./update-tooling.verb.md) / [`retire-tooling`](./retire-tooling.verb.md) | the registry cards |
| [`update-mirror`](./update-mirror.verb.md) | keep the Payload's description true (all three motions) |
| [`review-mirror`](./review-mirror.verb.md) | grooming: diff description against reality (home) |

## Payload

| Verb | One line |
|---|---|
| [`update-payload`](./update-payload.verb.md) | the floor for Payload writes — project verbs (via `add-verb`) are the preferred path |

## Tracks

| Verb | One line |
|---|---|
| [`spawn-track`](./spawn-track.verb.md) | create a child workspace from home (HL) |
| [`mount-track`](./mount-track.verb.md) | attach a session; auto-mount-home fast path |
| [`update-track`](./update-track.verb.md) | reshape a claim / repoint a focus |
| [`merge-track`](./merge-track.verb.md) / [`abandon-track`](./abandon-track.verb.md) | the exits: land / discard (HL) |
| [`release-track`](./release-track.verb.md) | clear a dead session's stale mount (HL) |

## Acknowledgement

| Verb | One line |
|---|---|
| [`ack`](./ack.verb.md) | deliberate pause-point commit — the pairing encyclopedia (HL) |
| [`ack-and-continue`](./ack-and-continue.verb.md) | light mid-execution commit (HL) |
| [`save-point`](./save-point.verb.md) | seal the accumulator into a milestone (HL, home-only, children closed) |

Every ack-family commit is paired (payload-first) and appends its annotated row to
the open `next.save-point.md` accumulator — cross-repo correlation by data, not
heuristics.

## Outward

| Verb | One line |
|---|---|
| [`add-reference`](./add-reference.verb.md) / [`remove-reference`](./remove-reference.verb.md) | consult-only links, in and out |
| [`review-references`](./review-references.verb.md) | grooming: audit the outward links (home) |
| [`add-parent`](./add-parent.verb.md) / [`remove-parent`](./remove-parent.verb.md) | inherit / stop inheriting from an upstream (HL) |
| [`publish`](./publish.verb.md) | sync the curated deliverable (HL; Publishing projects) |

## Lifecycle + journal

| Verb | One line |
|---|---|
| [`init`](./init.verb.md) | bootstrap a folder into a project (HL) |
| [`install`](./install.verb.md) | project the resolved set into an engine (HL) |
| [`upgrade`](./upgrade.verb.md) | replace core wholesale; re-validate shadows (HL) |
| [`archive-journal`](./archive-journal.verb.md) | roll the live journal (HL) |

## Bookends

| Bookend | One line |
|---|---|
| [`orient`](./orient.verb.md) | session open: floor + thin core, registry, chain, drift |
| [`close-session`](./close-session.verb.md) | session close: journal, handover, closing paired commit, unmount |

## Core processes

| Process | Composes |
|---|---|
| [`groom`](../processes/groom.process.md) | the five grooming verbs — the tidy-the-project sweep |
| [`close-out`](../processes/close-out.process.md) | complete-focus → archive-focus → save-point |

## Transitional note (v0.8 build)

The v0.7 pillar files (`project-structure.md`, `status.md`, `memory.md`,
`tracks.md`, `git.md`, `bindings.md`) remain in this folder as reference while
their content finishes dissolving into the encyclopedias; the v0.7 verb files they
link to are superseded by the `*.verb.md` set above.
