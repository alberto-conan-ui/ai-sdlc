# save-point

`save-point` marks a milestone the project can always return to. It is deliberate and rare — invoked at a real milestone, typically after many sessions and many [`ack`](./ack.md)s. A save-point is a formal acknowledgement plus a ledger entry: the commit anchors the return point, the ledger entry names it.

**The session never self-save-points.** Like `ack`, this is a Human Lead action only.

## The hard contract

**A save-point is always a git commit.** Both repositories — the lore repo (`.ai-lore-<project>/memory/`) and the Payload repo — are committed as one unit. Without commits, there is no return point, so there is no save-point.

A project's blueprint contracts can add gates above this minimum — *"tests pass,"* *"changelog updated,"* *"no TODOs in committed code."* The session checks every contract that applies to save-points before producing the commits; a failing contract blocks the save-point until the Human Lead resolves it or explicitly overrides.

## The operation

1. **Check the working tree** in both repos. If dirty, the save-point includes the implicit `ack` of the dirty state.
2. **Check blueprint contracts** that apply to save-points (`memory/blueprint/contracts/`). If any fail, surface them and wait for the Human Lead's call: resolve and retry, or override (overrides are recorded in the ledger entry).
3. **Propose the commit message** in the form:
   ```
   save-point: <milestone name>

   <description of what the milestone represents>
   ```
4. **Wait for confirmation.** The Human Lead confirms or edits the message.
5. **Commit both repos** with the confirmed message.
6. **Record the ledger entry** via [`write-lore`](./write-lore.md), targeting `memory/save-points/`. Frontmatter `type: save-point` with `date`, `lore_commit`, `payload_commit`; body gives the milestone description and any contract-override notes.
7. **Record a journal entry** noting the save-point, both commit IDs, and any contracts overridden.
8. **Consider archiving** — stale focuses, completed action-tree subtrees, rolled journal files. Propose what to archive; the Human Lead confirms.

## The ledger

`memory/save-points/` is append-only. It never rolls and is never archived — a save-point must stay reachable forever, which is why journal files, which roll to archive, cannot hold it.

## Relationship to ack

`save-point` and [`ack`](./ack.md) both commit both repos. `ack` is the lightweight version — it acknowledges accumulated work without claiming a milestone. `save-point` adds the ledger entry, the journal entry, the blueprint-contract check, and the archive consideration. A session may `ack` many times between save-points; the save-point's commit captures whatever state is at HEAD at that moment.
