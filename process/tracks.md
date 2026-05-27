# Tracks

A **track** is a persistent workspace within Memory — a branch + claim + posture + dials + focus pointer. Sessions mount tracks (one session per track at a time, one track per session); master is always present; child tracks branch from master and merge back. Tracks are what makes parallel sessions possible.

This pillar covers the workspace primitive itself: what a track is, how master and children relate, how a session mounts a track, what a claim does, and how claims keep parallel tracks from colliding. The dashboard the registry sits in — `status.index.md` — is covered in [`status.md`](./status.md). The git arrangement that branches and merges run on top of is covered in [`git.md`](./git.md).

## The track primitive

One file per track at `memory/tracks/<name>.track.md`. Every track carries:

- **`name`** — unique among open tracks (reusable after the track is removed).
- **`branch`** — the branch name used identically on both repos. Master's branch is `trunk`; child tracks use `track/<name>`. See [`git.md`](./git.md) for the branch arrangement.
- **`claim`** — path prefixes the track may write across Payload and Memory. Disjoint from every other open track's claim; see [Claims](#claims).
- **`posture`** — `chat` / `plan` / `reshape` / `execute`. See [Posture](./status.md#posture).
- **`dials`** — altitude and commitment. See [The two dials](./status.md#the-two-dials).
- **`focus`** (optional) — pointer to the focus this track is currently working in. A track may exist focus-less for exploratory work.
- **`mounted_by`** (optional) — the session ID of the mounted session, when one exists.

## Master and children

The **master track** (`tracks/master.md`) is always present and sits on trunk — it has no separate branch. Master is uniform with children in every other respect: same record shape, same fields, same verbs apply.

**Child tracks** are created via [`mount`](./verbs/mount.md) when contention requires it, and disposed via [`merge`](./verbs/merge.md) (lands work to master) or [`abandon`](./verbs/abandon.md) (discards). Topology is **flat** — master plus N siblings, no nesting. There is no "child of a child."

Tracks **outlive sessions.** A child track created in session 80 may be unmounted at close, mounted again in session 82, continue its work, and finally land in session 85. The work-in-progress lives on the track, not the session that happened to be working it.

This gives three real states for a focus: **actively worked** (focus + track + mounted session); **in-flight idle** (focus + track + no session mounted); **dormant** (focus exists, no track points at it). The project's focus stack — what is in flight versus paused — is **derived** from open tracks and their focus pointers, not stored separately. A focus with a track on it is in flight; a focus with no track is dormant.

## Sessions and mounting

A **session** is a runtime instance. Sessions mount tracks; tracks outlive sessions.

- **One session per track at a time.** Two sessions cannot mount the same track.
- **One track per session.** A session mounts at most one track. There is no swap mid-session — close the session and reopen to switch.
- **Trackless** is a real state — a session that has not mounted any track. Trackless sessions are **read-only across the project**. The dials may be adjusted in-conversation but the change is volatile (no write to any record). Trackless sessions write **no journal entry** on close — they leave no trace.

### The mount flow

When a trackless session is asked to write:

- **Master is free** → auto-mount master. The single-session common case is unchanged from prior versions; no prompt.
- **Master is taken by another session** → the session asks the Human Lead: mount an existing unmounted child track, create a new child track, or stay trackless and not perform this write.

The Human Lead may also invoke [`mount`](./verbs/mount.md) explicitly up front — useful when the track is known before any write is needed. Creating a new child track requires only a **unique name** and a **non-overlapping claim**; a focus pointer is optional and can be added later.

### Mount, merge, abandon

Three verbs manage a track's lifecycle:

- **[`mount`](./verbs/mount.md)** — attach a session to a track. The entry to write-capable state.
- **[`merge`](./verbs/merge.md)** — land a child track's work onto master, then remove the track record and delete the branch. HL-invoked; sessions never self-merge.
- **[`abandon`](./verbs/abandon.md)** — discard a child track. Auto-acks any pending work first (commits survive in git's object store, recoverable), then deletes the branch and removes the track record. HL-invoked, with a confirmation prompt.

Master is never merged or abandoned; it is permanent.

## Claims

The claim is the rule that makes parallel tracks safe to coexist: each track declares which paths in Payload and Memory it may write, and claims across open tracks are **strictly disjoint by prefix**, with two carve-outs:

- **Index files (`*.index.md`)** are shared. Any open track may write to any index file. Merge conflicts in index files are the natural cost of parallelism and are resolved at merge time.
- **`status.index.md`** is the registry, shared by every track for registration, mount-state updates, drift summaries, and trail entries.

[`write-lore`](./verbs/write-lore.md) enforces the claim at **every write**. A path outside the mounted track's claim (and not in the carve-out) is refused; the Human Lead extends the claim, mounts a different track, or skips the write. Disjointness across all open tracks is verified at track creation and at every claim-change — the write-time check only needs the local "in my claim" comparison.

Master's claim is **implicit**: everything not currently claimed by an open child track. Child tracks carve sub-claims out of master's surface; while a child track is open, master may not write to the child's claimed paths.

## Save-point as consolidation

[`save-point`](./verbs/save-point.md) is the consolidation primitive for tracks. It is master-only, and it refuses if any child track is open. To take a save-point, every in-flight child track must be merged or abandoned first. This makes save-points represent a coherent project state — one trunk, no in-flight branches.

[`ack`](./verbs/ack.md) is the everyday acknowledgement; it works on any track's branches. Save-point is the rarer "everything consolidated" moment.

## Where else tracks appear in the methodology

- [`status.md`](./status.md) — status as the registry that lists open tracks; the orient flow at session open.
- [`memory.md`](./memory.md) — tracks as a Memory component, the `track` file-schema entry.
- [`git.md`](./git.md) — the branch arrangement (`trunk` for master, `track/<name>` for children), the two-repos-together rule, drift signal mechanics per track.
- [`verbs/verbs.index.md`](./verbs/verbs.index.md) — the Tracks group (`mount`/`merge`/`abandon`) and how every other verb behaves with tracks.
