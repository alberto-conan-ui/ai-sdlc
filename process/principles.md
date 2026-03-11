# Core Principles

> These principles govern how the methodology operates. They are non-negotiable
> regardless of role, tier, or tooling.

---

## Human Accountability

This methodology demands more from you, not less.

The AI handles production — planning, writing code, generating tests, producing artefacts, and all the bookkeeping that holds the process together: journal entries, STATUS.md updates, key insights, session receipts. The AI writes; you don't. But you own every decision, and ownership lives in review.

Every plan passes through your review before it becomes code. Every insight the AI writes gets your scrutiny before it joins the knowledge base. Every gatekeep requires your judgement — not the AI's assertion that it's done. The AI is the workforce. You are the authority. And authority means active review, not passive approval.

You are typically both the lead and the sole stakeholder — which means there is no one else to defer to. The gatekeep "my own approval" means you are accountable for the quality of what ships. This is not a limitation of the process. It is the point. AI-SDLC exists to empower you through AI, not to replace your judgement with AI output.

**This is where the process makes its real demand.** When the AI produces a phase spec, you need to evaluate whether the approach is sound — not skim it and approve. When the AI writes a journal entry, you need to verify it captured what actually happened — not assume it did. When the AI writes a key insight, you need to judge whether it's specific enough to be useful and placed at the right level — not let it accumulate unchecked. The AI generates volume. You supply the judgement that makes the volume valuable.

This is a partnership driven by you. If you disengage — rubber-stamp plans without reading them, skip review gates, accept AI output without scrutiny — the process breaks. The methodology is only as strong as the person driving it.

---

## Append-Forward

The project journal moves forward, never backward. When a plan changes, the new plan is a new artefact. The old plan stays as the record of what was believed at the time. When a task outgrows its scope, the task stays as-is and a new epic or goal is created to continue the work. Promotion, revision, and abandonment are all forward moves — new entries, new files, new journal notes.

This principle exists because rewriting history breaks the context chain. If a spec gets silently edited, the journal entries that reference it no longer make sense. If a task folder gets renamed or restructured, references go stale. By always moving forward — creating new artefacts rather than mutating old ones — every past reference remains valid, and the journal tells a truthful story.

The only file that genuinely mutates is STATUS.md, and even that is just pointer updates: which action is active, which phase, which prompt. Everything else is append-only.

---

## Insight Promotion

Knowledge accumulates through a three-level hierarchy: phase, action, and project. Insights flow upward as their applicability broadens.

Something happens in a session — it goes in the weekly journal file. If any role recognises it as a reusable insight, it gets written directly to the appropriate KEY_INSIGHTS.md:

- A lesson about a specific API quirk in this phase → **phase-level**
- A pattern that applies across all phases of this action → **action-level**
- A lesson about the codebase's testing infrastructure that applies everywhere → **project-level**

The promotion path: journal entry → phase KEY_INSIGHTS.md → action KEY_INSIGHTS.md → project KEY_INSIGHTS.md. When an insight from one phase proves applicable to other phases within the same action, promote it to the action level. When it proves applicable across actions, promote it to the project level. Keep the original at the lower level if it has phase-specific context that would be lost in the promotion.

Insights can also be demoted or removed when they're no longer relevant. A phase-level insight about a workaround becomes obsolete once the phase is complete. An action-level insight about an API limitation might be resolved by a later phase. The KEY_INSIGHTS.md files are living documents, not archives.

When an insight from one project proves applicable to other projects, copy it into the project-level KEY_INSIGHTS.md of those projects.
