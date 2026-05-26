---
name: ai-lore-ack
description: "Commit both repos with a focused message — acknowledge accumulated work"
---

# ack

`ack` is how the Human Lead acknowledges accumulated work — the lightweight cousin of [`save-point`](./save-point.md). Same commit shape; no ledger entry, no blueprint check, no archive offer.

**The session never self-acks.** Acknowledgement is the Human Lead's confirmation that accumulated work has been reviewed; only they can give it.

## When the Human Lead invokes it

- After reviewing a batch of accumulated changes — Memory writes, Payload edits, or both.
- Before pausing, switching context, or closing the session, if the work is not yet milestone-level (which would be [`save-point`](./save-point.md)).
- Whenever the working tree is large enough that further work would compound the drift.

## What every ack is

A commit in each dirty repo with a Human-Lead-confirmed message capturing what is being acknowledged. Both repos commit together as one unit of acknowledgement; if only one repo is dirty, only that repo commits, but the unit is still "this ack."

A vague ack defeats the purpose — the message is what makes the acknowledgement reviewable later. The session helps draft a specific message grouped by area (focus, journal, blueprint, KT, AT, Payload); the Human Lead confirms or edits before the commit lands.

## Relationship to save-point

`save-point` adds the ledger entry, the blueprint-contract check, and the archive offer on top of the ack's commit shape. A save-point on a dirty tree includes the implicit ack — the commit it produces *is* the acknowledgement of the working state.
