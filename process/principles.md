---
type: process
audience: [human, ai]
---

# Core Principles

> These principles govern how the methodology operates. They are non-negotiable
> regardless of role, tier, or tooling.

> **Extended by:** [roles/operating-rules.md](../roles/operating-rules.md) (AI-specific operating rules)
> **See also:** [memory.md](./memory.md), [journaling.md](./journaling.md), [workflow.md](./workflow.md)

---

## Human Accountability

This methodology demands more from you, not less.

The AI handles production — planning, writing code, generating tests, producing artefacts, and all the recording that holds the process together (see [journaling.md](./journaling.md) for the full recording system). The AI writes; you don't. But you own every decision, and ownership lives in review.

Every plan passes through your review before it becomes code. Every insight the AI writes gets your scrutiny before it joins the knowledge tree. Every gatekeep requires your judgement — not the AI's assertion that it's done. The AI is the workforce. You are the authority. And authority means active review, not passive approval.

You are typically both the lead and the sole stakeholder — which means there is no one else to defer to. The gatekeep "my own approval" means you are accountable for the quality of what ships. This is not a limitation of the process. It is the point. AI-SDLC exists to empower you through AI, not to replace your judgement with AI output.

**This is where the process makes its real demand.** When the AI produces a phase spec, you need to evaluate whether the approach is sound — not skim it and approve. When the AI writes a journal entry, you need to verify it captured what actually happened — not assume it did. When the AI writes a key insight, you need to judge whether it's specific enough to be useful and placed at the right level — not let it accumulate unchecked. The AI generates volume. You supply the judgement that makes the volume valuable.

This is a partnership driven by you. If you disengage — rubber-stamp plans without reading them, skip review gates, accept AI output without scrutiny — the process breaks. The methodology is only as strong as the person driving it.

---

## Formalise the Implicit

The Human Lead is free to be fluid. Jump between topics, think out loud, skip ahead, change direction mid-sentence. That's how humans work, and the process doesn't fight it. But the AI must always anchor that fluidity to the process.

At every moment, the AI knows — and makes explicit — two things: **which stance** the AI is operating as, and **which action** is the current focus. When the Human Lead's direction implies a change to either of these, the AI doesn't silently follow along. It pauses and confirms:

*"That sounds like you want to revisit the gatekeep for auth-redesign. I'll shift to Architect. Correct?"*

*"You're asking me to write an implementation prompt — that's Tech Lead on new-token-model, phase 2. Should I proceed?"*

*"This question is about a different action. Should I push fix-csv-date-format onto the stack, or is this a quick aside?"*

This is not pedantry — it is the mechanism that bridges the Human Lead's flexibility with the process's discipline. Without it, the AI drifts: it answers as an Architect when it should be a Developer, it redesigns a gatekeep when it should be executing a prompt, it writes to the wrong recording files. The formalisation takes seconds and prevents the most common failure modes: stance bleed and untracked context switches.

The Human Lead can always override: "Yes, switch" or "No, stay where you are — I'm just thinking out loud." The AI's job is to ask, not to block. But it must always ask when the implicit direction would change the process state.

**What the AI tracks at all times:**

- **Active stance** — which role the AI is currently operating as
- **Active action** — which action node is the current focus
- **Active phase/prompt** — where in the implementation cycle (if executing prompts)

When any of these changes, the AI confirms with the Human Lead before proceeding. STATUS.md is updated to reflect the confirmed state.

---

## Append-Forward

The project memory moves forward, never backward. When a plan changes, the new plan is a new artefact. The old plan stays as the record of what was believed at the time. When an action outgrows its scope, the action stays as-is and children continue the work. Promotion, revision, and abandonment are all forward moves — new entries, new files, new journal notes.

This principle exists because rewriting history breaks the context chain. If a spec gets silently edited, the journal entries that reference it no longer make sense. If an action folder gets renamed or restructured, references go stale. By always moving forward — creating new artefacts rather than mutating old ones — every past reference remains valid, and the journal tells a truthful story.

The only file that genuinely mutates is STATUS.md, and even that is just pointer updates: which action is active, which phase, which prompt. Everything else is append-only.

---

## The Memory Model

The methodology maintains persistent memory through two complementary trees and a journal. This is the central mechanism — everything else serves it. Without persistent memory, every AI session starts from zero. With it, session 10 benefits from every lesson learned in sessions 1 through 9.

**The full memory model — including the two trees, the journal, the flow between them, and the Curator's audit process — is defined in [memory.md](./memory.md).** The recording system — file types, pipelines, session checklists — is defined in [journaling.md](./journaling.md). All roles should read both.
