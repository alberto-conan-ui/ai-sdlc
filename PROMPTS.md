# AI-SDLC: Implementation Prompt Craft

> How to write effective implementation prompts for Developer sessions.
> The quality of execution depends almost entirely on the quality of these prompts.

---

## Why This Matters

The role separation is the backbone of this methodology. The Senior Architect designs the approach, the Technical Lead translates it into prompts, and the Developer writes the code. The implementation prompt is the interface between the Technical Lead and the Developer. A good prompt produces correct code on the first attempt. A bad prompt produces confident, plausible, wrong code — and the Developer won't know it's wrong because it doesn't have the architectural context to judge.

This applies regardless of action tier. Even a task with a single prompt benefits from precision — the difference between "fix the redirect" and a properly structured prompt with verification commands is the difference between a fix that works and a fix that introduces a new bug.

Every minute spent writing a precise prompt saves ten minutes debugging the Developer's misinterpretation.

---

## The Prompt Plan — Just-in-Time Prompting

Writing all implementation prompts upfront before execution begins has the same structural problem as waterfall planning: prompt 03 is written based on the Tech Lead's *reading* of the code, not on the actual state of the code after prompts 01 and 02 have modified it. The later the prompt, the staler its assumptions.

The solution: **detail each prompt just in time, with as much or as little upfront planning as the phase needs.**

### How it works

The Tech Lead and Human Lead discuss the approach for each phase. Some phases benefit from planning the full sequence upfront; others are better served by writing one prompt at a time based on the Developer's receipts. The right approach depends on how predictable the work is.

**When a prompt plan helps:** complex phases with dependencies between prompts, phases where the Human Lead wants visibility into the full sequence before code is written, or high-risk work that warrants upfront planning. The prompt plan is a sequencing tool — the full sequence of bounded goals, with dependencies noted. Each entry is 1–3 lines.

**When to skip the prompt plan:** tasks with one or two prompts, phases that follow established patterns, exploratory work where the next step depends heavily on what the previous prompt reveals. Write prompts directly, one at a time, informed by the Developer's session receipts.

When a prompt plan exists, the Human Lead reviews it alongside the first detailed prompt. When there's no plan, the Human Lead reviews prompts at whatever cadence they've agreed on with the Tech Lead.

After the Developer completes a prompt and produces a **session receipt** (see below), the Tech Lead reads that receipt, checks modified files if needed, and writes the next detailed prompt — filling in the specifics now that the previous prompt's changes are real.

### The prompt plan format

```markdown
## Prompt Plan — Phase N

| # | Goal | Dependencies | Risk |
|---|---|---|---|
| 01 | Set up test infrastructure for validation pipeline | None | Low |
| 02 | Replace switch statement with lookup table in registry.ts | 01 complete | Medium — registry has 12 consumers |
| 03 | Migrate existing validators to new registration pattern | 02 complete | Medium — each validator is slightly different |
| 04 | Clean up dead code, update barrel exports, full test run | 03 complete | Low |
```

The prompt plan is not a spec and not a set of implementation prompts. It's a sequencing tool — enough detail for the Human Lead to evaluate the approach and enough structure for the Tech Lead to write each prompt when its turn comes.

### Human review cadence

The Human Lead controls how much oversight each prompt gets:

- **Per-prompt review** — for high-risk phases, novel architecture, or unfamiliar codebases. The Human Lead reviews each detailed prompt before the Developer gets it.
- **Batch review** — for well-established patterns. The Human Lead approves the prompt plan and lets the Tech Lead and Developer cycle through prompts, reviewing at milestones (e.g., every 3 prompts, or at the midpoint).
- **Plan-only review** — for low-risk phases that follow known patterns. The Human Lead reviews the prompt plan, then the Tech Lead and Developer execute without per-prompt gates.

The Human Lead decides the cadence per phase, based on risk and complexity. The Tech Lead can suggest — it knows the phase best.

### The session receipt

Every Developer session ends by producing a session receipt — a structured summary that enables the Tech Lead to write the next prompt accurately. The receipt format:

```markdown
## Session Receipt
- **Role:** Developer
- **Prompt:** NN — Short Description
- **Status:** Complete / Partial / Blocked
- **Accomplished:** <what was done>
- **Files created/modified:** <paths>
- **State changes:** <structural changes the next prompt needs to know — new directories, changed exports, renamed files, altered type signatures>
- **Open issues:** <anything unexpected, flagged discrepancies>
```

The **state changes** field is the most important. It captures the delta between the codebase the Tech Lead last saw and the codebase the next prompt will encounter. Without it, the Tech Lead is guessing — and guessing is how prompt assumptions go stale.

The receipt serves as both a journal contribution and a context bridge from one prompt to the next.

---

## The Four Principles

### 1. Name a reference implementation

Don't describe the pattern in prose. Point the Developer at a concrete example in the codebase.

**Weak:** "Create a new input type that registers with the pipeline, handles validation, and exports its type definitions."

**Strong:** "Read `src/shortcuts/textarea/register.ts` before starting. This is the reference implementation. Your new type should follow the same structure — same registration pattern, same export conventions, same test file layout."

The Developer is better at reading code than interpreting descriptions. A reference file removes ambiguity about style, naming, import conventions, and structural patterns. It also prevents the Developer from inventing a "better" approach that's inconsistent with the rest of the codebase.

### 2. Give the Developer bounded agency

Prompts that are too rigid break when the codebase isn't in the expected state. Prompts that are too loose produce improvised solutions. The sweet spot: a clear goal with explicit permission to adapt within defined boundaries.

**Too rigid:** "Add the following exact code to line 47 of registry.ts..."

**Too loose:** "Add validation support to the form system."

**Right:** "Add password input validation to the registration pipeline. Follow the same pattern as `textarea/register.ts`. If you encounter something unexpected — a missing export, a type mismatch, a file that's structured differently than expected — flag it and adapt rather than forcing the original plan. But don't restructure files outside the scope of this prompt."

The key phrase is "flag it and adapt." The Developer can handle minor discrepancies, but it should surface them rather than silently working around them. And "don't restructure files outside the scope" prevents scope creep.

#### The "If unexpected" section

Rather than a global autonomy setting, each prompt should include an **If unexpected** section that tells the Developer exactly which surprises are okay to handle and which require stopping. The Tech Lead calibrates this per prompt based on how confident they are in the prompt's assumptions.

```markdown
## If unexpected
- Import paths differ from what's described above → adapt silently, note in receipt
- File doesn't exist → STOP, report back
- Types don't match → adapt if the intent is clear, flag in receipt with what you changed
- Tests fail for reasons unrelated to this prompt → STOP, report back
```

This gives the Tech Lead fine-grained control without requiring the Developer to make judgement calls about what counts as "minor." Each prompt draws the line explicitly.

### 3. Include exact verification commands

Don't say "run the tests." Say exactly which command, exactly which test suite, exactly what a passing result looks like.

**Weak:** "Make sure the tests pass."

**Strong:** "Run `nx run my-lib:test -- --grep 'password'`. Expect 4 tests passing, 0 failing. If any test fails, read the failure output and fix the issue before proceeding."

This matters because:
- Projects often have multiple test runners, test configs, or test directories. "Run the tests" is ambiguous.
- The Developer needs to know what success looks like. "Tests pass" could mean "no tests exist and that's fine" in the Developer's interpretation.
- Including the expected count catches silent regressions — if 4 tests should pass and only 3 do, something was dropped.

### 4. One prompt, one bounded goal

Each implementation prompt should achieve exactly one thing and be completable without context from other prompts. The Developer session doesn't read the phase spec or the roadmap — it reads one prompt.

**Too broad:** "Implement the entire registration pipeline refactor."

**Right scope:** "Replace the hardcoded switch statement in `registry.ts` with the dynamic lookup table. After this change, `registerType()` should add entries to the lookup table, and `getType()` should read from it. The switch statement should be deleted entirely."

If a prompt takes more than one session to complete, it should be split. If a prompt requires understanding the output of a previous prompt to make sense, it's missing context — add it explicitly or restructure.

---

## Prompt Structure

Every implementation prompt follows this template (see [TEMPLATES.md](./TEMPLATES.md) for the full format):

```markdown
# Prompt NN — Short Description

> Phase: N — Name
> Prereqs: Prompt NN-1 complete (or "None")

## Goal
One paragraph: what this prompt achieves.

## Steps
Numbered, specific steps. File paths, code to write/change, commands to run.

## If unexpected
Per-prompt rules for handling discrepancies. What to adapt silently, what to flag, what to STOP on.

## Verify
Exact commands. Expected output. What success looks like.

## Done when
- [ ] Specific criterion
- [ ] Specific criterion
```

The Goal section is for the Developer's orientation — why are we doing this? The Steps section is the work. The **If unexpected** section defines the Developer's autonomy boundary for this specific prompt (see principle 2 above). The Verify section is how both the Developer and the human know it worked. The Done-when checklist is binary — each item is either true or false, no judgement calls.

---

## Common Prompt Failures

### The essay prompt

Three paragraphs of background context before getting to what needs to be done. The Developer doesn't need the history of why this architecture exists — it needs to know what to change, where, and how to verify. Background context wastes context window and increases the chance the Developer latches onto an irrelevant detail.

### The assumption prompt

"Update the component to use the new API" — assumes the Developer knows which component, which API, what "new" means, and what the old behaviour was. Every noun in a prompt should be a specific file path, function name, or code reference.

### The multi-goal prompt

"Refactor the registry, update the types, and fix the broken test." Three goals, three potential failure points, and if any one fails, the Developer's state is unclear. Split into three prompts.

### The no-verify prompt

"Implement the feature." No verification step, no expected output, no done criteria. The Developer will produce something, declare success, and move on. Without verification, you won't know if it's correct until much later — when the cost of fixing it is higher.

---

## Sequencing Prompts

The prompt plan establishes the sequence. Each prompt is numbered (01, 02, 03...) and executed in order. Each prompt should leave the codebase in a working state — tests pass, type-checker clean, no broken imports. The typical pattern:

- **Prompt 01** typically sets up infrastructure: test files, type definitions, registration boilerplate.
- **Middle prompts** implement the core logic, one bounded piece at a time.
- **The final prompt** cleans up: removes dead code, updates exports, runs the full test suite.

If a prompt introduces a temporary inconsistency (e.g., a new type that isn't yet exported), note it explicitly: "After this prompt, `PasswordInput` exists but isn't exported from the barrel. Prompt 03 handles the export."

Prompts should be independent enough that if Prompt 03 fails, you can revise and re-run it without re-running 01 and 02. This means each prompt should not undo or overwrite work from previous prompts except where explicitly stated.

Because prompts are written just in time (see The Prompt Plan above), later prompts benefit from the Developer's session receipts — they account for the actual state of the code, not the Tech Lead's pre-execution assumptions. This eliminates the most common sequencing failure: a prompt that assumes a file structure the previous prompt changed.
