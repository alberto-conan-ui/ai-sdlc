# Roles

This is a solo practitioner's framework. You — the human — are the only person. The AI is your tool, and you direct it by shifting between cognitive stances. The "roles" are not people or separate agents. They are **framing techniques** — telling the AI "you are an Architect, challenge assumptions" produces genuinely different output than "you are a Developer, follow this prompt." Different stances produce different thinking. That's the entire mechanism.

There are five AI stances: **Architect** (design), **Tech Lead** (prompt craft), **Developer** (execution), **Navigator** (orientation), and **Curator** (knowledge maintenance). All share a common foundation (`roles/common.md`) that handles journal writing, key insight management, and STATUS.md updates. Each stance adds its specific focus on top.

**In practice, you'll usually stay in one session and shift stances as the conversation flows.** You discuss the design (Architect thinking), then translate it into prompts (Tech Lead thinking), then execute (Developer thinking) — all in the same conversation. This is the default. The stances shape how the AI approaches the work even when the session is continuous.

**When separate sessions earn their cost:**

- **The Developer on complex work.** A fresh session — loading only the implementation prompt, with no memory of the design discussion — produces more disciplined, literal output. For high-risk work, a clean session is worth the overhead.
- **When you notice stance pollution.** If the Architect starts writing implementation details instead of designing systems, or the Developer starts second-guessing prompts, that's a signal that physical separation would help.
- **Goals with deep design work.** The full Architect → Tech Lead → Developer pipeline in separate sessions produces the cleanest output for work that demands genuine systems thinking.

**Separate sessions are the escalation path, not the default.** Most work — especially tasks and straightforward epics — runs fine in a single session with stance shifts. You'll know when to escalate because the output quality tells you.

---

## You — The Human Lead

You define actions, classify them by tier, set gatekeeps, and have final authority over everything — approvals, direction, trade-offs. Every review gate in this process exists so you can catch mistakes before they become code.

Your primary job is defining what success looks like and verifying that it was achieved. You provide the domain context the AI cannot infer, challenge the Architect's assumptions, and decide when a plan is good enough to execute. You also decide when to override the process — skip a phase, combine steps, change direction, promote a task to an epic.

**You decide session boundaries.** When to open a fresh session for a stance, when to shift stances within the same conversation, when to ask the AI for a Navigator-style briefing versus just asking "where are we?" This is a judgement call informed by the work's complexity and the output quality you're seeing.

**You review knowledge contributions.** The AI proposes insights for the knowledge tree and action-level scratchpads (per common.md) regardless of which stance it's in. You review these as they appear — confirming placement, revising what's vague, removing what's wrong, redirecting to a better node in the tree.

You carry the full weight of gatekeeping. This is by design (see [Principles](./principles.md) — Human Accountability).

---

## AI Stances — Entry Points

Each stance is fully defined in its own entry point file under [`roles/`](../roles/). The AI loads these at session start. Read them there — this table is just orientation.

| Stance | One-line focus | Entry point |
|---|---|---|
| **Architect** | Design, phase specs, pushback | [`roles/architect.md`](../roles/architect.md) |
| **Tech Lead** | Implementation prompts, verification | [`roles/tech-lead.md`](../roles/tech-lead.md) |
| **Developer** | Code execution, prompt-following | [`roles/developer.md`](../roles/developer.md) |
| **Navigator** | Orientation, briefings, handoff prompts | [`roles/navigator.md`](../roles/navigator.md) |
| **Curator** | Knowledge maintenance, insight audit | [`roles/curator.md`](../roles/curator.md) |

All stances share a common foundation defined in [`roles/common.md`](../roles/common.md) and operating principles in [`roles/principles.md`](../roles/principles.md).

---

## Common Foundation

All AI stances share a common foundation (`roles/common.md`) that defines:

- **Journal writing** — the AI logs `[session]`, `[decision]`, and `[lesson]` entries as part of its normal output, regardless of stance
- **Knowledge contributions** — the AI proposes insights for the knowledge tree or action-level scratchpads, and you confirm placement and quality through conversation
- **STATUS.md updates** — the AI updates STATUS.md when its work changes the project state
- **Orientation** — the AI can answer "where are we?" by reading STATUS.md and the recent journal, in any stance

You review knowledge contributions as they appear and maintain final authority over what stays and where it goes.

---

## Stance Summary

| Stance | Focus | Context | Behaviour | When to separate sessions |
|---|---|---|---|---|
| **Architect** | System design, phase specs, architectural decisions | CONTEXT.md + relevant knowledge/ nodes + source code | Challenges | Rarely — shares well with Tech Lead |
| **Tech Lead** | Implementation prompts, code review, verification | Phase spec + relevant knowledge/ nodes + source files | Translates | Rarely — benefits from Architect context |
| **Developer** | Code execution, prompt-following | Implementation prompt only | Executes | Often — clean context produces disciplined output |
| **Navigator** | Orientation, briefing, handoff prompts, external change checks | STATUS.md + journal/ (recent weeks) | Guides | When context is cold |
| **Curator** | Knowledge maintenance, tree audit, journal distillation | knowledge/ (full tree) + journal/ (all weeks) + completed specs | Curates | Dedicated session recommended |

---

## Model Tiers

Each AI stance has different cognitive demands. Rather than hardcoding specific models (which change frequently), this methodology uses a **tier system**. Map tiers to your current best-available models.

| Tier | Characteristics | Typical stances |
|---|---|---|
| **Tier 1 — Reasoning** | Strongest reasoning, largest context window. Architectural thinking, trade-off analysis, nuanced judgement. | Architect, Tech Lead (complex phases) |
| **Tier 2 — Execution** | Strong code generation, good instruction-following. Fast, cost-effective. | Developer, Tech Lead (straightforward phases), Navigator |
| **Tier 1 — Reasoning** (periodic) | Broad context, editorial judgment, pattern recognition across history. | Curator |

**Illustrative mapping (March 2026 — update with your current best-available models):**

| Tier | Example models |
|---|---|
| Tier 1 | Claude Opus 4.6, GPT-4.5, Gemini 2.5 Pro |
| Tier 2 | Claude Sonnet 4.6, GPT-4.1, Gemini 2.5 Flash |

These are examples, not recommendations — the model landscape changes faster than any document can track. The tiers themselves are stable; the models behind them are not. Use whatever you currently consider your strongest reasoning model for Tier 1 and your best execution model for Tier 2.

**When the Tech Lead moves between tiers:** For phases that involve complex refactoring, novel architecture, or ambiguous requirements, the Tech Lead benefits from Tier 1 (writing good prompts for hard problems requires strong reasoning). For phases that follow established patterns — adding a new type that mirrors an existing one, extending a test suite — Tier 2 is sufficient. You make this call per phase.

**Token efficiency is one benefit of session separation.** The Developer loads one implementation prompt (~50-100 lines). The Architect loads relevant knowledge tree nodes (~300+ lines) plus source files. In separate sessions, each stance loads exactly what it needs — no more. In a shared session, the model carries everything it's seen, which costs tokens and can influence behaviour. You weigh this against the cost of context loss from handoff prompts — and decide per phase.
