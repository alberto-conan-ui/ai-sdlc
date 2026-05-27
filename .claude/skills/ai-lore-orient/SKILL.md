---
name: ai-lore-orient
description: "Session open — load the methodology, surface open tracks and drift"
---

# orient

`orient` is the **session-opening bookend.** Its aim: by the time the Human Lead asks the first question, the session is **expert on the active task** — ready to answer informed and act, not scrambling for context. The session runs `orient` on itself at the start of every session; the Human Lead does not invoke it.

To get there, orient loads the methodology if it isn't already loaded, reads the registry, decides how deep to walk based on what tracks are open, surfaces drift, and states where the work stands.

## What orient knows after running

- **The methodology.** The seven pillars are loaded: [`project-structure.md`](../project-structure.md), [`memory.md`](../memory.md), [`status.md`](../status.md), [`tracks.md`](../tracks.md), [`git.md`](../git.md), [`verbs/verbs.index.md`](./verbs.index.md), [`bindings.md`](../bindings.md). On the plain-text path, `ai_readme.md` has just walked the session through them. On an installed engine, the SessionStart hook fires `orient` directly — the session reads the seven files itself as its first step. Either way, by the time orient has finished, the session is AI-Lore-shaped.
- **The registry.** `memory/status/status.index.md` has been read — the open-tracks list, the journal trail, the drift summary, the save-points and blueprint pointers. The session knows the landscape: which tracks are open, which are mounted by other sessions, which are unmounted and available.
- **Track-aware depth.** The chain walk and detail-loading depend on what is open (see below).
- **The state of both repos, per open track.** A `git status` check runs against every open track's branches on both repos. Drift is surfaced per-track in the readout.

The session starts **trackless** in every case. Mounting is a separate decision, taken explicitly by the Human Lead or implicitly when a write is requested.

## Track-aware depth

The depth of orient's preparation depends on what is open:

- **No other tracks open** (only master, or master is unmounted and there are no children). The session assumes it will end up on master or stay trackless. Orient reads master's record, walks the focus chain from master's focus pointer to the tip — the journal handover for that focus, blueprint relevant to the focus, knowledge-tree entries it references, Payload areas named in the focus or its gates. This matches v0.5.1 behaviour exactly: a single-session project pays no parallelism tax at orient.
- **Other tracks open.** The chain walk is deferred. The session states the open tracks in the readout and asks the Human Lead: stay trackless, or mount a track now? If a track is mounted in response, orient walks the mounted track's chain. If trackless, no chain walk runs — the session reads what is asked of it, and mounts later via [`mount`](./mount.md) when a write is requested.

## Drift check

For each open track, orient checks the track's branch on both repos — `trunk` for master, `track/<name>` for a child — and surfaces the result per-track in the readout. The mechanics (`<lore>/memory/.git/` location, the explicit `git -C` discipline) live in [`git.md`](../git.md).

## How it states the context

One readout: open tracks (name, focus, mounted-by, posture, dials), per-track drift, the tip of any walked chain, the next step from the relevant handover. If the project is headless (no focus on master, no other tracks open), say so and wait for direction. If multiple tracks are open, name the choice the Human Lead has — mount one now, or stay trackless.

An engine binding may reinforce `orient` with a SessionStart hook so a session cannot open without it; the methodology does not depend on the reinforcement.
