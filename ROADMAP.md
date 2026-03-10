# AI-SDLC — Development Roadmap

> Where the methodology itself stands. Read this before critiquing — it captures known gaps
> and deliberate deferrals so reviews can focus on what's genuinely unknown.

---

## Current Stage: Inception

The methodology is being written and refined. The core documents describe the full process, but the project is not yet battle-tested across multiple real codebases. Expect revisions as practical experience accumulates.

## What's Done

- **Core process defined.** PROCESS.md covers actions, tiers, gatekeeping, roles, workflow, scaling, and anti-patterns.
- **Context isolation architecture.** MECHANICS.md explains why roles use entry points, how cognitive framing works, and the trade-offs between separate sessions and mode switching.
- **Prompt craft guide.** PROMPTS.md covers the four principles, just-in-time prompting, session receipts, and common failures.
- **Templates and conventions.** TEMPLATES.md defines the full project journal structure, file templates, naming conventions, and insight promotion model.
- **Workspace setup.** SETUP.md covers the three-folder convention, workspace.yaml, and multi-project scaling.
- **Role entry points.** All four AI roles (Orchestrator, Architect, Tech Lead, Developer) have entry points in `roles/`.
- **One example flow.** FLOWS.md has a solo goal walkthrough.
- **Session flexibility.** Role separation reframed as a cognitive framing technique with compression as the default (March 2026 revision).

## Known Gaps — Will Be Addressed

These are recognized issues that will be tackled as the methodology matures:

- **First-impression weight.** The documents are comprehensive but read as heavy. A quick-start guide ("tasks in 5 minutes") would give newcomers an entry point that doesn't require reading 489 lines of PROCESS.md first. Deferred until the core methodology stabilizes.
- **More flows.** FLOWS.md only has a solo goal walkthrough. Task and epic flows are the most common daily scenarios and are needed. Deferred because the goal flow covers the most moving parts — simpler flows are subsets of it.
- **Version control guidance.** Nothing about branching strategy, commit cadence, or how to handle AI-generated code that needs multiple iterations before it's commit-worthy. Will be added based on practical patterns.
- **Cost management.** No discussion of when Tier 1 models aren't worth the cost, or how to manage token budgets across a multi-phase epic. Will be informed by real usage data.
- **Project-level failure recovery.** The append-forward principle handles phase-level revisions well, but there's no guidance on when to abandon an epic entirely and start over. Will be addressed as edge cases emerge.
- **Model tier table freshness.** The illustrative model mapping in PROCESS.md will go stale. Consider removing specific model names and keeping only the tier characteristics.

## Known Concerns — Acknowledged, Not Yet Validated

These are structural questions raised during review that need real-world validation:

- **Insight curation durability.** The three-level KEY_INSIGHTS.md hierarchy (project, action, phase) is theoretically sound but may be too much editorial overhead in practice. Watch for curation lapses — if they happen consistently, simplify to a single file per action.
- **Context window limits.** As projects accumulate insights, CONTEXT.md, three levels of KEY_INSIGHTS.md, and a phase spec may push useful context limits for smaller models. No data yet on where the practical ceiling is.
- **Process-as-procrastination.** The methodology could become a way to avoid shipping — endlessly refining specs, curating insights, and updating STATUS.md while writing no code. No anti-pattern for this yet because the right framing hasn't been found.

