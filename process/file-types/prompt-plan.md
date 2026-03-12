# prompt-plan.md

**Type name:** prompt-plan
**File:** `prompt-plan.md`
**Location:** `action-tree/<action>/phases/N-name/prompt-plan.md`
**Required:** No — optional for simple actions with 1-2 prompts
**Created by:** Tech Lead
**Maintained by:** Tech Lead updates as the sequence evolves
**Used by:** Tech Lead (produces before writing the first detailed prompt)

---

## Purpose

Sequences the implementation prompts for a phase before any detailed prompt is written. A high-level plan that answers: how many prompts, in what order, with what dependencies and risks. The Tech Lead produces this before writing the first detailed prompt.

Sits flat in the phase folder alongside phase.md.

---

## Format

```markdown
# Prompt Plan — Phase N

| # | Goal | Dependencies | Risk |
|---|---|---|---|
| 01 | <bounded goal in one line> | None | Low / Medium / High — <reason if not Low> |
| 02 | <bounded goal> | 01 complete | <risk> |
| 03 | <bounded goal> | 02 complete | <risk> |
```

### Column guide

- **Goal** — one line describing the bounded outcome. Specific enough that the Human Lead can evaluate the approach.
- **Dependencies** — which prompts must complete first. Usually just `NN complete`. Can also include external conditions (`main merged`, `CI green`).
- **Risk** — Low / Medium / High with a brief reason. Captures technical unknowns, scope creep potential, or anything that might cause the prompt to need revision. A `Medium` prompt is one where the Tech Lead's assumptions might not hold; a `High` prompt is one where the approach might be fundamentally wrong.

---

## Real Example

From a real project — anonymised. Note the revision history: the original plan (3 prompts) gained a Prompt 00 after a type conflict was discovered during implementation.

```markdown
# Prompt Plan — Phase 1

> **Revision 2:** Added Prompt 00 to fix pre-existing type conflict. Original
> prompts unchanged, just shifted by one.
>
> **Revision 3:** Corrected Prompt 00 scope after review. 5 locations not 4:
> one site has a silent bug hidden by a type cast — tsc won't catch it.

| # | Goal | Dependencies | Risk |
|---|---|---|---|
| 00 | Resolve all type errors from the merge: map aliases to real values in 3 source files, fix 1 consumer, update 7 test assertions, verify tsc clean + grep for cast-hidden errors | None | Low — 5 locations, ~20 lines, mechanical |
| 01 | Copy pipeline to shared library, rewire internal imports, consolidate registration, convert default→named export, wire barrel, verify build | 00 complete | Medium — 14 files need import rewriting; one missed import breaks the build |
| 02 | Update all 18 consumer files to import from shared library, delete old directory, verify build and zero old-path imports remain | 01 complete | Low — mechanical find-and-replace, but 27 import statements across 18 files |
| 03 | Confirm existing tests pass at new location, write new error-path / edge-case / precedence tests, run full build + test | 02 complete | Medium — new tests require understanding pipeline internals; test config may need path adjustment |
```

---

## Notes

- For simple actions with 1-2 prompts, the plan is optional — just write the prompt directly.
- Each row represents one implementation prompt (`NN-description.md`).
- The prompt plan is append-forward: when the sequence changes, add a revision note (as shown in the example) rather than silently editing.
- See [prompts.md](../prompts.md) for the full just-in-time prompting model.
