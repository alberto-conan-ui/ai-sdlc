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

## The Memory Model

The methodology maintains persistent memory through two complementary trees — the **action tree** (short-term memory) and the **knowledge tree** (long-term memory) — with a **journal** that bridges them and serves as the audit trail.

The action tree (`action-tree/`) holds the work in progress: session logs, working insights, and links to relevant knowledge. The knowledge tree (`knowledge-tree/`) holds curated, durable insights organised by codebase area. The journal (`journal/`) captures cross-cutting decisions and observations — it's both the bridge between the two trees and the Curator's primary audit input for verifying the memory pipeline works correctly.

Work produces logs and insights → insights migrate to the knowledge tree on action completion → the Curator audits using the journal to verify nothing was lost or misplaced.

**The full memory model — including the KEY_INSIGHTS lifecycle, the flow between trees, every role's memory responsibilities, and the Curator's audit process — is defined in [memory.md](./memory.md).** All roles should read it. This is the most important mechanism in the methodology.
