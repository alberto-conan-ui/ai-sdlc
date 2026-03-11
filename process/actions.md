# Actions — The Unit of Work

Everything in AI-SDLC is an **action**. An action is a human-defined piece of work with a clear outcome. You create actions, classify them by tier, and drive them to completion.

There are three tiers: **Task**, **Epic**, and **Goal**. The tier determines how much ceremony the action gets — but the underlying machinery is the same. All actions live in the `actions/` folder, all follow the same phase-based execution model, and all produce journal entries and insights.

---

## The Three Tiers

**Task** — a bounded, concrete piece of work. One phase, one to three prompts, done in a session or two. "Fix the login redirect bug." "Add a loading spinner to the dashboard." "Update the date format in the export CSV."

You already know what's wrong and what done looks like. The gatekeep is concrete and verifiable: the bug is fixed, the spinner appears, the date format is correct. Stance compression is the default — Architect thinking might get pulled in ad hoc if the fix turns out to be trickier than expected, but there's no formal design phase. You'll often flow between Architect and Tech Lead thinking in the same conversation. The process is deliberately loose because tasks are meant to be quick.

A task has a TASK.md (lightweight — problem statement and done-when criteria) and a single phase folder with a spec and implementation prompts.

**Epic** — a multi-phase piece of work with a concrete, measurable outcome. "Refactor the validation pipeline to use a lookup table." "Add OAuth2 support to the API." "Migrate the test suite from Jest to Vitest."

An epic gets full Planning and Implementation. The outcome is tangible — the refactor is done, the feature works, the migration is complete. The gatekeep is concrete: specific conditions that can be verified without subjective judgement. The Architect designs the phases, the Tech Lead writes the prompts, the Developer executes them. Full stance separation is optional — compression is the default for most epics.

An epic has an EPIC.md (problem, vision, concrete gatekeep) and a phases folder with the standard spec/impl structure.

**Goal** — an abstract, outcome-oriented aspiration. "Users should be able to register without understanding the type system." "Onboarding a new developer to the DX layer should take hours, not days."

A goal gets full Planning and Implementation with the heaviest ceremony. The gatekeep involves human judgement — not just whether the code works, but whether the outcome was achieved. The Architect helps refine the goal, writes GOAL.md with design principles, and plans the roadmap. This is the heavyweight tier, appropriate for work that shapes the product's direction.

A goal has a GOAL.md (problem, vision, design principles, abstract gatekeep) and a phases folder with the standard structure.

---

## The Tier Spectrum

| | Task | Epic | Goal |
|---|---|---|---|
| **Planning weight** | Compressed (short spec, optional prompt plan) | Full | Full |
| **Phases** | One | Multiple | Multiple |
| **Gatekeep** | Concrete, verifiable | Concrete, measurable | Abstract, human-judged |
| **Stance compression** | Default | Optional | Full separation |
| **Prompt plan** | Optional (1–2 prompts may not need one) | Yes | Yes |
| **Action document** | TASK.md (lightweight) | EPIC.md (problem + concrete gatekeep) | GOAL.md (problem + vision + principles + abstract gatekeep) |

---

## Choosing a Tier

You pick the tier when creating the action. The right tier is usually obvious:

- "Fix this bug" → **Task**
- "Add this feature" → **Epic** (unless the feature is trivial — then task)
- "Redesign how users interact with X" → **Goal**

When it's ambiguous, start with the lighter tier. A task that outgrows its scope can be promoted (see below). Starting heavy and discovering you over-planned is more wasteful than starting light and promoting when needed.

---

## Promotion

When a task turns out to need a second phase, it's no longer a task — it's an epic. When an epic's gatekeep turns out to require subjective evaluation, it's a goal.

**Promotion follows the append-forward principle.** The original action stays as-is. A new action is created at the higher tier. The journal captures the promotion decision: what was the original action, why it's being promoted, and what the new action needs to accomplish. The AI bridges the context — whether via Navigator stance for a formal briefing or simply carrying it forward in the same session.

A promoted task's TASK.md is never modified. The new epic's EPIC.md references the original task ("Promoted from task-login-bug — see journal 2026-W11"). The relevant context carries over through the journal and the AI's continuity.

The promotion triggers:

- **Task → Epic:** the fix needs a second phase, or the scope touches shared architecture
- **Epic → Goal:** the gatekeep becomes subjective, or the outcome needs abstract vision-setting

---

## One Active Action at a Time

A project may have many actions defined, but only one is active. This prevents context scatter — the AI always knows which action it's serving. The active action and its tier are tracked in STATUS.md.

If you want to switch actions, do so explicitly. Update STATUS.md and log the reason in the journal. When returning to a paused action, the journal captures why it was paused and what state it was in — the AI can surface this when asked.

---

## Gatekeeping

Every action has a gatekeep — but the nature of the gatekeep varies by tier.

**Task gatekeeps** are binary. The bug is fixed or it isn't. The spinner appears or it doesn't. Tests pass. "Done" is obvious. You verify by looking at the result.

**Epic gatekeeps** are concrete and measurable, but may involve multiple conditions. "The switch statements are removed, all existing tests pass, the API is backward-compatible, and the new lookup table handles all 12 registered types." You verify against the checklist.

**Goal gatekeeps** involve human judgement. They name who decides and what they're evaluating, even if the criteria are subjective. "I'm satisfied that the demo narrative is clear and progressive." "Three beta users complete the onboarding task without asking for help." The discipline is in identifying the person accountable, not in quantifying every metric.

**Examples of gatekeeps by tier:**

| Tier | Example gatekeep |
|---|---|
| Task | "The login redirect sends users to `/dashboard` instead of `/home`." |
| Epic | "OAuth2 login works with Google and GitHub, existing session management is unchanged, all auth tests pass." |
| Goal | "The Head of Product confirms the new registration flow meets the design spec." |

**What gatekeeps are not:**

- "It should feel right." (No one is named as the decision-maker.)
- "Tests pass." (That's a done-criterion for a phase, not a gatekeep for an action.)
- "The AI says it's done." (The AI is never the gatekeeper.)

### When Gatekeeps Are Unclear

If you cannot define a gatekeep, the action is probably scoped wrong. A task with no clear "done" condition should probably be refined. An epic where "done" is subjective should probably be a goal. A goal where "done" can't be articulated at all is a signal to stop and think — not to start planning.
