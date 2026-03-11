# AI-SDLC

A methodology for AI-assisted software development. Tool-agnostic, derived from real project experience.

**This is not vibe coding.** Vibe coding is "give the AI a vague idea, let it generate, hope for the best." It works for throwaway prototypes. It does not work for anything you need to maintain, extend, or trust. AI-SDLC is the deliberate opposite: structured intent, human accountability at every gate, and AI constrained by process — not unleashed without it.

---

## Why This Works

AI-SDLC rests on three insights about how LLMs change the economics of software development.

### Planning is now cheap

Traditional software development resisted upfront planning for a good reason: humans can't hold enough context to plan accurately. Waterfall failed because it demanded detailed plans from people who couldn't realistically produce them — so the industry moved to iterative discovery.

LLMs change this equation. An AI can read an entire codebase, hold it in context, trace execution paths, and produce a detailed plan — in minutes, not weeks. But "plan more" is not "do waterfall." AI-SDLC locks in the *discipline* of planning, not the plan itself. You plan before every phase. You execute. Implementation reveals new information. You replan. The cycle is tight — hours, not months. A plan that gets revised three times in two days isn't a failure; it's the process working as designed. The plans are disposable. The discipline of producing them is not.

### Knowledge compounds across sessions

The biggest problem with AI-assisted development isn't the AI's ability to write code — it's the AI's inability to remember anything. Every new session starts from zero. Without intervention, session 10 is as expensive as session 1.

AI-SDLC fixes this with a **memory model** built on two complementary trees and a journal. Each new session loads the relevant knowledge — not everything, just what applies to the current work — and starts producing useful output in minutes instead of re-learning the project.

The compound curve is real but not instant. For a two-session action, the overhead barely pays for itself. For a five-phase action spanning three weeks, the difference is dramatic. And it only works if the human reviews what the AI writes — refining vague insights, correcting inaccurate summaries, removing noise. The AI populates the memory. Your review makes it trustworthy. **The full memory model is defined in [process/memory.md](./process/memory.md).**

### Cognitive framing produces different output

The same LLM behaves differently when told "you are an Architect — challenge assumptions" versus "you are a Developer — follow this prompt literally." This isn't role-play — it's cognitive framing. The entry point shapes which patterns the model activates, how it interprets ambiguity, and what it considers "done."

AI-SDLC exploits this with five stances — Architect, Tech Lead, Developer, Navigator, and Curator. Each has an entry point that defines what the AI sees, how it thinks, and what it must not do. The boundaries prevent role bleed: the Architect doesn't over-specify implementation details, the Developer doesn't redesign the spec. In practice, you'll often stay in one session and shift stances as the conversation flows. Separate sessions are the escalation path for complex work.

---

## Who This Is For

This methodology is for senior developers. It assumes you can already architect software, evaluate trade-offs, recognise when AI output is wrong, and make sound technical decisions without guidance. The process doesn't teach you how to build software — it gives you a structure for building software *with AI* that doesn't degrade over time.

**Use it for the right work.** Not everything needs this process. A one-line fix, a config change, a dependency bump — just do it. AI-SDLC earns its keep when the work has dependencies, touches shared state, or requires decisions that constrain future work. The test: would you benefit from a written plan before coding this? If yes, create an action. If not, skip the process.

> **Fair warning.** This methodology is deliberately demanding. It will ask more of you than unstructured AI-assisted development, not less. The cognitive load is real and sustained. This is not a way to make coding with AI easier. It is a way to make it *reliably productive* over weeks and months — but the price is disciplined, critical attention at every review gate.
>
> The payoff is back-loaded: early sessions feel expensive, but by session ten the compound knowledge tree means the AI starts producing useful output in minutes instead of spending half an hour re-learning your project. The first few sessions pay for the next fifty. But only if you do the work — actually reading, actually reviewing, actually engaging with what the AI produces. Rubber-stamping the artefacts gives you all the overhead with none of the returns.

---

## Engagement Modes — Shaping and Working

At any given moment, the project is in one of two engagement modes. **Shaping** orients the system around the knowledge tree and action tree structure — you're designing, not coding. **Working** orients it around executing the active stack — you're coding against a defined plan.

The mode lives in STATUS.md and gates which stances are primary, what recording looks like, and what activities are appropriate. The detailed rules — what changes per mode, when to switch, and how recording adapts — are defined in [workflow.md](./process/workflow.md#engagement-modes).

---

## The Core Ideas

**Memory** is the central mechanism. Two trees and a journal give the project durable memory across sessions. See [memory.md](./process/memory.md) for the model and [journaling.md](./process/journaling.md) for the recording system that feeds it.

**Actions** are how you organise work. Everything is an action — nested in a tree, named however you want, with a `gatekeep.md` at every node that defines "done." Simple fixes are single nodes; complex work decomposes into children. See [action-tree.md](./process/action-tree.md).

**Roles** are cognitive framing for the AI. Five stances — Architect, Tech Lead, Developer, Navigator, Curator — shape how the AI thinks. You shift between them as the work demands. Separate sessions are the escalation path, not the default. See [roles.md](./process/roles.md).

**Prompt craft** determines code quality. Plan the sequence, detail each prompt just in time, use session receipts to keep subsequent prompts grounded. See [prompts.md](./process/prompts.md).

**Human accountability** is non-negotiable. Every plan, every insight, every gatekeep passes through your review. The AI generates volume; you supply the judgement. See [principles.md](./process/principles.md).

**The AI anchors the process.** You flow freely — the AI formalises. When your direction implies a mode switch, a stance change, or a new action, the AI pauses and confirms before proceeding. This bridges your flexibility with the process's discipline. See [principles.md — Formalise the Implicit](./process/principles.md#formalise-the-implicit).

---

## Getting Started

1. Set up your workspace — see [bootstrap/README.md](./bootstrap/README.md) for the three-folder convention and step-by-step guides
2. Read the methodology — the reading order below
3. Flows (practical walkthroughs) — coming soon

## Reading Order

Each file is self-contained, but they build on each other.

| # | File | What it covers |
|---|---|---|
| 1 | [principles.md](./process/principles.md) | Human accountability, append-forward, and the memory model overview |
| 2 | [memory.md](./process/memory.md) | **The memory model** — action tree, knowledge tree, journal, how they connect |
| 3 | [journaling.md](./process/journaling.md) | **The recording system** — all four recording files, when to write, who writes, the flow, session checklist |
| 4 | [action-tree.md](./process/action-tree.md) | The action tree — hierarchical actions, gatekeeping at every level, the active stack |
| 5 | [knowledge-tree.md](./process/knowledge-tree.md) | The knowledge tree — structure, growth patterns, monorepo layouts, what belongs at each level |
| 6 | [roles.md](./process/roles.md) | The Human Lead and AI stances, model tiers, when to separate sessions |
| 7 | [workflow.md](./process/workflow.md) | Inception, planning, implementation, session discipline |
| 8 | [prompts.md](./process/prompts.md) | How to write effective implementation prompts for Developer sessions |
| 9 | [conventions.md](./process/conventions.md) | Naming conventions, status indicators, and bootstrapper templates |
| 10 | [anti-patterns.md](./process/anti-patterns.md) | Common failure modes and how to avoid them |

## AI Role Entry Points

The `roles/` folder contains one file per AI stance, loaded at session start or when switching stances. Each role loads [operating-rules.md](./roles/operating-rules.md) first, then [common.md](./roles/common.md) for shared duties, then its own entry point.

**Core flow:** [architect.md](./roles/architect.md) → [tech-lead.md](./roles/tech-lead.md) → [developer.md](./roles/developer.md)
**Situational:** [navigator.md](./roles/navigator.md), [curator.md](./roles/curator.md)
**One-time:** [bootstrapper.md](./roles/bootstrapper.md)

---

## License

MIT
