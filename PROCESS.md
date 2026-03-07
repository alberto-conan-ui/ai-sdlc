# AI-SDLC: Process Guide

> A methodology for AI-assisted software development.
> Derived from real project experience. Tool-agnostic — works with any AI coding assistant.

---

## The Core Idea

AI coding assistants are powerful executors but unreliable architects. Left to their own devices, they produce code that works locally but accumulates debt globally. They don't remember what they did yesterday. They don't know why a decision was made three sessions ago. They'll happily redo work, contradict earlier choices, or introduce abstractions that clash with the existing codebase.

This methodology fixes that by treating AI development like a disciplined engineering process: plan before you code, record what you decide and why, accumulate lessons across sessions, and never let an AI agent operate without context.

The result is that session 10 benefits from every mistake caught in sessions 1 through 9 — not through model fine-tuning, but through structured context that the AI reads at the start of each session.

---

## Principles

### 1. Plan before you code — especially with AI

A flawed design doc costs an hour to rewrite. Flawed code costs a day to untangle. This is even more true with AI agents, because they can produce large volumes of wrong code very quickly.

Every unit of work (called a "phase") gets a written plan before any code is written. The plan includes: what problem it solves, what steps to take, what files are touched, how to verify it's correct, and explicit done-criteria.

If someone (human or AI) is asked to implement something and no plan exists, the correct response is to write the plan, not start coding.

### 2. Separate the planner from the executor

The AI that designs the approach should not be the same AI session (or even the same tool) that writes the code. This separation exists because:

- **Planning requires broad context.** The planner reads specs, traces code paths, considers trade-offs, and writes a detailed phase doc. It needs to hold the full picture.
- **Execution requires focused context.** The executor follows a specific, bounded prompt: "do this, in this file, verify with this command." It doesn't need the full architectural picture — and loading it would waste context window.
- **Review becomes possible.** The human reviews the plan before execution begins. Bad designs are caught on paper, not in pull requests.

In practice, the planner produces numbered implementation prompts that the executor runs in sequence. Each prompt is self-contained — it states what to do, which files to touch, and how to verify success. The executor doesn't need to read the spec or the plan; the prompt has everything.

### 3. Accumulate knowledge across sessions

AI sessions are stateless by default. Every new conversation starts from zero. This methodology compensates by maintaining a structured knowledge base that the AI reads at the start of each session:

- **Decisions log** — what was decided and why. Prevents the AI from re-litigating settled questions or making contradictory choices.
- **Lessons learned** — actionable entries in the format "do Y instead of Z because..." Not vague ("X was hard") but specific and prescriptive. These are the highest-value artefact in the system — they're effectively fine-tuning the AI's behaviour through context.
- **Session log** — what was done, by whom, which files were touched. Gives the next session a running start.
- **Journal** — one-line timeline entries across all work. Quick orientation.

### 4. Phases are the unit of work

All work is organised into phases. A phase is a bounded chunk of work with a clear goal, concrete steps, and done-criteria. Phases are:

- **Sequential** — each phase builds on the previous. The roadmap shows the order.
- **Small enough to complete in 1-3 sessions** — if a phase can't be finished in a day or two, it should be split.
- **Self-contained for review** — each phase has its own spec, its own implementation prompts, and its own verification. You can review and approve a phase without understanding the entire project.
- **Checkpoints for rollback** — if a phase goes wrong, you revert to the previous phase's state. Clean boundaries make this safe.

### 5. Dig deep before committing to a plan

A plan written without reading the code is a guess. Before writing a phase plan, the planner must:

- Read the relevant source files
- Trace execution paths end to end
- Identify edge cases and existing patterns
- Check for existing tests, build commands, and project conventions

Phase plans should reference specific file paths, show code snippets of current behaviour, and include tables of test cases with exact inputs and expected outputs. Vague plans produce vague code.

### 6. Plans evolve, but changes are tracked

Phase plans are living documents — they can and should be revised when new information emerges during implementation. But changes are never silent. Every revision gets:

- A version bump in the doc header
- An entry in the decisions log explaining what changed and why
- A journal entry noting the revision

This matters because multiple AI sessions and humans may reference the same plan. Silent changes create confusion.

### 7. Test at the boundary of what's changing

Before any refactor that moves code between modules, write automated tests that assert the current behaviour. Run them before the refactor, run them after. If they pass without changes to the test files, the refactor preserved behaviour.

Key testing principles:

- **Baseline every code path the refactor touches** — not just the obvious methods. Trace every conditional branch, every type-specific import.
- **Test at the right abstraction level** — if you're refactoring a data pipeline, write pipeline tests (data in, data out), not E2E browser tests. Test the boundary of what's changing.
- **Targeted assertions, not snapshots** — assert specific properties. Snapshots break on incidental changes; targeted assertions survive refactors if behaviour is preserved.
- **Every new feature ships with its tests** — no separate "test batch" phase. Tests are part of the definition of done, not a standalone effort.

---

## The Workflow

### Starting a new project

1. Set up the workspace — three sibling folders: code repo, project journal repo, ai-sdlc methodology (see [SETUP.md](./SETUP.md))
2. Initialise the project journal repo with INDEX.md, JOURNAL.md, DECISIONS.md, LESSONS_LEARNED.md
3. Write a SPEC.md for the first workstream (the vision: what problem, what the solution looks like, design principles)
4. Write a CONTEXT.md (codebase reference: repo structure, key files, existing patterns)
5. Write a PLAN.md (the roadmap: list of phases, current status)
6. Start Phase 1

### Starting a session

1. Read the project's PLAN.md to see current status
2. Read LESSONS_LEARNED.md (both global and project-scoped)
3. Read the last few JOURNAL.md entries
4. Read the active phase's spec
5. Continue where the previous session left off

### Planning a phase

1. The planner reads the codebase deeply (relevant source files, tests, configuration)
2. The planner writes a phase spec under `phases/N-name/SPEC.md` including: problem/goal, concrete steps, test cases, done criteria
3. The human reviews and approves the spec
4. The planner writes numbered implementation prompts under `phases/N-name/impl/`
5. The human reviews the prompts

### Executing a phase

1. The executor runs prompts in order (01, 02, 03...)
2. Each prompt is self-contained — it states what to do and how to verify
3. After each prompt, verify the done-criteria before moving to the next
4. If a prompt fails or needs adjustment, report back to the planner for a revised prompt

### Finishing a session

1. Update PLAN.md statuses
2. Add a SESSION_LOG.md entry (what was done, by whom, files touched, open threads)
3. Add a line to JOURNAL.md
4. If something was learned, add it to the appropriate LESSONS_LEARNED.md

### Reviewing and evolving the roadmap

After completing a cluster of phases, review the roadmap:

- Are the remaining phases still correctly scoped?
- Did implementation reveal new work that should be a phase?
- Should phases be split, merged, or reordered?

Log any changes in the decisions log and journal. Renumber phases if the execution order changes — old numbering has no historical value once the plan is revised.

---

## Roles

| Role | Responsibility | Typical tool |
|---|---|---|
| **Lead / Human** | Reviews plans, approves phases, makes final calls, provides domain context | — |
| **Planner** | Reads codebase, writes specs and phase plans, produces implementation prompts, reviews executor output | AI assistant with broad context (e.g., Cowork, Claude) |
| **Executor** | Follows implementation prompts, writes code, runs tests | AI coding agent (e.g., Windsurf, Cursor, Claude Code) |

The same human can fill the Lead role and supervise both AI roles. The key is that planning and execution are separate activities with a review gate between them.

---

## Anti-Patterns

### "Just do it"
Skipping the planning step because "it's a small change." Small changes that touch shared infrastructure are where the worst bugs hide. If it touches more than one file or changes behaviour, write a phase spec.

### The 500-line plan
Putting implementation detail in PLAN.md instead of phase docs. PLAN.md is a roadmap — phase table, links, status. All detail lives in the phase docs.

### Amnesia sessions
Starting a new AI session without loading context. The AI will make decisions that contradict previous sessions, re-introduce patterns that were explicitly rejected, or redo work that's already done.

### Snapshot testing as a shortcut
Using snapshot tests instead of targeted assertions. Snapshots break on incidental changes and don't communicate intent. They give a false sense of coverage without proving behaviour is preserved.

### Testing after the fact
Writing a separate "add tests" phase after features are built. Tests are part of the definition of done for each phase. A feature without tests is not complete.

### Silent plan changes
Revising a plan without logging what changed. The next session (or the next person) reads the plan assuming it's the original and misses the context of why it was revised.
