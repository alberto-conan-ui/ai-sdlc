---
name: ai-lore-ack
description: "Commit both repos with a focused message — acknowledge accumulated work"
---

# ack

`ack` commits both repositories with a Human-Lead-confirmed message capturing what is being acknowledged. It is the lightweight cousin of [`save-point`](./save-point.md) — same commit shape, no ledger entry.

**The session never self-acks.** Acknowledgement is the Human Lead's confirmation that accumulated work has been reviewed; only they can give it. The session may flag drift, propose the commit message, and prepare the commit — it does not invoke `ack` on its own.

## When the Human Lead invokes it

- After reviewing a batch of accumulated changes — Memory writes, Payload edits, or both.
- Before pausing, switching context, or closing the session, if the work is not yet milestone-level (which would be `save-point`).
- Whenever the working tree is large enough that further work would compound the drift.

## The operation

1. **Check the working tree** — `git status` on both the lore repo (`.ai-lore-<project>/memory/`) and the Payload repo. If both are clean, refuse: there is nothing to acknowledge.
2. **Summarise the diff** — `git diff` for both repos. Group changes by area (focus, journal, blueprint branch, KT, AT, Payload area) and intent. The summary is for the Human Lead's reading later; it must be specific enough to review against the commit.
3. **Propose the commit message** in the form:
   ```
   ack: <one-line summary>

   - <area>: <what changed and why>
   - <area>: <what changed and why>
   ```
4. **Wait for confirmation.** The Human Lead confirms or edits the message. A vague ack defeats the purpose — the message is what makes the acknowledgement reviewable later.
5. **Commit both repos** with the confirmed message. Partial acks are not allowed; both repos commit together as one unit of acknowledgement. If only one repo is dirty, only that repo commits, but the unit is still "this ack."

## Relationship to save-point

`ack` and `save-point` both commit both repos. `save-point` additionally records a ledger entry in `memory/save-points/`, writes a journal entry, checks any blueprint contracts that apply to save-points, and considers archiving. A session may `ack` many times between save-points.

A `save-point` on a dirty tree includes the implicit ack — the commit it produces *is* the acknowledgement that the working state is good enough to mark as a milestone.
