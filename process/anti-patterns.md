# Anti-Patterns

> **See also:** [principles.md](./principles.md), [workflow.md](./workflow.md), [journaling.md](./journaling.md)

---

## "Just do it"

Skipping the planning step because "it's a small change." Small changes that touch shared infrastructure are where the worst bugs hide. If it touches more than one file or changes behaviour, it deserves at least an action with a short spec — even a three-paragraph one.

---

## Amnesia sessions

Starting a new AI session without loading context. The AI will contradict previous decisions, reintroduce rejected patterns, or redo completed work. The context loading protocol exists for this reason — each stance has specific files to load (see the "Files to Load" section in each stance file under [roles/](../roles/)).

---

## The 500-line status file

Putting implementation detail in `status.md` or `action-tree.index.md` instead of phase specs. The status file is for current state and the active stack; the AT root index is for tree structure — not for spec-level detail. All detail lives in the phase specs (phase folder index files).

---

## Silent plan changes

Revising a spec without recording what changed. The next session reads the plan assuming it's the original and misses the context for why it was revised. Follow the append-forward principle: create a new version of the spec, record the decision in the journal. The old version stays as the record of what was believed at the time.

---

## Snapshot testing as a shortcut

Using snapshot tests instead of targeted assertions. Snapshots break on incidental changes and don't communicate intent. They give a false sense of coverage without proving behaviour is preserved.

---

## The green bar illusion

AI-generated tests that pass without asserting anything meaningful. `expect(result).toBeDefined()` proves nothing. `expect(result).toBeTruthy()` on an object that's always truthy proves nothing. When an AI writes tests, verify that the assertions are specific: exact property values, exact array lengths, exact types, exact error messages. If the test would still pass with a completely wrong implementation, it's not a test.

This is the most common AI testing failure mode. The AI optimises for green — a passing test suite — not for coverage of actual behaviour. Treat AI-generated tests with the same scrutiny you'd give a junior developer's first PR.

---

## Testing after the fact

Writing a separate "add tests" phase after features are built. Tests are part of the definition of done for each phase. A feature without tests is incomplete. Before any refactor that moves code between modules, write tests that assert current behaviour — run them before and after. If they pass without changes to the test files, the refactor preserved behaviour.

---

## The improvising Developer

A Developer session that encounters something unexpected and decides to "fix it" instead of reporting back. The Developer stance's job is to follow the prompt literally. If the prompt doesn't account for the current state of the code, the correct response is to follow the "If unexpected" section or report back. Improvised fixes compound — each one makes the next prompt's assumptions less accurate.

---

## Stance bleed

When the AI's output starts mixing stances — the Architect over-specifying implementation details, the Developer second-guessing prompts instead of following them, the Tech Lead redesigning the spec instead of translating it. This is a signal, not a catastrophe. If you notice stance bleed, separate the stances into different sessions. If you don't notice it, compression is working fine. The risk is highest between design (Architect/Tech Lead) and execution (Developer) — which is why a fresh Developer session is recommended for complex work.

---

## The rubber stamp

The AI writes a journal entry — you glance at it, looks fine, move on. The AI proposes a knowledge contribution — seems reasonable, leave it. The AI updates the AT root index — sure, whatever. The artefacts accumulate, all technically present, none actually reviewed. Three weeks later, the AI loads knowledge tree nodes that are too vague to be actionable, journal entries that mischaracterise what happened, and an AT root index that doesn't reflect the real state. The knowledge tree looks complete but teaches nothing.

This is the most insidious failure mode because the process *appears* to be working. All the artefacts exist. But the human review that gives those artefacts their value never happened. The AI generates volume; only your critical attention makes that volume trustworthy.

The fix is not to review more — it's to review better. Read the AI's journal entry and ask: does this actually capture what happened? Read the knowledge contribution and ask: is this specific enough that a fresh AI session could act on it, or is it generic advice? If the answer is "generic," rewrite it or remove it. Five minutes of engaged review is worth more than an hour of passive accumulation.

For the full set of recording anti-patterns, see [journaling.md — Recording Anti-Patterns](./journaling.md#recording-anti-patterns).

---

## Under-decomposing or over-decomposing

Keeping everything as a flat leaf action to avoid process overhead, even when the work clearly needs decomposition into sub-actions. If the gatekeep has many unrelated conditions, or the work spans multiple independent areas, break it into children. Forcing complex work through a single leaf means skipping the planning that would have caught problems early. Conversely, decomposing a simple bug fix into a three-level tree wastes time on structure that adds no value. Match the tree depth to the work's actual complexity.
