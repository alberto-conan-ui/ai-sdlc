# AI-SDLC: Implementation Prompt Craft

> How to write effective implementation prompts for Developer sessions.
> The quality of execution depends almost entirely on the quality of these prompts.

---

## Why This Matters

The role separation is the backbone of this methodology. The Senior Architect designs the approach, the Technical Lead translates it into prompts, and the Developer writes the code. The implementation prompt is the interface between the Technical Lead and the Developer. A good prompt produces correct code on the first attempt. A bad prompt produces confident, plausible, wrong code — and the Developer won't know it's wrong because it doesn't have the architectural context to judge.

Every minute spent writing a precise prompt saves ten minutes debugging the Developer's misinterpretation.

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

## Verify
Exact commands. Expected output. What success looks like.

## Done when
- [ ] Specific criterion
- [ ] Specific criterion
```

The Goal section is for the Developer's orientation — why are we doing this? The Steps section is the work. The Verify section is how both the Developer and the human know it worked. The Done-when checklist is binary — each item is either true or false, no judgement calls.

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

Implementation prompts within a phase are numbered (01, 02, 03...) and executed in order. Each prompt should leave the codebase in a working state — tests pass, type-checker clean, no broken imports. This means:

- **Prompt 01** typically sets up infrastructure: test files, type definitions, registration boilerplate.
- **Middle prompts** implement the core logic, one bounded piece at a time.
- **The final prompt** cleans up: removes dead code, updates exports, runs the full test suite.

If a prompt introduces a temporary inconsistency (e.g., a new type that isn't yet exported), note it explicitly: "After this prompt, `PasswordInput` exists but isn't exported from the barrel. Prompt 03 handles the export."

Prompts should be independent enough that if Prompt 03 fails, you can revise and re-run it without re-running 01 and 02. This means each prompt should not undo or overwrite work from previous prompts except where explicitly stated.
