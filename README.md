# AI-SDLC

A methodology where AI sessions compound. Tool-agnostic, derived from real project experience, built for senior developers who want structured AI-assisted development that gets better over time.

AI-SDLC gives your project persistent memory — a knowledge tree that grows across sessions, an action tree that tracks work in progress, and a journal that captures decisions as they happen. Session 10 starts with everything sessions 1 through 9 learned. The compound curve is the point.

---

## Why This Works

AI-SDLC rests on three insights about how LLMs change the economics of software development.

### Planning is now cheap

LLMs can read an entire codebase, hold it in context, trace execution paths, and produce a detailed plan — in minutes, not weeks. AI-SDLC locks in the *discipline* of planning, not the plan itself. You plan before every phase. You execute. Implementation reveals new information. You replan. The cycle is tight — hours, not months. The plans are disposable. The discipline of producing them is not.

### Knowledge compounds across sessions

The biggest problem with AI-assisted development isn't the AI's ability to write code — it's the inability to remember anything. Every new session starts from zero.

AI-SDLC fixes this with a **memory model** built on three layers: an action tree (short-term), a knowledge tree (long-term), and a journal (temporal intake). Each session loads the relevant knowledge — not everything, just what applies to the current work — and starts producing useful output in minutes instead of re-learning the project.

The compound curve is real but not instant. For a two-session action, the overhead barely pays for itself. For a five-phase action spanning three weeks, the difference is dramatic. And it only works if the human reviews what the AI writes. The AI populates the memory. Your review makes it trustworthy. **The full memory model is defined in [process/memory.md](./process/memory.md).**

### Cognitive framing produces different output

The same LLM behaves differently when told "you are an Architect — challenge assumptions" versus "you are a Tech Lead — implement this phase." This isn't role-play — it's cognitive framing. The entry point shapes which patterns the model activates, how it interprets ambiguity, and what it considers "done."

AI-SDLC uses two core stances — Architect and Tech Lead — plus the Auditor for process health. The Architect designs the work. The Tech Lead builds it. In practice, you'll often stay in one session and shift stances as the conversation flows. Separate sessions are the escalation path for complex work.

---

## Who This Is For

This methodology is for senior developers. It assumes you can architect software, evaluate trade-offs, recognise when AI output is wrong, and make sound technical decisions without guidance. The process doesn't teach you how to build software — it gives you a structure for building software *with AI* that doesn't degrade over time.

**Use it for the right work.** Not everything needs this process. A one-line fix, a config change, a dependency bump — just do it. AI-SDLC earns its keep when the work has dependencies, touches shared state, or requires decisions that constrain future work. The test: would you benefit from a written plan before coding this? If yes, create an action. If not, skip the process.

> **Fair warning.** This methodology is deliberately demanding. It will ask more of you than unstructured AI-assisted development, not less. The payoff is back-loaded: early sessions feel expensive, but by session ten the compound knowledge tree means the AI starts producing useful output in minutes. The first few sessions pay for the next fifty. But only if you do the work — actually reading, actually reviewing, actually engaging. Rubber-stamping the artefacts gives you all the overhead with none of the returns.

---

## The Core Ideas

**Memory** is the central mechanism. Three layers — action tree, knowledge tree, and journal — give the project durable memory across sessions. See [memory.md](./process/memory.md).

**Actions** are how you organise work. Goals and topics decompose strategically; phases decompose into executable units; steps break work into structural chunks; tasks handle quick wins. Gatekeeps verify real-world outcomes at the right level. See [action-tree.md](./process/action-tree.md).

**Stances** are cognitive framing for the AI. Architect designs, Tech Lead builds. You shift between them as the work demands. See [roles.md](./process/roles.md).

**Human accountability** is non-negotiable. Every plan, every insight, every gatekeep passes through your review. The AI generates volume; you supply the judgement. See [principles.md](./process/principles.md).

---

## Starting a Session

Once your workspace is bootstrapped, every session starts the same way:

```
AUTO architect: where are we?
```

One line. The AI loads your project context, adopts the stance you asked for, and responds to your task. No setup ceremony, no re-explaining what the project is, no manually loading files.

This works because of two pieces: `ai_readme.md` (a file generated during setup at your repo root that tells the AI how to orient itself) and AUTO (a Cowork skill that reads it automatically). The entry point encodes the correct loading sequence.

The pattern is `AUTO [stance]: [task]`. Some examples: `AUTO architect: where are we?`, `AUTO tech-lead: implement phase 2`, or just `AUTO` to load context and decide later.

Not using Cowork? The same `ai_readme.md` works with any AI tool — just say *"Read ai_readme.md and follow its instructions"* at the start of any session.

**Full walkthrough:** [flows/session-start.md](./flows/session-start.md)

---

## Getting Started

1. Set up your workspace — see [bootstrap/README.md](./bootstrap/README.md)
2. Read the methodology — the reading order below
3. [Flows](./flows/README.md) (practical walkthroughs) — start with [Starting a Session](./flows/session-start.md)

## Reading Order

| # | File | What it covers |
|---|---|---|
| 1 | [principles.md](./process/principles.md) | Human accountability, append-forward, simplicity, strong model requirement |
| 2 | [memory.md](./process/memory.md) | **The memory model** — three layers, the index as navigation primitive, the typed file system |
| 3 | [action-tree.md](./process/action-tree.md) | Goals/topics, phases, steps, and tasks — five node types, gatekeeping, the active stack |
| 4 | [knowledge-tree.md](./process/knowledge-tree.md) | Structure, growth patterns, what belongs at each level |
| 5 | [journaling.md](./process/journaling.md) | **The recording system** — journal folders, the handover, session close protocol |
| 6 | [roles.md](./process/roles.md) | Stances, the Human Lead, model selection |
| 7 | [workflow.md](./process/workflow.md) | Design, implementation, the active stack |
| 8 | [conventions.md](./process/conventions.md) | Naming conventions and status indicators |
| 9 | [anti-patterns.md](./process/anti-patterns.md) | Common failure modes and how to avoid them |

## AI Stance Entry Points

The `roles/` folder contains one file per AI stance, loaded at session start or when switching stances. Each stance loads [operating-rules.md](./roles/operating-rules.md) first, then [common.md](./roles/common.md) for shared duties, then its own entry point.

**Core flow:** [architect.md](./roles/architect.md) → [tech-lead.md](./roles/tech-lead.md)
**Situational:** [auditor.md](./roles/auditor.md)

---

## Contributing

This is a personal methodology, shared because it might be useful to others. Issues and discussions are welcome. If you want to propose changes, open an issue first.

---

## Version

**v0.22** — March 2026. Hierarchical numbering, KT notepad branch, Reflecting mode, Developer stance removed. Built on v0.21 (interaction modes, index as navigation primitive, journal folders with handover, session continuity, step node type). See [changelog](./process/changelog/).

## License

MIT — see [LICENSE](./LICENSE).
