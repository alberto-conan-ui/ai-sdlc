# Core Principles

> These principles govern how the methodology operates. They are non-negotiable
> regardless of stance or domain.

> **References**
>
> | Group | File |
> |---|---|
> | AI operating rules | [roles/operating-rules.md](../roles/operating-rules.md) |
> | Memory model | [memory.md](./memory.md) |
> | Recording system | [journaling.md](./journaling.md) |
> | Workflow | [workflow.md](./workflow.md) |

---

## Simplicity

Every piece of ceremony must earn its place. This is the most important lesson from real-world usage — the parts of the methodology that survived were the simple ones. The parts that didn't survive were the ones that asked for recording, classification, or structure that nobody needed.

The process must be simple. When in doubt, leave it out. A convention that isn't followed is worse than no convention — it creates guilt without value, and it clutters the documentation that the AI loads on every session. If something consistently goes unproduced, that's a signal to remove it from the process, not to try harder.

Simplicity pushes discipline onto the human lead. The human is responsible for organising hierarchies, triggering journal processing, and maintaining tree quality. This is a feature, not a cost. The process supports the human; it does not replace their judgment.

---

## Human Accountability

This methodology demands more from you, not less.

The AI handles production — planning, writing, generating, producing artefacts, and all the recording that holds the process together (see [journaling.md](./journaling.md) for the full recording system). The AI writes; you don't. But you own every decision, and ownership lives in review.

Every plan passes through your review before it becomes authoritative. Every insight the AI writes gets your scrutiny before it joins the knowledge tree. Every gate requires your judgement — not the AI's assertion that it's done. The AI is the workforce. You are the authority. And authority means active review, not passive approval.

You are typically both the lead and the sole stakeholder — which means there is no one else to defer to. The gate "my own approval" means you are accountable for the quality of what ships. This is not a limitation of the process. It is the point. The methodology exists to empower you through AI, not to replace your judgement with AI output.

**This is where the process makes its real demand.** When the AI produces a plan, you need to evaluate whether the approach is sound — not skim it and approve. When the AI writes a journal entry, you need to verify it captured what actually happened — not assume it did. When the AI writes a key insight, you need to judge whether it's specific enough to be useful and placed at the right level — not let it accumulate unchecked. The AI generates volume. You supply the judgement that makes the volume valuable.

This is a partnership driven by you. If you disengage — rubber-stamp plans without reading them, skip review gates, accept AI output without scrutiny — the process breaks. The methodology is only as strong as the person driving it.

---

## Formalise the Implicit

The Human Lead is free to be fluid. Jump between topics, think out loud, skip ahead, change direction mid-sentence. That's how humans work, and the process doesn't fight it. But the AI must always anchor that fluidity to the process.

At every moment, the AI knows — and makes explicit — two things: **which stance** the AI is operating as (if a plugin defines stances), and **which focus** is active. When the Human Lead's direction implies a change to either of these, the AI doesn't silently follow along. It pauses and confirms:

*"That sounds like you want to revisit the gate for auth-redesign. Should I shift stance?"*

*"This question is about a different focus. Should I push it onto the stack, or is this a quick aside?"*

This is not pedantry — it is the mechanism that bridges the Human Lead's flexibility with the process's discipline. Without it, the AI drifts: it answers in the wrong stance, it works on the wrong focus, it writes to the wrong recording files. The formalisation takes seconds and prevents the most common failure modes: stance bleed and untracked context switches.

The Human Lead can always override: "Yes, switch" or "No, stay where you are — I'm just thinking out loud." The AI's job is to ask, not to block. But it must always ask when the implicit direction would change the process state.

**What the AI tracks at all times:**

- **Active stance** — which stance the AI is currently operating as (plugin-defined, or general-purpose if no plugin)
- **Active mode** — Planning, Executing, or Reflecting (see [Interaction Modes](#interaction-modes)); absent when headless
- **Active focus** — which focus is active, or headless (see [workflow.md](./workflow.md))

When any of these changes, the AI confirms with the Human Lead before proceeding. `status.md` is updated to reflect the confirmed state.

---

## Interaction Modes

The process has three modes: **Planning**, **Executing**, and **Reflecting**. The mode governs how the AI interprets artifacts and how it collaborates with the Human Lead. The mode is always explicit — recorded in `status.md` and announced at session start. Modes apply when a focus is active; when the project is headless, there is no mode (see [workflow.md — Headless](./workflow.md#headless)).

**Planning** and **Executing** drive work forward. They differ in posture — one treats artifacts as provisional, the other as authoritative — but both operate *within* a focus, moving it toward its gate. **Reflecting** steps outside the work. The focus stays active, but the session examines, reshapes, or rethinks the approach rather than advancing it.

**Planning mode.** The Human Lead and the AI are shaping work together. Everything produced is provisional. Artifacts capture the conversation's current state — they are working notes, not commitments. The AI's posture: challenge assumptions, offer alternatives, hold things loosely. The handover (see [journaling.md](./journaling.md)) carries the state of the discussion. A new session reading these artifacts should treat them as drafts, not as approved plans.

**Executing mode.** A plan has been approved by the Human Lead. The AI acts within that plan's scope. Artifacts are authoritative — they define what the work is, not what it might be. The AI's posture: follow the plan, flag deviations, stay within scope. If execution reveals the plan was wrong, the AI flags the issue and waits for the Human Lead to decide whether to switch back to Planning.

**Reflecting mode.** The Human Lead and AI step back to examine the work itself. Is the approach right? Is the focus itself right? Is the project's memory still accurate? Reflecting is for when the work needs rethinking, not more doing. Any part of the project's memory can be reshaped in Reflecting mode — focus files, status, journal annotations, knowledge. The AT and KT have additional rules: see [updating-trees.md](./updating-trees.md) for append-forward and reconciliation.

Reflecting is reachable from both Planning and Executing — whenever the approach itself is the thing that needs attention, not the work within it. Without Reflecting, the process would force forward motion even when the direction is wrong. You enter, you examine, you reshape or take notes, and you exit back into Planning or Executing. The journal captures what happened during reflection; the handover tells the next session whether to continue reflecting or resume forward motion.

Reflecting is also where **reconciliation** happens — the controlled exception to append-forward that allows the AT and KT to be reshaped when strategic direction changes. Reconciliation requires explicit Human Lead approval and is documented in the journal. See [updating-trees.md](./updating-trees.md) for the full protocol.

**Mode transitions.** The human can jump between modes freely — any mode to any mode, at any time. The process doesn't fight that. The AI's job is to make the transition explicit and help the human think clearly about it. The transition from Planning to Executing deserves extra scrutiny — this is where provisional becomes authoritative, and effort begins. See [workflow.md — Checkpoints](./workflow.md#checkpoints).

**Modes are orthogonal to stances.** Any stance can operate in any mode. Modes describe *how* you're engaging with the work, not *what kind* of work you're doing. A planning conversation looks different depending on the domain and stance — but the posture (provisional, challenging, exploratory) is the same.

---

## Append-Forward and Reconciliation

Two operations govern how the AT and KT change. **Append-forward** is the default — memory moves forward, never backward, preserving the context chain. **Reconciliation** is the controlled exception — when strategic direction changes, the trees are reshaped under Reflecting mode with Human Lead approval.

Both are equally important. Append-forward protects history during normal operation. Reconciliation prevents the trees from accumulating contradictions after a strategic shift. Each is critical when used at the right time.

See [updating-trees.md](./updating-trees.md) for the full mechanics of both operations.

---

## Token Efficiency by Design

The methodology's structural conventions are designed so that AI sessions load less and orient faster as the project matures. This is not a side effect — it's an architectural goal that drives design decisions throughout the process.

**Indexes are loading hints.** The three-section navigation grammar (References, Siblings, Children) tells the AI what to load and in what order. Labeled reference groups signal importance: the AI reads the most relevant context first, skipping what doesn't apply. A well-structured index means the AI loads five files instead of fifty.

**Curated knowledge replaces raw re-reading.** Without a knowledge tree, every session re-reads source material to rediscover constraints. With one, the AI loads a curated node that distills what ten previous sessions learned — in a fraction of the tokens. The curation cost is paid once; the loading savings compound on every subsequent session.

**Hierarchy keeps trees shallow.** The hierarchy discipline (see [conventions.md](./conventions.md#hierarchy-discipline)) limits folder depth and file size. Shallow trees mean fewer navigation steps. Shorter files mean less token waste per load. The ~200-line signal and 5–7 children guideline exist because they produce efficient loading, not because they look tidy.

**Reference headers declare dependencies.** Every file says what else needs to be read to understand it. The AI doesn't guess — it follows the declared dependencies. This prevents both under-loading (missing context) and over-loading (wasting tokens on irrelevant files).

The compound curve is expressed in tokens: session 1 loads raw material and produces knowledge. Session 10 loads curated knowledge and produces immediately. The methodology gets cheaper to run as the project matures — the opposite of entropy.

---

## Core as Infrastructure

The memory model has three layers, but not all are required for every project.

**The journal is mandatory.** Every session produces a journal entry. This is the minimum viable memory — session continuity through handovers, a temporal record of what happened.

**The action tree and knowledge tree are available infrastructure.** They're powerful when a project needs them — the AT for complex work decomposition, the KT for long-term knowledge that compounds. But a project can run on journal alone. A simple project, a short engagement, a domain where knowledge doesn't accumulate — these don't need trees, and the process doesn't force them.

The process scales with the work. Use what earns its keep.

---

## Prerequisites

### Strong Reasoning Model

The process assumes and requires a strong reasoning model (e.g., Claude Opus class). No fallback mode, no degraded operation for lesser models.

The process is designed to let strong reasoning models shine: labeled reference groups give the model signal about what to load and how deeply, the hierarchy lets it navigate efficiently, the unstructured journal trusts it to extract decisions without pre-classification, and the adaptive flow trusts its judgment about when to shift stances.

A smaller model will follow the ceremony without the judgment — which is worse than no methodology at all because it creates false confidence. If you don't have access to a strong reasoning model, this methodology is not for you.

### The Memory Model

The methodology maintains persistent memory through three complementary layers: the action tree (intention), the knowledge tree (long-term knowledge), and the journal (temporal intake and audit trail). This is the central mechanism — everything else serves it.

**The full memory model** is defined in [memory.md](./memory.md). **The recording system** is defined in [journaling.md](./journaling.md). All stances should read both.
