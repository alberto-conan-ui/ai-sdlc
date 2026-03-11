# The Action Tree

Everything in AI-SDLC is an **action**. An action is a human-defined piece of work with a clear outcome. Actions live in a tree — nested however you want, named whatever you want, structured to match how you think about the work.

The action tree is the project's **short-term memory** — one half of the memory model defined in [memory.md](./memory.md). It captures what you're doing *right now*: the work in progress, the session-by-session log of what happened, the insights accumulating as you go. When an action completes, its insights migrate to the **knowledge tree** (long-term memory) and the action archives. The action tree is where work lives while it's alive.

---

## The Tree

An action tree is a hierarchy of nodes. Each node is a folder. A node can have children (making it a branch) or stand alone (making it a leaf). You decide the shape.

A single node with no children is a simple action — the equivalent of "fix this bug" or "add this feature." A node with children decomposes work into sub-actions — "redesign the auth flow" might break into "audit current endpoints," "design the new token model," and "migrate existing sessions." Those children can themselves have children. There's no depth limit and no prescribed structure.

You name nodes whatever makes sense. There are no tier labels, no required prefixes, no classification system. Call it `auth-redesign` or `fix-the-damn-login` or `q2-platform-work` — the name serves you, not the process.

```
action-tree/
├── auth-redesign/
│   ├── gatekeep.md
│   ├── context.md
│   ├── index.md
│   ├── audit-endpoints/
│   │   ├── gatekeep.md
│   │   ├── context.md
│   │   ├── log.md
│   │   ├── KEY_INSIGHTS.md
│   │   └── phases/
│   │       └── 1-catalogue-endpoints/
│   │           ├── phase.md
│   │           ├── prompt-plan.md
│   │           ├── 01-catalogue-endpoints.md
│   │           └── 01-catalogue-endpoints.receipt.md
│   ├── new-token-model/
│   │   ├── gatekeep.md
│   │   ├── context.md
│   │   ├── log.md
│   │   ├── KEY_INSIGHTS.md
│   │   └── phases/
│   └── migrate-sessions/
│       ├── gatekeep.md
│       └── ...
└── fix-csv-date-format/
    ├── gatekeep.md
    ├── log.md
    └── phases/
        └── 1-fix-format/
            ├── phase.md
            ├── prompt-plan.md
            ├── 01-fix-date-format.md
            └── 01-fix-date-format.receipt.md
```

Notice: `fix-csv-date-format` has just a `gatekeep.md`, a `log.md`, and a single phase. No `index.md` (no children to map), no `context.md` (the gatekeep says enough), no `KEY_INSIGHTS.md` (nothing worth capturing beyond the fix). A simple action is simple. Only create files you need.

---

## Node Structure

Every node in the action tree can have the following files. **Only `gatekeep.md` is required.** Everything else is created when it's useful — not before. Each file type is documented in detail in the [File Type Catalogue](./file-types/).

**`gatekeep.md`** — the completion criteria for this node. What does "done" mean here? This is the one invariant: every node, at every level, has a gatekeep. Without it, you can't answer "is this done?" See the [Gatekeeping](#gatekeeping) section.

**`context.md`** — what this action is about and, critically, which knowledge tree nodes are relevant. This is the bridge between the action tree (what you're doing) and the knowledge tree (what you know). When starting work on an action, the AI loads context.md to find the right knowledge. For simple actions this might be unnecessary — the gatekeep says enough. For complex work that touches multiple areas of the codebase, context.md tells the AI where to look.

**`index.md`** — maps this node's children. What sub-actions exist, what each one covers, how they relate. Only meaningful for branch nodes. Follows the same pattern as the knowledge tree's index files.

**`log.md`** — the session-by-session record of what happened while working on this action. This is the action's short-term memory — it tells the next session where the previous one left off. See [journaling.md — Action Log](./journaling.md#action-log) for when to write, format, and rules.

**`KEY_INSIGHTS.md`** — the working scratchpad for insights that emerge during the work. When the action completes, anything worth keeping migrates to the appropriate node in the knowledge tree. KEY_INSIGHTS is temporary; the knowledge tree is permanent. See [journaling.md — Key Insights](./journaling.md#key-insights) for the full lifecycle.

**`phases/`** — the implementation structure. Phases can exist at any level of the tree — a branch node might have its own integration phases alongside its children's implementation phases. The phase structure uses a flat file layout: phase.md (the phase spec), prompt-plan.md (sequencing prompts), and numbered implementation prompts alongside paired receipt files.

---

## Gatekeeping

Gatekeeping is the invariant that holds the action tree together. Every node has a `gatekeep.md`. At every level, you can answer "is this done?"

**For a leaf node,** the gatekeep is whatever "done" means for that piece of work. It can be concrete ("the date format in the CSV export matches ISO 8601") or subjective ("I'm satisfied that the new registration flow is clear"). The Human Lead decides what kind of gatekeep fits the work. There are no rules about which kind to use — the discipline is in writing one, not in classifying it.

**For a branch node,** the gatekeep has two parts: all children pass their own gatekeeps, AND the branch's own gatekeep passes. The branch gatekeep can be stricter than the sum of its children. "All three sub-actions work" is necessary but might not be sufficient — the branch gatekeep might add "and they integrate cleanly" or "and performance hasn't regressed." This is where the tree earns its keep: the branch gatekeep captures what the individual pieces can't.

**Writing branch gatekeeps is hard.** When you create a branch, you might not know all the children yet. The branch gatekeep needs to be abstract enough to survive children being added later, but meaningful enough to guide decisions. This is inherently difficult — it's the same challenge as defining "done" for any large piece of work. The Human Lead owns this. The Architect can help, but the judgement is yours.

**Status is computable.** Walk the tree from the leaves up. Each leaf is either done (gatekeep passes) or not. Each branch is done when all children are done and its own gatekeep passes. The overall status of any subtree is always knowable.

### What gatekeeps are not

- "It should feel right." (No decision-maker is named.)
- "Tests pass." (That's a phase done-criterion, not an action gatekeep.)
- "The AI says it's done." (The AI is never the gatekeeper.)

### When gatekeeps are unclear

If you cannot write a gatekeep, the action is probably scoped wrong. Refine the scope until "done" is articulable — even if articulable means "I'll know it when I see it, and here's roughly what I'm looking for." The discipline is in the attempt, not in the precision.

---

## The Active Stack

The active stack replaces the "one active action at a time" rule. It's a push/pop model that tracks what you're working on and the path you took to get there.

**Push** when you start working on an action — it goes on top of the stack. **Pop** when you're done with it or switching away. The stack is readable: it tells you where you are now and the order you got there. STATUS.md tracks the stack.

The stack works across trees. You might be deep in `auth-redesign/new-token-model` when a critical bug comes in. Push `fix-csv-date-format` onto the stack. Fix it. Pop it. You're back where you were, with a clear record of the interruption.

The stack also works within a tree. You might be working on `auth-redesign` at the branch level (planning, defining children) and then push into `audit-endpoints` to start implementation. When that child completes, you pop back to the parent level.

```
Stack (top = current):
  → auth-redesign/new-token-model    (implementing phase 2)
  → auth-redesign                     (planned 3 children, started first two)
```

An interrupt pushes onto the stack:

```
Stack (top = current):
  → fix-csv-date-format              (critical bug — just came in)
  → auth-redesign/new-token-model    (paused mid-phase)
  → auth-redesign                     (paused — children in progress)
```

After the fix, pop back:

```
Stack (top = current):
  → auth-redesign/new-token-model    (resuming phase 2)
  → auth-redesign                     (children in progress)
```

This model mirrors how humans actually work: depth-first with interruptions. The stack makes the interruptions traceable instead of chaotic.

---

## Recording at the Action Level

Each action node participates in the project's recording system. Session history is distributed — each node carries its own `log.md` and `KEY_INSIGHTS.md`, scoped to that action's work. When you load an action, you get its full history without digging through a global log. When the action archives, its memory goes with it — but the insights it produced live on in the knowledge tree.

The recording system — all four file types, triggers, responsibilities, and the session checklist — is defined in [journaling.md](./journaling.md). The memory model (how recordings feed the two trees) is defined in [memory.md](./memory.md). Every role should read both.

---

## Growing the Tree

The action tree grows organically. You don't scaffold a deep hierarchy upfront — you start with what you know and let the structure emerge.

**Starting simple.** Most work starts as a single node: a folder with a `gatekeep.md` and a `phases/` directory. If the work stays simple, it stays a leaf. No overhead.

**Adding children.** When a leaf outgrows its scope — the fix needs multiple independent pieces, or you realise the work decomposes naturally — you add children. The original node becomes a branch. If it already had `phases/`, those phases stay (they might represent integration work, or the initial exploration that led to decomposition). The node gets an `index.md` to map its children, and each child gets its own `gatekeep.md`.

This replaces the old promotion mechanic (task → epic → goal). There's no ceremony, no "promoted from" bookkeeping. The tree *is* the record of how the work evolved. A node that started as a simple fix and grew into a three-child branch tells its own story through its structure.

**Nesting deeper.** A child can itself become a branch. There's no limit. In practice, three levels deep is unusual — if you're going deeper, you might be over-decomposing. But the structure doesn't enforce a limit. Your judgement is the limit.

---

## Action Completion

When an action is done — its gatekeep passes — run the action completion checklist in [journaling.md — Session Recording Checklist](./journaling.md#session-recording-checklist). In summary:

1. Review `KEY_INSIGHTS.md`. Anything worth keeping migrates to the appropriate knowledge tree node. The action's insights become permanent knowledge — they outlive the action.
2. The action folder moves from `action-tree/` to `archive/`. The full subtree goes together — logs, insights, phases, everything. The archive is the historical record.
3. STATUS.md updates — the action is popped from the active stack, status marked as achieved.
4. The journal gets a brief completion note if relevant to the broader project.

For branch nodes, completion means all children are done and the branch gatekeep passes. You might complete children incrementally — archiving them individually as they finish — or complete the entire subtree at once. Your call.

---

## Archiving

Completed action subtrees move to `archive/`. This keeps the `action-tree/` folder clean — only active and pending work lives there. The archive preserves the full record: logs, insights, phases, specs, prompts, everything.

```
archive/
├── fix-csv-date-format/
│   ├── gatekeep.md
│   ├── log.md
│   └── phases/
│       └── ...
└── auth-redesign/
    ├── gatekeep.md
    ├── context.md
    ├── index.md
    ├── audit-endpoints/
    │   └── ...
    ├── new-token-model/
    │   └── ...
    └── migrate-sessions/
        └── ...
```

The knowledge the action produced already lives in the knowledge tree — the archived folder is the append-forward historical record. If you ever need to understand why a decision was made or how a piece of work evolved, the archive and the journal together tell the full story.
