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

## Journal and Knowledge

The methodology maintains two layers of persistent memory. Understanding the distinction is essential — they serve different purposes and follow different rules.

### The Journal — What Happened

The journal is a folder of weekly rolling files (`journal/YYYY-WNN.md`). Every session, every non-trivial decision, every lesson learned goes here in chronological order. It is append-only — entries are never edited or deleted. The journal is the honest record of the work.

Journal entries are tagged by type: `[session]` for what happened in a work session, `[decision]` for a non-trivial choice with context and reasoning, `[lesson]` for something learned the hard way. Tags enable filtering — any role can scan for `[decision]` entries when you ask about a past choice.

The journal follows the append-forward principle: when something changes, a new entry explains why. The old entries stay as the record of what was believed at the time.

### The Knowledge Tree — What We Know

The knowledge tree is a folder hierarchy that mirrors your codebase. Each node holds curated insights about that area of the code — patterns to follow, pitfalls to avoid, architectural decisions that constrain future work.

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

Unlike the journal, the knowledge tree is a living resource. Insights get added, refined, moved to a different node, or retired when they're no longer relevant. The tree doesn't need to be created all at once — it grows organically as the work takes you into different areas of the codebase. The Human Lead and the Architect build it together through conversation: the Architect proposes where an insight belongs, the Human Lead confirms or redirects.

An `index.md` at each level maps the sub-areas — what's there, when you'd need to go deeper. When starting a session, the Architect reads the relevant index files to decide which knowledge nodes to load for the current work.

### The Flow Between Them

The journal feeds the knowledge tree, but there's no formal ceremony for this. The flow is conversational:

- Work produces journal entries (every role writes these as part of its normal output).
- During conversation, insights surface that matter beyond the current session.
- Those insights land in the knowledge tree at the right structural node.
- During actions, KEY_INSIGHTS.md files at the action and phase level serve as working scratchpads — accumulating learnings as they emerge. When the action completes, anything worth keeping migrates to the appropriate node in the knowledge tree.

The key distinction: the journal captures *everything* chronologically. The knowledge tree captures only what's *worth loading into future sessions*, organised by where it applies in the codebase. The journal is the "write" side — cheap, fast, complete. The knowledge tree is the "read" side — curated, structural, loaded at session start.

### CONTEXT.md — The Map

`CONTEXT.md` sits between the two layers. It's a lightweight file that describes the repo structure and points into the knowledge tree. It tells the AI "here's the shape of the codebase, and here's where to find deeper knowledge about each area." CONTEXT.md is not the knowledge — it's the map to the knowledge.
