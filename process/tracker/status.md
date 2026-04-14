# Status

Status is the entry point every session reads first. It is a deliberately **thin** tracker — the minimum needed for three-second orientation to where the project stands right now. Nothing more lives here, and that is the point.

## Fields

Status carries three fields plus the focus stack:

- **Mode** — which mode the session is in: Reflecting, Planning, Executing, or Salvaging.
- **Active focus** — a pointer to the current focus file, or a short description of what is happening when the stack is empty (headless).
- **Journal trail** — an append-forward list of one-line entries pointing at recent session journal files, so the next session can pick up the most recent handover immediately and see a short trail of prior sessions.
- **Focus stack** — the ordered list of focuses, with the active one on top.

That is everything. Status does not carry goals, does not carry context, does not carry narrative. It points at the things that do.

## Discipline — status does not grow

Status is the one tracker whose shape is fixed. Everything about its value lies in being thin: a session must be able to read it and know within seconds what to do next. If status starts carrying context, goals, or narrative, it stops being the entry point and starts being another layer to wade through.

When content wants to land in status, it belongs somewhere else:

- Context about the active focus → the focus file.
- Narrative about a large initiative → a knowledge-tree index the focus points to.
- History of what happened last session → the last journal entry.
- Priority notes about the stack → the focus files themselves, or the journal.

The session's job is to resist the drift that would grow status into something thicker. When the Human Lead says something that implies status should hold more, the session names the drift and redirects the content to its real home.

## Mutability

Status is mutable. It is rewritten every session — the previous state is not preserved in the file. History lives in the journal; status tracks current state only.

The write pattern: a session opens by reading status, does its work, and closes by proposing an updated status (new mode, new next step, new last journal). The Human Lead confirms or corrects, and the session writes the update. The session never edits status silently or mid-work without confirmation.

## Three-second orientation

The test for whether status is doing its job: a new session, loaded cold, should be able to read `memory/status/status.index.md` and know within seconds what to work on next. If orientation takes longer than that, status is too thick or its pointers are wrong. Both are bugs, and both get fixed at the close of the session that noticed them.

## Focus stack

Status maintains an ordered stack of focuses. The top of the stack is the active focus; everything below is paused.

**Push.** A new focus arrives. Create the focus file, push it onto the stack. The previous focus stays with its state intact.

**Pop.** The active focus completes (gate met) or is abandoned. Pop it, archive the file. The next focus becomes active. If the stack is empty after the pop, the project returns to [headless](#headless).

**Interrupts.** The stack handles interrupts naturally. A critical bug arrives during a complex redesign — push the bug fix, do it, pop it, resume the redesign.

**Reorder.** The stack is the project's priority view. The Human Lead can inspect it and reorder focuses. Reordering that changes the top of the stack is a focus switch: the session confirms the change, notes what is paused, and records the transition in the journal. The Human Lead always decides; the session keeps the stack visible and the priorities conscious.

## Headless

When the focus stack is empty, the project is **headless**. Work still happens — the Human Lead directs, the session responds — but without the structure of a focus, a gate, or an active tracker below status. Headless is the base state: every project starts here, and returns here when all focuses are popped.

Headless is not "off." Stances still apply, memory still functions, the journal still captures what happened. What is suspended is the workflow layer: no focus file, no gate, no active tracker below status. When headless, `memory/status/status.index.md` carries a brief description of what is happening in place of a pointer to a focus file.

Headless is valid for entire projects — a project that never needs tracked commitment can live its whole life headless — and equally valid as a temporary state between focuses. If headless work grows beyond ad-hoc — spanning sessions, needing a definition of done, accumulating complexity — the session should surface it and suggest creating a focus. The Human Lead decides.
