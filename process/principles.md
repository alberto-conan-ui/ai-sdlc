# Core Principles

> These principles govern how the methodology operates. They are non-negotiable
> regardless of role, tier, or tooling.

---

## Human Accountability

This methodology demands more from you, not less.

The AI handles production — planning, writing code, generating tests, producing artefacts, and all the bookkeeping that holds the process together: journal entries, STATUS.md updates, key insights, session receipts. The AI writes; you don't. But you own every decision, and ownership lives in review.

Every plan passes through your review before it becomes code. Every insight the AI writes gets your scrutiny before it joins the knowledge tree. Every gatekeep requires your judgement — not the AI's assertion that it's done. The AI is the workforce. You are the authority. And authority means active review, not passive approval.

You are typically both the lead and the sole stakeholder — which means there is no one else to defer to. The gatekeep "my own approval" means you are accountable for the quality of what ships. This is not a limitation of the process. It is the point. AI-SDLC exists to empower you through AI, not to replace your judgement with AI output.

**This is where the process makes its real demand.** When the AI produces a phase spec, you need to evaluate whether the approach is sound — not skim it and approve. When the AI writes a journal entry, you need to verify it captured what actually happened — not assume it did. When the AI writes a key insight, you need to judge whether it's specific enough to be useful and placed at the right level — not let it accumulate unchecked. The AI generates volume. You supply the judgement that makes the volume valuable.

This is a partnership driven by you. If you disengage — rubber-stamp plans without reading them, skip review gates, accept AI output without scrutiny — the process breaks. The methodology is only as strong as the person driving it.

---

## Append-Forward

The project memory moves forward, never backward. When a plan changes, the new plan is a new artefact. The old plan stays as the record of what was believed at the time. When a task outgrows its scope, the task stays as-is and a new epic or goal is created to continue the work. Promotion, revision, and abandonment are all forward moves — new entries, new files, new journal notes.

This principle exists because rewriting history breaks the context chain. If a spec gets silently edited, the journal entries that reference it no longer make sense. If a task folder gets renamed or restructured, references go stale. By always moving forward — creating new artefacts rather than mutating old ones — every past reference remains valid, and the journal tells a truthful story.

The only file that genuinely mutates is STATUS.md, and even that is just pointer updates: which action is active, which phase, which prompt. Everything else is append-only.

---

## Two Trees and a Journal

The methodology maintains persistent memory through two complementary trees and a journal that bridges them. Understanding the distinction is essential — they serve different purposes and follow different rules.

### The Action Tree — Short-Term Memory

The action tree (`actions/`) holds the work in progress. Each action node carries its own session log (`log.md`), working insights (`KEY_INSIGHTS.md`), and links to relevant knowledge (`context.md`). Every node has a `gatekeep.md` that defines "done." The tree is hierarchical — actions nest freely, and the status of any subtree is computable from the leaves up.

The action tree is where the AI finds out what's happening *right now*. When an action completes, its insights migrate to the knowledge tree and the action subtree archives. The action tree is temporary by design — it serves the current work and then gets out of the way.

### The Knowledge Tree — Long-Term Memory

The knowledge tree (`knowledge/`) is a folder hierarchy that mirrors your codebase. Each node holds curated insights about that area of the code — patterns to follow, pitfalls to avoid, architectural decisions that constrain future work.

```
knowledge/
├── index.md                ← project-wide patterns, cross-cutting decisions
├── auth/
│   ├── index.md            ← how auth works, key patterns
│   └── session-handling.md ← deep knowledge about a specific area
├── api/
│   ├── index.md            ← API design patterns, conventions
│   └── validation.md       ← validation pipeline specifics
└── tooling/
    └── index.md            ← build system, CI, testing infrastructure
```

Unlike the action tree, the knowledge tree is a permanent, living resource. Insights get added, refined, moved to a different node, or retired when they're no longer relevant. The tree grows organically as work takes you into different areas of the codebase. The Human Lead and the Architect build it together through conversation: the Architect proposes where an insight belongs, the Human Lead confirms or redirects.

An `index.md` at each level maps the sub-areas — what's there, when you'd need to go deeper. When starting a session, the Architect reads the relevant index files to decide which knowledge nodes to load for the current work.

### The Journal — The Bridge

The journal (`journal/`) captures cross-cutting annotations — project-level decisions, observations spanning multiple actions, process changes. It is the bridge between the action tree and the knowledge tree: the raw material the Curator uses to distill long-term knowledge.

Journal entries are tagged by type: `[decision]` for a non-trivial project-level choice with context and reasoning, `[observation]` for cross-cutting patterns, `[process]` for changes to how the team works. The journal follows the append-forward principle: entries are never edited or deleted.

Detailed session history lives in each action's `log.md`, not in the journal. The journal captures what transcends individual actions.

### The Flow Between Them

The action tree feeds the knowledge tree through the journal, but there's no formal ceremony for this. The flow is organic:

- Work produces action logs and KEY_INSIGHTS.md scratchpads (every role contributes as part of its normal output).
- During conversation, insights surface that matter beyond the current action.
- Those insights land in the knowledge tree at the right structural node.
- When an action completes, the Curator and Human Lead review KEY_INSIGHTS.md — anything worth keeping migrates to the knowledge tree.
- The journal captures cross-cutting decisions that the Curator uses to maintain the knowledge tree over time.

The key distinction: the action tree captures *what's happening now* (short-term memory). The knowledge tree captures *what's worth loading into future sessions* (long-term memory). The journal bridges the two — it's the Curator's raw material for distilling transient work into permanent knowledge.

### CONTEXT.md — The Map

`CONTEXT.md` sits alongside the two trees. It's a lightweight file that describes the repo structure and points into the knowledge tree. It tells the AI "here's the shape of the codebase, and here's where to find deeper knowledge about each area." CONTEXT.md is not the knowledge — it's the map to the knowledge.
