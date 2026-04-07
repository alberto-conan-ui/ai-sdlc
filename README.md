# AI-Lore

A methodology where AI sessions compound. Pick a plugin for your domain, and every session builds on everything the last one learned.

AI-Lore gives your project persistent memory — a knowledge tree that grows across sessions, an action tree that tracks intention, and a journal that captures decisions as they happen. Session 10 starts with everything sessions 1 through 9 learned. The compound curve is the point.

---

## How It Works

You work in a domain — software development, tabletop campaigns, process design, something else. AI-Lore meets you there through **plugins**: domain-specific configurations that give the AI the right stances, conventions, and workflow for your kind of work.

**The plugin is your interface.** It defines which cognitive stances the AI can adopt (an SDLC plugin gives you Architect and Tech Lead; a TTRPG plugin gives you Game Master), how work flows through your domain, and what conventions apply. You tell the AI "load Architect" and it thinks like a systems designer. You say "switch to Tech Lead" and it shifts to precise implementation.

**The core is the engine underneath.** A domain-agnostic memory model — journal, action tree, knowledge tree — that compounds knowledge across sessions regardless of domain. The core handles session persistence, focus tracking, mode transitions, and the operating principles that keep the human in charge. You don't interact with core directly — the plugin layers your domain on top of it.

**The compound curve is what you get.** Session 1 is expensive — the AI learns your project from scratch. By session 10, curated knowledge means the AI starts producing useful output in minutes, in a fraction of the tokens. The methodology gets cheaper to run as the project matures.

---

## Plugins

Every project declares a plugin. The plugin is chosen during bootstrap and declared in `workspace.yaml`. Available plugins:

| Plugin        | Domain                     | Stances                  |
| ------------- | -------------------------- | ------------------------ |
| **SDLC**      | Software development       | Architect, Tech Lead     |
| **TTRPG**     | Tabletop RPG campaigns     | Game Master              |
| **spec**      | Methodology/process design | Editor, Strategist       |

The **Auditor** is a core stance available to all plugins — it handles process health evaluation and version migration.

Plugins fill **slots** in the core — places where the core is deliberately abstract. Each plugin file declares a **join** explaining how it connects: whether it adds to the core (addendum) or replaces part of it (substitution). The AI reads the join declaration and knows exactly what to load and how.

If the AI finds no plugin declared, it stops and flags the project as needing bootstrap or migration. The **Auditor** stance handles version migration — transitioning a project from an older version to the current plugin architecture.

For the full plugin model, see [plugins.md](./process/plugins.md).

---

## Getting Started

### 1. Bootstrap your project

Set up your workspace — see [bootstrap/README.md](./bootstrap/README.md). The bootstrap process:

1. Choose your plugin — the domain this project operates in
2. Generate `workspace.yaml` with the plugin declaration and path references
3. Generate `ai_readme.md` — the session entry point
4. Create the memory folder structure

### 2. Start a session

Say *"Read ai_readme.md and follow its instructions"* at the start of any session. The AI reads the entry point, finds your plugin in `workspace.yaml`, loads core process files, loads the plugin's domain layer, and adopts the stance you request.

No setup ceremony, no re-explaining what the project is, no manually loading files. The `ai_readme.md` encodes the complete loading sequence.

### 3. Learn the methodology

The reading order below covers the core — what every plugin builds on:

| # | File | What it covers |
|---|---|---|
| 1 | [plugins.md](./process/plugins.md) | **Start here** — what plugins are, slots and joins, the boundary, bootstrapping |
| 2 | [principles.md](./process/principles.md) | Human accountability, append-forward, simplicity, core as infrastructure |
| 3 | [memory.md](./process/memory.md) | The memory model — three layers, how memory flows |
| 4 | [workflow.md](./process/workflow.md) | Focus, modes, the focus stack, headless, checkpoints |
| 5 | [focus.md](./process/focus.md) | What a focus is — file structure, gates, lifecycle |
| 6 | [conventions.md](./process/conventions.md) | Typed file system, index navigation, reference headers, naming |
| 7 | [action-tree.md](./process/action-tree.md) | Optional infrastructure for complex work decomposition |
| 8 | [knowledge-tree.md](./process/knowledge-tree.md) | Three branches (curated, notepad, payload), growth patterns |
| 9 | [journaling.md](./process/journaling.md) | The recording system — journal files, the handover, session close protocol |
| 10 | [roles.md](./process/roles.md) | Stances, the Human Lead, archetypes that plugins compose |

Then read your plugin's docs — the plugin's `ai_readme.md` points to everything domain-specific.

---

## Why This Works

AI-Lore rests on three insights about how LLMs change the economics of complex work.

### Planning is now cheap

LLMs can read an entire project, hold it in context, trace relationships, and produce a detailed plan — in minutes, not weeks. AI-Lore locks in the *discipline* of planning, not the plan itself. You plan before every stage. You execute. Execution reveals new information. You replan. The cycle is tight — hours, not months. The plans are disposable. The discipline of producing them is not.

### Knowledge compounds — and sessions get cheaper

The biggest problem with AI-assisted work isn't the AI's ability to produce — it's the inability to remember anything. Every new session starts from zero.

AI-Lore fixes this with a **memory model** built on three layers: an action tree (intention), a knowledge tree (long-term), and a journal (temporal intake). Each session loads the relevant knowledge — not everything, just what applies to the current work — and starts producing useful output in minutes instead of re-learning the project.

The structural conventions are designed for efficient loading: indexes tell the AI what to read and in what order, reference headers declare dependencies so the AI doesn't guess, and curated knowledge replaces raw re-reading. Session 1 loads source material and produces knowledge. Session 10 loads curated knowledge and produces immediately — in a fraction of the tokens.

The compound curve is real but not instant. For a two-session task, the overhead barely pays for itself. For a multi-phase effort spanning weeks, the difference is dramatic. And it only works if the human reviews what the AI writes. The AI populates the memory. Your review makes it trustworthy. **The full memory model is defined in [process/memory.md](./process/memory.md).**

### Cognitive framing produces different output

The same LLM behaves differently when told "you are a strategist — challenge assumptions" versus "you are an executor — implement this plan." This isn't role-play — it's cognitive framing. The entry point shapes which patterns the model activates, how it interprets ambiguity, and what it considers "done."

AI-Lore supports this through **stances** — cognitive postures the AI adopts for different kinds of work. Which stances exist depends on your domain. Stances are defined by plugins. The core provides the infrastructure; the plugin provides the vocabulary.

---

## Who This Is For

This methodology is for experienced practitioners — people who know their domain well enough to evaluate AI output critically and make sound decisions without guidance. The process doesn't teach you your craft — it gives you a structure for practicing your craft *with AI* that doesn't degrade over time.

**Use it for the right work.** Not everything needs this process. A quick task, a one-off question — just do it. AI-Lore earns its keep when the work has dependencies, spans sessions, or requires decisions that constrain future work. The test: would you benefit from the AI remembering what happened last session? If yes, use the process. If not, skip it.

> **Fair warning.** This methodology is deliberately demanding. It will ask more of you than unstructured AI work, not less. The payoff is back-loaded: early sessions feel expensive, but by session ten the compound knowledge tree means the AI starts producing useful output in minutes. The first few sessions pay for the next fifty. But only if you do the work — actually reading, actually reviewing, actually engaging. Rubber-stamping the artefacts gives you all the overhead with none of the returns.

---

## Contributing

This is a personal methodology, shared because it might be useful to others. Issues and discussions are welcome. If you want to propose changes, open an issue first.

---

## Version

**v0.3** — April 2026. Plugin architecture: domain-agnostic core with slots, domain plugins with joins. Every project declares a plugin. Auditor handles migration from v0.2. Built on v0.27 (core process documentation), v0.25 (process refinements, reconciliation), and v0.22 (interaction modes, index navigation, journal handovers).

## License

MIT — see [LICENSE](./LICENSE).
