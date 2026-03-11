# AI-SDLC Editorial Critique — Draft Review

> Reviewer: Claude (AI editor)
> Date: 2026-03-11
> Scope: All 38 markdown files across `process/`, `roles/`, `bootstrap/`, `flows/`, and `process/file-types/`
> Focus: Repeated information, atomicity, structure for dual human+AI readership

---

## Executive Summary

The writing quality is high — clear voice, strong opinions, well-reasoned. The methodology itself is coherent and the conceptual architecture (two trees, journal, five stances, two modes) is sound. The main editorial problems are **structural, not substantive**: heavy repetition across files, unclear information hierarchy for AI consumption, and a file-type catalogue that was created to be the single source of truth but isn't actually treated that way by the other documents.

The core tension: the docs were written to be **independently readable** (each file is "self-contained"), but this produced massive duplication. For human readers skimming linearly, that redundancy is tolerable. For an AI loading files into a context window, every repeated paragraph burns tokens and creates ambiguity about which version is canonical. The fix is to commit to atomicity — define once, reference everywhere — which is exactly the principle the methodology itself espouses (append-forward, single source of truth for STATUS.md). The docs need to eat their own dogfood.

---

## 1. Repeated Information — The Big Offenders

### 1.1 The "Append-Forward" Principle (defined 4+ times)

The append-forward principle is fully explained in:

- `process/principles.md` — the canonical definition (Section: Append-Forward)
- `process/journaling.md` — Section: "The Append-Forward Rule" (full re-explanation, ~150 words)
- `roles/principles.md` — Rule 4: Append-Forward (another full re-explanation)
- `process/anti-patterns.md` — "Silent plan changes" (restates the principle in negative form)
- `process/workflow.md` — mentioned in "Handling issues" and "Phase handovers"

**Recommendation:** Define it once in `process/principles.md`. Every other file should reference it with a one-line summary and a link. The journaling.md section should say: "All recording files follow the append-forward principle (see [principles.md](./principles.md#append-forward)). Never edit or delete entries after they're written."

### 1.2 The Memory Model Overview (defined 3+ times)

The "two trees + journal" model is explained with nearly identical prose in:

- `README.md` — "The Core Ideas" section and "Why This Works > Knowledge compounds"
- `process/principles.md` — "The Memory Model" section (full 3-paragraph explanation)
- `process/memory.md` — the canonical reference (this is where it belongs)

The README and principles.md each independently provide ~200 words of memory model explanation that largely duplicates memory.md.

**Recommendation:** README.md should give a 2-3 sentence teaser with a link to memory.md. principles.md should state the principle ("the methodology maintains persistent memory") and link to memory.md for the mechanism. Neither should reproduce the flow diagram or tree descriptions.

### 1.3 The "Rubber Stamp" Anti-Pattern (defined 3 times)

Nearly identical text appears in:

- `process/anti-patterns.md` — "The rubber stamp" (~180 words)
- `process/journaling.md` — "Recording Anti-Patterns > The rubber stamp" (~130 words)
- `process/principles.md` — embedded in "Human Accountability" (same concept, different phrasing)

**Recommendation:** Define it once in `process/anti-patterns.md`. journaling.md should say "See [anti-patterns.md — The rubber stamp](./anti-patterns.md#the-rubber-stamp)" and add only the recording-specific nuance (if any).

### 1.4 Engagement Modes (Shaping/Working tables reproduced 3 times)

The "what each mode does" tables appear in:

- `README.md` — prose description of both modes (~200 words)
- `process/workflow.md` — full table definitions (the canonical location)
- `process/journaling.md` — recording-specific tables that partially duplicate workflow.md's tables
- `process/roles.md` — mentions mode per stance

**Recommendation:** workflow.md owns the mode definitions. journaling.md should own only the recording-specific rules per mode (which it already does well in the "How recording changes per mode" table). README.md should give a one-paragraph summary with a link.

### 1.5 "Developer is exempt from memory maintenance" (stated 5+ times)

This fact is stated in:

- `roles/developer.md` — the header note, "Files to Load", and "Boundaries"
- `roles/common.md` — note about the Developer exception
- `process/journaling.md` — "Who Writes What" and "The Developer exception"
- `process/roles.md` — under "Common Foundation"
- `process/file-types/session-receipt.md` — "The Developer's sole contribution"
- `process/file-types/action-log.md` — "The Developer doesn't write log entries"

**Recommendation:** State it once in `roles/developer.md` and once in the "Who Writes What" matrix in journaling.md. All other files should reference rather than restate.

### 1.6 KEY_INSIGHTS.md lifecycle (explained 3+ times)

- `process/memory.md` — "The KEY_INSIGHTS.md Lifecycle" section
- `process/file-types/key-insights.md` — the canonical file-type definition
- `process/journaling.md` — Working mode pipeline description
- `process/knowledge-tree.md` — "Not in the knowledge tree" section
- `process/workflow.md` — Action Completion section

**Recommendation:** `process/file-types/key-insights.md` owns the lifecycle. memory.md should have a 2-sentence summary with a link.

### 1.7 "Insights must be prescriptive, not descriptive" + the same examples

The exact same good/bad examples ("The API is tricky" vs. "The validation API silently swallows errors...") appear in:

- `process/knowledge-tree.md` — "Knowledge File Format"
- `process/file-types/knowledge-spec.md` — Notes section
- `roles/curator.md` — Audit process step 3
- `process/file-types/key-insights.md` — Notes section

**Recommendation:** Define the rule with examples once in `process/knowledge-tree.md` (or in the knowledge-spec file-type doc). Everyone else links.

### 1.8 Session receipt "State changes is the most important field"

Stated in:

- `process/prompts.md` — twice (in the session receipt section and in the four principles)
- `process/file-types/session-receipt.md` — Notes
- `roles/developer.md` — "When You're Done"
- `roles/tech-lead.md` — "Reviewing Developer output"

### 1.9 The four prompt craft principles

Fully described in:

- `process/prompts.md` — canonical location (~800 words)
- `roles/tech-lead.md` — "The four principles of prompt craft" (~400 words, near-duplicate)

**Recommendation:** prompts.md owns the principles. tech-lead.md should say: "Follow the four principles of prompt craft defined in [prompts.md](../process/prompts.md#the-four-principles)."

---

## 2. Structural Issues

### 2.1 The file-type catalogue exists but isn't the single source of truth

The `process/file-types/README.md` declares itself "the single source of truth for each file type." But in practice, the narrative documents (journaling.md, memory.md, action-tree.md, knowledge-tree.md, prompts.md) all contain substantial format descriptions, lifecycle explanations, and templates that duplicate or extend what's in the catalogue.

This creates ambiguity: if an AI needs to know the format of `KEY_INSIGHTS.md`, should it read `process/file-types/key-insights.md` or `process/memory.md` or `process/journaling.md`? All three have relevant information, and they're not identical.

**Recommendation:** Commit to the catalogue as the atomic source for every file type's **format, rules, ownership, and engagement mode**. The narrative documents (memory.md, journaling.md, etc.) should explain **why** and **when** and **how files connect** — but never reproduce formats or rules. This is the single most impactful structural change.

### 2.2 templates.md is an awkward hybrid

templates.md contains:

1. The full project memory structure diagram (also in README.md and bootstrap/README.md)
2. Bootstrapper-specific templates (STATUS.md inception, index.spec.md inception/full)
3. Naming conventions and status indicators
4. A pointer list to the file-type catalogue

Items 1 and 4 are redundant with other files. Item 2 belongs in the bootstrapper's context or in the file-type catalogue entries. Item 3 (naming conventions, status indicators) is genuinely unique and useful.

**Recommendation:** Rename to `conventions.md`. Keep only the naming conventions and status indicators. Move inception templates to the relevant file-type catalogue entries (status.md and knowledge-index.md already have them — remove the duplicates from templates.md). Remove the structure diagram (it's in README.md).

### 2.3 process/principles.md vs. roles/principles.md — confusing overlap

There are two files named `principles.md`:

- `process/principles.md` — the *methodology's* principles (human accountability, append-forward, formalise the implicit, memory model overview). Written for human readers learning the methodology.
- `roles/principles.md` — the *AI's operating rules* (identify yourself, human is authority, explain before acting, append-forward, stay in lane). Written as direct instructions to the AI.

The problem: both cover append-forward, both cover human accountability, and roles/principles.md says "for deeper reasoning, see process/principles.md" — implying it's a summary. But it also introduces new rules (identify yourself, explain before acting, stay in lane) that don't appear in process/principles.md.

**Recommendation:** Rename `roles/principles.md` to `roles/operating-rules.md` (or `roles/ai-operating-principles.md`). Make it purely AI-instructional. Remove the duplicated explanations of append-forward and human accountability — replace with: "You follow the append-forward principle ([process/principles.md](../process/principles.md#append-forward)) and uphold human accountability ([process/principles.md](../process/principles.md#human-accountability))." This makes the separation clean: process/ = methodology rationale for humans, roles/ = operational instructions for AIs.

### 2.4 process/roles.md duplicates what the individual role files say

`process/roles.md` gives a prose description of each role — Architect, Tech Lead, Developer, Navigator, Curator, Bootstrapper. But `roles/architect.md`, `roles/tech-lead.md`, etc. each define the same information in more detail. The process/roles.md file is a summary layer, but it also introduces new information (model tiers, "when separate sessions earn their cost") not found in the individual role files.

**Recommendation:** process/roles.md should be the *human-readable overview* of the role system. It should contain: the role philosophy (cognitive framing, not people), the core flow diagram, the situational stances, model tiers, and session separation guidance. It should NOT restate each role's responsibilities — that's what the role files do. Currently it does both, creating maintenance burden.

---

## 3. Dual-Audience (Human + AI) Structure Issues

### 3.1 No clear "AI loading protocol" in the process docs

The role entry points (roles/*.md) have explicit "Files to Load" sections — excellent for AI consumption. But the process documents have no equivalent. An AI loading `process/memory.md` doesn't know if it also needs `process/journaling.md`, or if memory.md is self-contained. The cross-references help but they're scattered in prose.

**Recommendation:** Add a "Related documents" block at the top of each process/ file (after the title/quote block) with explicit dependency markers:

```markdown
> **Depends on:** [principles.md](./principles.md)
> **Extended by:** [journaling.md](./journaling.md), [file-types/key-insights.md](./file-types/key-insights.md)
> **See also:** [action-tree.md](./action-tree.md), [knowledge-tree.md](./knowledge-tree.md)
```

This is machine-parseable and human-readable. An AI can use it to decide what else to load. A human can use it to navigate.

### 3.2 No frontmatter or metadata

None of the files have YAML frontmatter. The file-type catalogue entries have structured metadata (type name, file, location, required, created by, etc.) — this is great. But the process documents and role files have none.

For AI consumption, adding a small frontmatter block would dramatically improve discoverability and selective loading:

```yaml
---
type: process
audience: [human, ai]
depends_on: [principles.md]
last_updated: 2026-03-10
---
```

**Recommendation:** Add frontmatter to all files. Even minimal metadata (type, audience, depends_on) would help an AI decide which files to load without reading all of them.

### 3.3 The reading order in README.md doesn't match AI loading patterns

The README prescribes a linear reading order (1. principles → 2. memory → ... → 10. anti-patterns). This serves humans learning the methodology. But an AI loading context for a specific role doesn't need this linear path — it needs a targeted loading path.

**Recommendation:** Keep the human reading order. Add a second section: "AI Context Loading" that shows which files to load for each stance/mode combination. This could be a table:

```markdown
| Scenario | Load these files |
|---|---|
| Architect starting a new action | roles/architect.md, process/principles.md, process/memory.md |
| Tech Lead writing prompts | roles/tech-lead.md, process/prompts.md |
| Curator audit session | roles/curator.md, process/memory.md, process/journaling.md |
```

### 3.4 Inconsistent "Never load" / "Always load" granularity across roles

The role files have "Files to Load" sections, but they vary in specificity. The Architect lists specific files; the Navigator has two "Load when relevant" sections (appears to be a copy-paste error — there are two identical headers). The Curator lists broad categories. The Developer is the clearest (load one file, never load anything else).

**Recommendation:** Standardise the "Files to Load" format across all role files. Use a consistent three-tier structure: Always load, Load on demand (with trigger conditions), Never load.

---

## 4. Minor but Persistent Issues

### 4.1 Inconsistent terminology: "task" vs. "action"

The old terminology ("task", "epic", "goal") is mostly gone, but "task" still appears in several places:

- `process/anti-patterns.md` — "it deserves at least a task with a short spec"
- `process/roles.md` — "a task with a single prompt" (tech-lead section)
- `roles/tech-lead.md` — "For tasks: a prompt plan rarely adds value"
- `process/workflow.md` — "the task stays as-is" (in Planning-Implementation loop context — this one actually refers to the old model)

**Recommendation:** Replace all remaining "task" references with "action" (or "simple action" where appropriate) for consistency.

### 4.2 bootstrap/README.md references `index.md` instead of `index.spec.md`

In the "Three-Folder Convention" diagram and in the "Fully bootstrapped" state diagram, the knowledge tree shows `index.md` rather than `index.spec.md`. The rest of the documentation consistently uses `index.spec.md`.

**Recommendation:** Fix the two diagram references to `index.spec.md`.

### 4.3 Bootstrapper STATUS.md template diverges from file-type catalogue

The bootstrapper's STATUS.md template (in `roles/bootstrapper.md`) uses different fields than the one in `process/file-types/status.md` and `process/templates.md`. The bootstrapper version has "Actions" and "Action History" tables; the file-type version has "Active Stack" and "Action Tree". The bootstrapper also uses "Active action" instead of "Active Stack".

**Recommendation:** Align the bootstrapper template with the canonical template in the file-type catalogue. The file-type doc should own the format; the bootstrapper should reference it.

### 4.4 Navigator has duplicate "Load when relevant" sections

In `roles/navigator.md`, there are two consecutive "Load when relevant:" sections. The first covers older journal weeks and git logs; the second covers process/ sections and the file-types catalogue. These should be merged.

### 4.5 flows/README.md is a placeholder

The flows directory has only a README saying "TBC — flows need to be rewritten." This is fine for a draft, but the README.md's "Getting Started" section still references it as item 3. Consider either writing a stub flow or removing the reference until content exists.

### 4.6 phase.md file-type says "Created by: Tech Lead" but process says Architect

The `process/file-types/phase.md` metadata says "Created by: Tech Lead" but the process documents (workflow.md, roles/architect.md) consistently describe the Architect as writing phase specs. The file-type doc's own "Engagement mode" note says "Created in Shaping (Architect designs the phase spec)" which contradicts its own metadata header.

**Recommendation:** Fix the metadata to say "Created by: Architect".

---

## 5. Recommendations Summary — Priority Order

### High Impact (do these first)

1. **Commit to the file-type catalogue as the single source of truth for file formats.** Strip format definitions from narrative docs (memory.md, journaling.md, knowledge-tree.md, prompts.md, action-tree.md). These docs should explain *why/when/how*, not *what the file looks like*.

2. **Deduplicate the top 5 repeated concepts** (append-forward, memory model overview, rubber stamp, engagement mode tables, Developer exemption). Apply the "define once, reference everywhere" pattern.

3. **Add a "Related documents" header block to every process/ file** for both human navigation and AI loading.

### Medium Impact

4. **Rename `roles/principles.md`** to disambiguate from `process/principles.md`. Make the separation clean: process = rationale, roles = AI instructions.

5. **Rework `templates.md`** into `conventions.md` — keep only naming conventions and status indicators.

6. **Standardise "Files to Load" sections** across all role files.

7. **Add YAML frontmatter** to all files for machine-parseable metadata.

### Low Impact (cleanup)

8. Replace remaining "task" with "action".
9. Fix `index.md` → `index.spec.md` in bootstrap/README.md diagrams.
10. Align bootstrapper STATUS.md template with file-type catalogue.
11. Fix Navigator duplicate "Load when relevant" sections.
12. Fix phase.md "Created by" metadata.
13. Remove or update flows/ reference in README.md.

---

## 6. A Note on the Dual-Audience Goal

The aspiration to make these docs readable by both humans and AIs is achievable, but requires a structural commitment that the current draft doesn't fully make. Right now, the docs are optimised for **human sequential reading** (each file tries to be self-contained, which means repeating context). For AI consumption, you want the opposite: **atomic, non-redundant, with explicit dependency graphs**.

The good news is these goals aren't in conflict — you just need two layers:

1. **The atomic layer** (process/ docs, file-type catalogue, role files) — each file owns its topic, never restates another file's content, has machine-parseable metadata and dependency links.

2. **The narrative layer** (README.md, possibly a new "guide.md" or the flows/) — stitches the atomic pieces into a readable story for humans learning the methodology for the first time.

The current README.md already does a decent job of being the narrative layer. The problem is that the process/ docs *also* try to be narrative, which is where the duplication comes from. If you let the process/ docs be atomic (define once, link out, don't repeat) and let the README + flows be narrative (repeat for readability, link to the atomic source), the dual-audience problem solves itself.
