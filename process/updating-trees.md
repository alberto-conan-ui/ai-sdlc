# Updating Trees — Append-Forward and Reconciliation

> **References**
>
> | Group | File |
> |---|---|
> | Principles | [principles.md](./principles.md) |
> | Memory model | [memory.md](./memory.md) |
> | Recording system | [journaling.md](./journaling.md) |

Two operations govern how the AT and KT change. **Append-forward** is the default — memory moves forward, never backward. **Reconciliation** is the exception — when strategic direction changes, the trees are reshaped under controlled conditions. Both are equally important; each is critical when used at the right time.

---

## Append-Forward

The default for all tree updates. New information creates new artifacts — new files, new nodes, new journal entries. Existing artifacts are not edited or deleted.

### Why

Rewriting history breaks the context chain. If a spec gets silently edited, journal entries that reference it no longer make sense. If an action folder gets renamed, references go stale. By always moving forward, every past reference remains valid, and the journal tells a truthful story.

### How it works

- When a plan changes, the new plan is a new artifact. The old plan stays as the record of what was believed at the time.
- When an action outgrows its scope, the action stays as-is and children continue the work.
- Promotion, revision, and abandonment are all forward moves — new entries, new files, new journal notes.
- The journal is unconditionally append-forward — even during reconciliation. It is the audit trail, never itself transformed.

### What mutates

The only files that genuinely mutate are `status.md` and `action-tree.index.md` — these are live pointers to the project's current state (which action is active, what's next). Everything else is append-only.

---

## Reconciliation

The controlled exception to append-forward. When strategic direction changes significantly, the AT and KT may no longer reflect current understanding. Blindly appending creates new nodes that supersede old ones without reconciling them — the tree accumulates contradictions. Reconciliation resolves this.

### When it applies

Reconciliation is available only in **Reflecting mode** (see [principles.md — Interaction Modes](./principles.md#interaction-modes)). It requires explicit Human Lead approval. Both conditions are non-negotiable — without them, append-forward holds unconditionally.

### How it works

During reconciliation, append-forward is suspended for the AT and KT:

- **Archive** AT nodes and stale KT nodes to their respective `archive/` folders
- **Rebuild** the AT from current intentions
- **Re-curate** the KT to align with current understanding — consolidate, restructure, rewrite
- **Document** the transformation in a journal entry listing every node archived, created, or restructured, with a reason

The journal entry is the audit trail. It makes the reconciliation auditable and reversible.

### What reconciliation does not do

- Bypass human accountability — the Human Lead must approve
- Operate outside Reflecting mode
- Destroy information — archived nodes are preserved
- Touch the journal — the journal records the reconciliation, it is not reconciled

### Frequency guidance

Reconciliation is a sign of strategic shift, not routine maintenance. If you're reconciling every few sessions, the problem is likely upstream — work is being decomposed at the wrong level, or strategic direction isn't stable enough to decompose yet. A well-run project reconciles rarely: when a genuine pivot changes what the project intends to do.
