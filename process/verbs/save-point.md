# save-point

A save-point marks a strong reference point — a state in the project worth being able to return to. The Human Lead invokes it at milestones; the session never self-save-points.

**Save-point is the consolidation primitive.** It runs only on master, and only when every child track is closed (merged or abandoned). It is the moment that crystallises a coherent project state — one trunk, no in-flight branches. If any child track is open at invocation, save-point refuses and names the open tracks; the Human Lead lands or discards each before proceeding.

## What every save-point is

- **A commit in both repos on trunk** — the master track's branch. The lore repo (`<lore>/memory/`) and the Payload repo (the Project root), each at HEAD on trunk. The pair of commits is the return point.
- **A ledger entry that says what this moment means.** One file in `memory/save-points/`. The git history records the commits; the ledger entry describes the milestone.
- **A blueprint check.** Any contract in `memory/blueprint/contracts/` that applies to save-points is read first. A failing contract blocks the save-point until the Human Lead resolves or explicitly overrides it; overrides are recorded in the ledger entry.

A dirty working tree on master is acknowledged implicitly by the save-point's commits — there is no separate ack step.

## At invocation

The Human Lead invokes; the session helps draft both the commit message and the ledger description; the HL confirms; the session commits both repos and writes the entry through [`write-lore`](./write-lore.md).

The session may also offer archiving at the same invocation — stale focuses, completed AT subtrees, rolled journal files — and the Human Lead confirms what to move. On a save-point with nothing to archive, the offer is skipped.

## The ledger

`memory/save-points/` is append-only. It never rolls and is never archived — a save-point must stay reachable forever, which is why journal files (which do roll) cannot hold it.

## Refusals

- **Not mounted on master.** Save-point lands on trunk; the Human Lead must be on master. Close the session and reopen on master if currently on a child.
- **Open child tracks.** Save-point names them in the refusal message; the Human Lead lands ([`merge`](./merge.md)) or discards ([`abandon`](./abandon.md)) each before reinvoking.

## Relationship to ack and to merge

[`ack`](./ack.md) is the lightweight cousin: the commit shape only, on any track's branches, no ledger entry, no blueprint check, no archive offer, no children-closed requirement. A session may `ack` many times between save-points, including on child tracks.

[`merge`](./merge.md) lands a child track on master but does *not* save-point the result. If the merge completes milestone-worthy work, the Human Lead invokes save-point afterward — once every other child is also closed.
