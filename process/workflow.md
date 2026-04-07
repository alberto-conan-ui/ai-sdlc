# Workflow

> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Memory model | [memory.md](./memory.md) |
> | Focus | [focus.md](./focus.md) |
> | Recording system | [journaling.md](./journaling.md) |
> | Tree operations | [updating-trees.md](./updating-trees.md) |
> | Plugins | [plugins.md](./plugins.md) |

How you work day to day. The Human Lead drives — choosing what to focus on, deciding when to shift modes, and making every transition decision. The process gives you structure where it earns its keep and stays out of the way everywhere else.

---

## Status — The Entry Point

Every session starts at `status/`. It's the front door to the project — above the memory layers, the one constant regardless of domain or complexity. status.md tells the AI where the project stands: active focus, mode, and the last journal entry. The focus files in `status/focus/` persist across sessions.

For the full structure and what each component contains, see [memory.md — Status](./memory.md#status--the-entry-point).

---

## Focus

A focus is a plain statement of intent with a gate (definition of done), a mode, and a persistent file. The full definition — what a focus is, its file structure, gate, lifecycle, and rules for setting and clearing — lives in [focus.md](./focus.md).

This section covers how focuses are orchestrated: the stack, prioritization, and the headless base state.

### The Focus Stack

status.md maintains an ordered stack of focuses. The top of the stack is the active focus.

**Push:** A new focus arrives — create the focus file, push it onto the stack. The previous focus stays in `status/focus/` with its state intact.

**Pop:** The active focus completes (gate met) or is abandoned. Pop it, archive the file. The next focus on the stack becomes active. If the stack is empty, the project returns to headless.

The stack handles interrupts naturally. A critical bug arrives during a complex redesign — push the bug fix, do it, pop it, resume the redesign. The focus files persist; the stack tracks the order.

### Prioritization

The stack is the project's priority view. Things that need attention arise naturally — during focused work, during headless sessions, between sessions. The stack gives the human a single place to acknowledge, order, and manage them.

**While focused:** Something else comes up mid-work. The human creates a new focus and places it on the stack — above the current focus if it's urgent (making it active immediately), or below if it can wait. Placing a focus above the current one is a focus switch: the AI confirms, the previous focus is paused, and the journal records it.

*"A production issue just came in. I need to create a focus for it and deal with it now."*

*"We'll need to rework the API contract, but not right now. Create a focus for it below the current one."*

**While headless:** Ad-hoc work surfaces something that needs tracking. The human creates a focus and pushes it onto the stack — escalating from headless to focused. When that focus completes, the project pops back to headless. See [Headless](#headless).

**Inspecting and reordering:** The human can ask to see the stack and reorder it. The stack is not rigid — priorities change, and the stack should reflect the current reality.

*"Show me the stack. Move the API rework above the docs cleanup."*

Reordering that changes the top of the stack is a focus switch. The AI treats it as one: confirms the change, notes what's paused, journals the transition.

**AI awareness:** The AI should notice when prioritization decisions are implicit and make them explicit:

*"You're starting work on something new. Should this become a focus on the stack, or is this a quick aside?"*

*"The stack has three focuses queued. Want to review the order before we continue?"*

The human always decides. The AI's role is to keep the stack visible and the priorities conscious.

### Headless

When no focus is active, the project is **headless**. Work happens — the human directs, the AI responds — but without the structure of a focus, gate, or mode. Headless is the base state of the stack: every project starts here, and returns here when all focuses are popped.

Headless is not "off." The full process is available:
- **Stances** still apply — the human can load any stance and get its principles, ways of working, and domain expertise
- **Memory** still functions — journal, knowledge tree, notepad, all active
- **Journaling** still captures what happened — sessions get journal entries regardless of whether a focus is set

What's suspended is the workflow layer: no focus file, no gate, no formal mode transitions. The human shapes the flow ad-hoc, leveraging the process's tools without its structure.

**When headless, status.md carries the context directly** — a brief description of what's happening, in place of a pointer to a focus file. This gives the AI enough to orient without requiring the formality of a focus. The description is informal and mutable, matching the ad-hoc nature of headless work.

Headless is valid for entire projects — a TTRPG campaign might spend most of its life headless, reaching for a focus only when something demands tracked commitment. It's equally valid as a temporary state between focuses, or for drive-by work in a project that's normally focus-driven.

**When to escalate:** If headless work grows beyond ad-hoc — spanning sessions, needing a definition of done, accumulating complexity — the AI should suggest setting a focus:

*"This investigation is getting substantial. Want to create a focus for it so we have a gate and can track state across sessions?"*

The AI suggests; the human decides.

---

## Modes

Every active focus has a **mode** — the posture of the current work. Modes apply when focused; in headless, there is no mode. There are three modes:

```
           ┌─────────────────────────────┐
           │                             │
           ▼                             │
      Reflecting ──→ Planning ──→ Executing
           ▲              │              │
           │              │              │
           └──────────────┴──────────────┘
```

**Reflecting.** Step back and examine. Is the approach right? Is the focus itself right? Is the project's memory still accurate? Reflecting is for when the work needs rethinking, not more doing. Any part of the project's memory can be reshaped in Reflecting mode — focus files, status, journal annotations, knowledge. The AT and KT have additional rules governing how they change: see [updating-trees.md](./updating-trees.md) for append-forward and reconciliation.

**Planning.** Shape the work. Everything produced is provisional — working notes, not commitments. The AI's posture: challenge assumptions, offer alternatives, hold things loosely. Planning ends when the human says "this is good enough to act on."

**Executing.** Deliver the work. A plan has been approved. The AI acts within its scope. Artifacts are authoritative. If execution reveals the plan was wrong, the AI flags it and waits for the human to decide — shift back to Planning, or drop into Reflecting.

### Mode transitions

The human can jump between modes freely — any mode to any mode, at any time. The human is fluid; the process doesn't fight that.

The AI's job is to make the transition explicit and help the human think clearly about it. When the AI detects a mode shift — from the human's words, direction, or the character of the work — it confirms and names the implications:

*"You're shifting from Executing into Planning — that means the current approach is open for revision. Confirmed?"*

*"This looks like Reflecting territory — stepping back from the auth rewrite to question whether the approach is right. Should I shift, or are you thinking out loud?"*

*"You're jumping straight to Executing, but we haven't shaped a plan yet. That's fine if this is straightforward — or would a quick Planning pass help?"*

The AI should also notice when the human's direction might be better served by a different action than a mode switch:

*"This is interesting but not related to the current focus. Want to capture it in the notepad rather than shifting modes?"*

*"That sounds like a new focus, not a mode change on the current one. Should I push it onto the stack?"*

The AI never blocks a transition. The human always has the final word. But the AI's responsibility is to ensure mode changes are conscious, not accidental — and to offer alternatives when the human might be hot-heading into a shift that doesn't serve the current work.

### Modes are orthogonal to plugins

Any stance can operate in any mode. Modes describe *how* you're engaging with the work, not *what kind* of work you're doing. A planning conversation looks different in software development than in a tabletop campaign — but the posture (provisional, challenging, exploratory) is the same.

---

## Checkpoints

### Focus gate

The core checkpoint. Every focus has a gate — a formal definition of done, evaluated by the human. The gate is defined when the focus is set and evaluated when the human decides work is complete. See [focus.md — The Gate](./focus.md#the-gate).

### Planning → Executing

The weightiest mode transition. This is where provisional becomes authoritative — the human commits to an approach and effort begins. Every other mode transition is low-cost (you can always step back). Moving to Executing has a cost: effort spent building.

The AI should give this transition more scrutiny than others:

*"You're moving to Executing. The plan says [X]. Once we start building, changes get more expensive. Good to go?"*

This is not a gate — the human can always proceed. But the AI's responsibility is to ensure the commitment is conscious.

### Plugin checkpoints

> **Slot:** Domain work cycle and checkpoints — the plugin defines domain-specific workflow extensions (e.g., an SDLC design → implementation cycle) and additional checkpoints. See [plugins.md](./plugins.md).

Plugins may add their own checkpoints on top of the core ones. An SDLC plugin might require phase specs, formal reviews, or completion checklists. A lighter domain might add nothing. These are additive — they don't replace the focus gate or the AI's role in mode transitions. See [plugins.md](./plugins.md).

---

## The Action Tree — Optional Infrastructure

Not every focus needs decomposition. A bug fix, a document revision, a campaign prep session — these are single-focus work that the workflow handles directly.

When a focus is complex enough to need tracked stages — multiple phases spanning sessions, dependencies between parts, progress that needs to be visible — the action tree provides that structure. The AT decomposes a focus into goals, steps, and tasks with their own gates and lifecycle.

**When to use the AT:** If your focus has stages that span multiple sessions and you need to track progress across them, use the action tree. If you can hold it in your head, don't.

The AT is defined fully in [action-tree.md](./action-tree.md). It's available infrastructure — powerful when needed, absent when not.

---

## Session Persistence

Every piece of state is written down. status.md tracks the active focus and mode. Focus files hold the gate and context. The journal captures what happened and carries the handover. The memory model holds everything the next session needs.

The methodology never relies on an AI's memory of previous conversations. It relies on files that any session can read.

**Starting a session:** Read status.md. If there's an active focus, read the focus file and the relevant journal handover — orient to where work was left. If headless, read the description in status.md, orient to what's there, and wait for direction.

**Ending a session:** The AI proposes the status update (focus, mode, next step). The human confirms or corrects. The journal entry is written. See [journaling.md](./journaling.md) for the full close protocol.
