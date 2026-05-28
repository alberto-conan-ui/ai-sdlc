# Git

AI-Lore stores both Memory and Payload in git, and uses git's working-tree state as the project's **drift signal**: dirty tree means unacknowledged work, clean tree means acknowledged. This pillar covers the git contract — what is tracked where, how the two repos relate, how branches work with tracks, and where the explicit `git -C` discipline matters.

The arrangement is built up of three things: **two repositories**, **branches per track**, and **the drift signal** that ties git state to AI-Lore's acknowledgement primitives.

## Two repositories

The Project root is the **Payload repo**. The lore folder contains the **lore repo** at `<lore>/memory/`. Each is its own git repository; they commit independently but acknowledge together — [`ack`](./verbs/ack.md) and [`save-point`](./verbs/save-point.md) commit both as a single unit on the mounted track's branches.

Details a session reading or writing these repos has to know:

- **The Payload's `.gitignore` excludes `.ai-lore-<project>/` and `publish/`.** The Lore folder, the methodology, the vendored `process/`, Memory, and the Publish target all sit outside Payload tracking. [`init`](./verbs/init.md) writes both entries on project creation; the `publish/` entry is harmless on projects that don't declare Publishing.
- **The lore repo's `.git/` lives at `<lore>/memory/.git/`, not at `<lore>/.git/`.** `cd <lore>` does not put a session inside the lore repo — git walks up and finds the Payload's `.git/` instead. To address the lore repo explicitly, use `git -C <lore>/memory ...`. The drift check at every bookend relies on this.
- **The vendored `<lore>/process/` is tracked by neither repo.** The Payload's `.gitignore` excludes the whole Lore folder; the lore repo only covers `memory/`. The vendored methodology is an on-disk mirror of the canonical source, placed by `init` and re-placed by [`upgrade`](./verbs/upgrade.md). In self-hosting projects — where the canonical methodology *is* the Payload, as in `ai-sdlc` itself — edits to the methodology must be applied to both `/process/` (canonical, Payload-tracked) and `<lore>/process/` (vendored, untracked) to stay in sync.
- **`publish/` is in no git repo.** Like the vendored methodology, `publish/` sits outside both repos — it is derived state regenerable from the Payload. The Payload's `.gitignore` keeps it out of Payload tracking; the lore repo never covered it. The [`publish`](./verbs/publish.md) verb is the sole writer.

## Branches per track

Home sits on **`trunk`** in both repos — there is no separate "home" branch; home *is* trunk. A child track creates a branch named **`track/<name>`** on the lore repo and on the Payload repo. The two branches commit and merge as one unit, the same way ack and save-point already operate.

[`mount`](./verbs/mount.md) checks out a track's branch on both repos when it attaches a session. [`merge`](./verbs/merge.md) lands a child branch onto trunk on both repos in parallel; [`abandon`](./verbs/abandon.md) tears both branches down after auto-acking.

A child track's branch life is short by intent: it exists from `mount` (which creates it) to `merge` or `abandon` (which removes it). The branch lives only on local repos by default — it does not need to be pushed unless the project's workflow involves remote review of in-flight work.

## The drift signal

The **working tree's dirty state on a track's branch is the drift signal** for that track: dirty is unacknowledged work, clean is acknowledged. Drift is **per-track** — a project with three open tracks has three independent drift states.

Three verbs move a track's tree from dirty to clean by committing both repos as one unit, on the mounted track's branches:

- [`ack`](./verbs/ack.md) — the deliberate pause-point acknowledgement. A commit with a focused, area-grouped message; the Human Lead reviews the message before it lands.
- [`ack-and-continue`](./verbs/ack-and-continue.md) — the light mid-execution variant. Same commit shape; minimal message ceremony; session continues immediately.
- [`save-point`](./verbs/save-point.md) — the formal acknowledgement plus a ledger entry, marking a return point. Save-points are **home-only and require every child track to be closed first** (merged or abandoned) — see [`tracks.md`](./tracks.md#save-point-as-consolidation).

Two further verbs end a child track's lifecycle:

- [`merge`](./verbs/merge.md) — lands the child onto home in both repos.
- [`abandon`](./verbs/abandon.md) — auto-acks (so the commits survive in git's object store) and deletes the branch in both repos.

[`close-session`](./verbs/close-session.md) also commits: its journal write, status update, and any working-tree drift land together as one Human-Lead-confirmed closing commit on the mounted track's branches. The bookend's commit is independent from `ack` and the other ack-family verbs.

**Sessions never self-ack, self-save-point, self-merge, or self-abandon.** Every landing onto canonical state — every commit that the Human Lead would later have to live with — is the Human Lead's act. close-session's closing commit holds to the same rule: the session drafts the message and presents it; the Human Lead confirms or edits before the commit lands. The git operation is just the mechanism.

## The drift check — the right paths

[`orient`](./verbs/orient.md) checks every open track's branches at session open; [`close-session`](./verbs/close-session.md) checks the mounted track at session close. The check is `git status` on each repo, against the appropriate branch.

The lore repo's `.git/` lives at `<lore>/memory/.git/`, **not** at `<lore>/.git/`. Running `git status` from inside `<lore>/` walks up to the Payload's `.git/` and reports that instead — a silent miss. Use the explicit form, per branch:

```
git -C <lore>/memory status         # current branch on the lore repo
git -C <project> status             # current branch on the Payload repo
```

For each open track, the drift check looks at the track's branch — `trunk` for home, `track/<name>` for a child. The per-track drift summary surfaced in the orient readout names each.

## What git does not own

- **Focus state.** Focus pointers, focus types, gates — Memory. See [`status.md`](./status.md) and [`memory.md`](./memory.md).
- **Posture and dials.** They live on the mounted track's record. See [`tracks.md`](./tracks.md) and [`status.md`](./status.md).
- **The journal.** Journal entries are Memory files written through [`write-lore`](./verbs/write-lore.md), then committed by git — the entries are Memory; the commits are git's role.
- **The save-points ledger.** Same: `memory/save-points/<entry>.save-point.md` is Memory; the commit that records it is git's role.

Git carries the **state** of the project's history and working tree. AI-Lore carries the **meaning** — which states are acknowledged, which need acknowledgement, which represent milestones. Git is the substrate; AI-Lore is the discipline applied to it.
