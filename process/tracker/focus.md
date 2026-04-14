# Focus

A focus answers one question: **what are you working on?** It is the flexing tracker — the one instance of the tracker primitive that grows and contracts with the shape of the work it holds. A bug fix lives in a focus. A major release lives in a focus. Both are correct, and the focus file scales between them.

## The flexing tracker

Every focus inherits the four tracker fields from [tracker.index.md](./tracker.index.md) — stack, active child pointer, journal trail, gate — and extends with whatever the work needs: description, references, context, constraints.

A simple focus is entirely self-contained. One file, a one-line description, a one-line gate, no knowledge tree, no action tree. A bug fix looks like that and should stay that way.

A medium focus carries more. A description paragraph, references to a few knowledge-tree nodes, an action-tree decomposition of the work into stages. The focus file is still the root — everything else is referenced from it.

A heavy focus — a major release, a multi-month initiative — carries a gate that points into the knowledge tree, a narrative index that tells the full story, and an action tree that decomposes the work. The focus file itself stays lean; the weight lives in what it points to.

All three shapes are valid. The focus grows only when the work demands it, and it grows by extending organically, not by scaffolding ahead.

## Where the file lives

Each focus is a single file at `status/focus/[name].md`. The file persists across sessions — it is the durable home for the focus, surviving interrupts and session boundaries. When the focus completes or is abandoned, the file moves to `status/focus/archive/`.

## The gate is the most important part

Every focus has a **gate**: the goals that define done. The gate is not a prose description of completion — the goals themselves are the criteria. The Human Lead and the session both agree the goals are met before the focus closes.

Example:

> **Focus:** Auth middleware rewrite
>
> **Gate:**
> - Token refresh works without session storage
> - All existing auth tests pass against the new middleware
> - No session tokens stored in a way that violates the compliance requirements

The gate is load-bearing. Without it, work drifts: the session produces output, the Human Lead cannot check whether that output is actually complete, and the focus becomes a bucket for anything adjacent. A session must refuse to set a focus without a gate. "We'll figure out done as we go" is not a gate — it is the absence of one, and the absence of a gate is the absence of a focus.

## Sizing

Start self-contained. A focus should begin as a single file with a gate and enough context to work. Add action-tree nodes when progress needs tracking across sessions. Add knowledge-tree references when knowledge outgrows the tracker itself. The trigger is organic, not a threshold.

Two signals that the focus is wrongly sized:

- **Reaching for the action tree before the first session is done.** Either the focus is too large for one focus, or the session is scaffolding ahead of the work. In both cases, the session should pause and surface the concern.
- **The gate keeps shifting.** If the goals that define done cannot hold still across two or three sessions, the focus is too vague to be acted on, and the right move is to step back into Reflecting mode until the gate stabilizes.

## Setting, changing, and clearing

The Human Lead sets a focus explicitly. The session confirms, ensures the gate is defined, and records the change in `memory/status/status.index.md` and the journal. The session never sets a focus on its own. When the conversation implies a new focus — a new topic, a different goal, an interrupt — the session pauses and confirms rather than drifting silently into new context.

Changing an active focus — repointing it, rewriting its gate, adjusting its scope — is a Human Lead decision the session surfaces and records but does not initiate. A focus whose gate is silently edited has lost its most important property.

Clearing a focus happens when the Human Lead decides the gate is met (completion) or decides the focus is no longer worth pursuing (abandonment). In both cases the file moves to archive, the stack pops, and `memory/status/status.index.md` updates to point at whatever is now on top. If the stack is empty after the pop, the project returns to headless.
