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

AI-SDLC fixes this with a **memory model** built on two complementary trees and a journal. The **working tree** captures what's happening now (short-term memory). The **knowledge tree** captures what you've learned (long-term memory). The **journal** bridges them and serves as the audit trail. Work produces insights → insights migrate to the knowledge tree → the Curator audits the pipeline using the journal. Each new session loads the relevant knowledge — not everything, just what applies to the current work — and starts producing useful output in minutes instead of re-learning the project.

The compound curve is real but not instant. For a two-session task, the overhead barely pays for itself. For a five-phase epic spanning three weeks, the difference is dramatic. And it only works if the human reviews what the AI writes — refining vague insights, correcting inaccurate summaries, removing noise. The AI populates the memory. Your review makes it trustworthy. **The full memory model is defined in [process/memory.md](./process/memory.md).**

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

## The Core Ideas

The process documents elaborate on each, but this is the conceptual map.

### Memory — The Central Mechanism

This is the central mechanism. Everything else serves it. The project memory (`<project-name>-memory/`) holds two complementary trees and a journal. **The full model is defined in [process/memory.md](./process/memory.md)** — every role should read it.

**The Working Tree** (`working-tree/`) is the short-term memory. It holds the work in progress — each action carries its own session log, working insights, and links to relevant knowledge. This is where the AI finds out what's happening *right now*. When an action completes, its insights migrate to the knowledge tree and the action subtree archives. See [working-tree.md](./process/working-tree.md) for the tree structure.

**The Knowledge Tree** (`knowledge-tree/`) is the long-term memory. It mirrors your codebase — a folder hierarchy where each node holds what the team has learned about that area of the code. Knowledge is distilled from action work, placed at the right structural location, and maintained as a living resource.

**The Journal** (`journal/`) is both the bridge between the two trees and the audit trail. It captures cross-cutting decisions, observations, and process changes. The Curator uses the journal to audit the memory pipeline — verifying that insights were captured, placed correctly, and nothing was lost.

The flow: work produces logs and insights → insights migrate to the knowledge tree on action completion → the Curator audits using the journal to verify the pipeline worked. Every role participates in memory maintenance as part of its normal work.

`CONTEXT.md` sits alongside the trees — a lightweight map that describes the repo structure and points into the knowledge tree. It tells the AI where to look, not what to know.

### The Working Tree — Short-Term Memory

Everything you build is an **action**. Actions live in a tree — nested however you want, named whatever you want, structured to match how you think about the work. A single node is a simple fix. A node with children decomposes complex work into sub-actions. Every node has a `gatekeep.md` that defines "done" — the status of any subtree is always computable from the leaves up.

The working tree is the project's short-term memory. Each action carries its own `log.md` (session history), `KEY_INSIGHTS.md` (working scratchpad), and `context.md` (links to relevant knowledge). When an action completes, its insights migrate to the knowledge tree and the action archives. See [working-tree.md](./process/working-tree.md) for the tree structure, [memory.md](./process/memory.md) for the memory model.

### Roles — Cognitive Framing for the AI

You direct the AI by shifting between cognitive stances. These aren't separate agents — they're framing techniques that shape how the AI approaches the work. The Human Lead picks the right stance as the work demands it.

**The core flow** — these three stances drive every action from design through to code:

- **Architect** — designs the approach, writes phase specs, challenges assumptions. Reads the codebase deeply before planning.
- **Tech Lead** — translates specs into precise implementation prompts. Bridges design and execution.
- **Developer** — executes prompts literally, produces session receipts. Follows the prompt, flags the unexpected.

In practice, you'll often flow through all three in a single session — designing, writing prompts, executing — shifting stances as the conversation moves. Separate sessions are the escalation path for complex work where you notice stance bleed.

**Situational stances** — reach for these when a specific need arises:

- **Navigator** — orientation when context has gone cold. "Where are we? What should I do next?" Use it at the start of a day, after a break, or when resuming paused work.
- **Curator** — audits the memory pipeline periodically. Reads the journal, action logs, and KEY_INSIGHTS files to verify the knowledge tree is accurate and complete. Run in dedicated sessions, not as part of regular work.

**One-time** — the **Bootstrapper** sets up a new project workspace and is never used again. See [bootstrap/README.md](./bootstrap/README.md).

See [roles.md](./process/roles.md) for the full model.

### Prompt Craft — The Execution Interface

The quality of AI-generated code depends almost entirely on the quality of the prompts that produce it. The methodology defines a just-in-time prompting model: plan the sequence, detail each prompt only when its turn comes, use session receipts to keep subsequent prompts grounded in reality. See [prompts.md](./process/prompts.md).

### Human Accountability — The Governance Model

The AI generates volume. You supply the judgement that makes the volume valuable. Every plan passes through your review. Every insight gets your scrutiny. Every gatekeep requires your judgement. This is a partnership driven by you — if you disengage, the process breaks. See [principles.md](./process/principles.md).

---

## Getting Started

1. Set up your workspace — see [bootstrap/README.md](./bootstrap/README.md) for the three-folder convention and step-by-step guides
2. Read the methodology — the reading order below
3. Flows (practical walkthroughs) — TBC, being rewritten to align with the reorganised methodology

## Reading Order

Each file is self-contained, but they build on each other.

| # | File | What it covers |
|---|---|---|
| 1 | [principles.md](./process/principles.md) | Human accountability, append-forward, and the memory model overview |
| 2 | [memory.md](./process/memory.md) | **The memory model** — working tree, knowledge tree, journal, KEY_INSIGHTS lifecycle, every role's memory responsibilities |
| 3 | [working-tree.md](./process/working-tree.md) | The working tree — hierarchical actions, gatekeeping at every level, the active stack |
| 4 | [knowledge-tree.md](./process/knowledge-tree.md) | The knowledge tree — structure, growth patterns, monorepo layouts, what belongs at each level |
| 5 | [roles.md](./process/roles.md) | The Human Lead and AI stances, model tiers, when to separate sessions |
| 6 | [workflow.md](./process/workflow.md) | Inception, planning, implementation, session discipline |
| 7 | [prompts.md](./process/prompts.md) | How to write effective implementation prompts for Developer sessions |
| 8 | [templates.md](./process/templates.md) | File templates, naming conventions, journal and knowledge tree structure |
| 9 | [anti-patterns.md](./process/anti-patterns.md) | Common failure modes and how to avoid them |

## AI Role Entry Points

The `roles/` folder contains one file per AI stance, loaded at session start or when switching stances. Each role loads [principles.md](./roles/principles.md) first, then [common.md](./roles/common.md) for shared duties, then its own entry point.

**Core flow:** [architect.md](./roles/architect.md) → [tech-lead.md](./roles/tech-lead.md) → [developer.md](./roles/developer.md)
**Situational:** [navigator.md](./roles/navigator.md), [curator.md](./roles/curator.md)
**One-time:** [bootstrapper.md](./roles/bootstrapper.md)

---

## License

MIT
