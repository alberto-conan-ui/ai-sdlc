# Journal

The methodology maintains a persistent record of what happened, what was learned, and what was decided. This sub-pillar defines the recording system: what gets written, where it goes, and who writes it.

## The journal file

Every session produces a single journal file in `journal/live/`. The file is named by date and session number: `YYYY-MM-DD_NN.md`, where `NN` is a zero-padded two-digit counter (e.g., `2026-03-19_02.md`). This file serves as both the session record and the handover for the next session.

**Header metadata** — always present, always first:

```markdown
# Session NN — Title

| Field | Value |
|---|---|
| **Date** | YYYY-MM-DD |
| **Stance** | which stance was active |
| **Mode** | Reflecting / Planning / Executing / Salvaging |
| **Active focus** | which focus was the subject |
```

**Body** — the stance's judgment determines structure and depth. A heavy design session may need detailed decision logs. A routine execution session might just be "implemented X, tests pass, no surprises." The body captures *what happened*: decisions made, blockers encountered, process notes. Link to artifacts rather than restating their content — if a KT node was written, link to it; if a spec was updated, reference it. The journal records that something happened and why, not the thing itself. If something is particularly insightful and may be worth migrating to the knowledge tree later, flag it clearly (e.g., "**Insight:** ...").

**Handover section** — always present, always last. A targeted message for the next session working on this focus.

Journal references from focus, KT, and AT indexes point to specific session files, not to folders. This gives "Relevant journal" precision: the session loads exactly the context it needs.

## The handover

The handover is the session continuity mechanism. It answers a different question than `status.index.md`: status says "where is the project"; the handover says "where was this work left."

**Audience:** The next session working on this focus. The handover is focus-scoped, not project-wide.

**Content:** What was being worked on, where it was left, what the next session needs to know to continue. Concretely: the active focus, the mode at close, what was accomplished, what to do first, and any watch-out items.

**Relationship to status.index.md:** Status is updated every session (mutable). The handover is written once, append-forward. They are complementary — status gives the project-wide picture, the handover gives the focus-specific thread.

**Read the handover before forming opinions about artifacts.** The Mode tells the session how much to trust the artifacts it finds; the handover tells the session what the previous session was doing with them. In Reflecting, the handover captures what triggered the reflection. In Salvaging, the handover captures what is being rewritten and why.

## Journal rolling

Journal files roll from `live/` to `archive/` on a regular cadence. This keeps `live/` bounded — only recent sessions get loaded, which matters for context window efficiency.

The Human Lead triggers the roll — either manually or by asking for journal processing. Processing means: review `live/`, extract insights to the trees, then move processed files to `archive/`. Files that span the boundary are fine to archive — the action tree and knowledge tree hold the durable information.

When a session starts, the journal files in `live/` are the recent context. Older sessions sit in `archive/` and can be loaded on demand. If `live/` is growing unbounded, that is a signal the Human Lead needs to trigger processing.

## Append-forward

Journal files follow append-forward unconditionally. Journal files are never edited or deleted after they are written — not even during Reshape, Rewrite, or reconciliation. The journal is the audit trail; it records transformations, it is never itself transformed. Old journal files move to `archive/` through normal rolling, never through editing or deletion.
