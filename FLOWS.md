# AI-SDLC: Flows

> Practical walkthroughs for common scenarios. Each flow shows the actual sequence of
> actions — which sessions to open, what to say, what to review — so you can follow
> the process without memorising PROCESS.md first.
>
> Flows are not simplifications. They *are* the process, viewed from the practitioner's
> perspective. The full machinery exists underneath; the flow shows you the path through it.

---

## Flow: Solo Goal — "Make It Mobile-Friendly"

**When this flow applies:** You're a solo developer. The work is outcome-oriented and subjective — "mobile-friendly" means different things depending on the app, the users, and the context. Multiple phases will be needed. You own every gatekeep.

**Stances you'll use:**

| Stance | Typical setup | Notes |
|---|---|---|
| Architect | Same session as Tech Lead | Designs the roadmap and phase specs |
| Tech Lead | Same session as Architect | Writes prompts, reviews execution output |
| Developer | Fresh session recommended | Cleanest output with no design context baggage |
| Navigator | Invoked when context is cold | Briefings, handoff prompts, promotion bridging |

For a goal, you might use separate sessions if the design work is deep and the Developer prompts are complex. For simpler goals, flow between Architect and Tech Lead thinking in the same conversation — the AI writes better prompts when it was part of the design discussion. You decide based on the work.

---

### 1. Get oriented and set up the action

You come in with a rough idea: "I need to make this app mobile-friendly." You don't need a polished goal statement — that's what the next step is for.

**If starting fresh or context is cold:** use the Navigator stance (load `roles/navigator.md`). Tell the AI you want to create a new goal. It will brief you on the current state and, if you're opening a separate session, generate a handoff prompt for the Architect. Set up the action folder, update STATUS.md, and log the first journal entry per common.md.

**If you're already in a session and context is warm:** ask the AI to set up the action folder and STATUS.md entry, or do it yourself. Then shift to Architect stance to define the goal.

Either way, by the end of this step you have: an action folder (`actions/goal-mobile-friendly/`), a STATUS.md entry in PLANNING mode, and a first journal entry.

---

### 2. Define the Goal and Design the Roadmap

**Stance: Architect** (load `roles/architect.md` — fresh session or shift stances in the current one, your call)

If you have a Navigator handoff prompt, paste it. If you're shifting stances, give the AI the context: "I want to define a goal around making the app mobile-friendly. Read CONTEXT.md and let's shape it." This is a conversation — you and the AI go back and forth until the goal is clear and the roadmap makes sense.

The Architect reads the codebase and CONTEXT.md, then pushes you on the vague parts. "Mobile-friendly" isn't a goal — it's a wish. Expect questions like: which workflows need to work on mobile? What does "work" mean — just renders, or comfortable to use? Who decides it's done? You provide the domain answers; the Architect shapes them into a GOAL.md with a clear problem statement, vision, design principles, and gatekeep.

From there, the conversation naturally moves to planning. The Architect breaks the goal into phases — for this example, something like:

| Phase | Name | One-liner |
|---|---|---|
| 1 | Audit & baseline | Catalogue what's broken, establish device-testing workflow |
| 2 | Layout system | Replace fixed layouts with responsive grid/flex |
| 3 | Navigation | Mobile nav pattern (hamburger, bottom tabs, etc.) |
| 4 | Touch & interaction | Touch targets, swipe gestures, input handling |
| 5 | Core workflows | End-to-end testing of registration, browsing, checkout on mobile |

Push back on the roadmap. Is the phase order right? Is anything missing? Is the scope realistic? The Architect should defend its choices or revise them.

Whether this takes one session or several doesn't matter. If you need a fresh handoff between sessions, use the Navigator stance (or write one yourself). By the end, you have an approved GOAL.md, a roadmap in STATUS.md, and a phase 1 spec (SPEC.md).

---

### 3. Implementation

Shift to Tech Lead stance with the phase spec. You'll usually continue in the same session — the shared context from the Architect discussion helps the AI write better prompts. From here, implementation is freestyle — you and the AI find your rhythm, and you decide how much oversight each phase needs. There's no single "right" way to run this loop.

**In Tech Lead stance, the AI:** reads the phase spec and breaks it into implementation prompts. Maybe it writes a full prompt plan upfront. Maybe it writes one prompt at a time, adjusting based on what execution reveals. You discuss the approach together — it depends on how predictable the work is. An audit phase with well-known tooling? Plan it all upfront. A layout refactor touching unknown CSS? One prompt at a time, adapting as you go.

**In Developer stance, the AI:** executes prompts literally, runs verification commands, produces a session receipt — what was done, what files changed, any surprises. The receipt is the context bridge to the next prompt. The Developer doesn't design, doesn't improvise, doesn't second-guess the prompt. For complex prompts, consider running the Developer in a fresh session — an AI with no memory of the design discussion produces more disciplined output.

**What you do:** whatever level of review makes sense. Some phases you'll want to read every prompt before execution. Others you'll let the AI cycle through prompts, reviewing the output at the end. For phase 1 (audit) you might barely check in. For phase 2 (layout system) you might review every prompt because it touches everything. For phase 4 (touch & interaction) you might shift back to Architect thinking because the patterns are unfamiliar. This is your call, phase by phase.

**In a single session (the common case),** the loop is just a flowing conversation: you discuss the prompt approach, the AI writes the prompt, the AI executes it, reports what happened, and you discuss the next one. No overhead between steps. In separate sessions, session receipts bridge the gap. Either way, the AI handles its own upkeep (journal, STATUS.md) per common.md.

---

### 4. Phase Handover

When a phase is done, handle the handover. For complex handovers (especially after a long phase or when context has drifted), use the Navigator stance — the AI reads the project state and suggests the next move. The AI logs what happened and updates STATUS.md per common.md. For simple handovers, update tracking and move on.

**Shift back to Architect thinking and review:** does this phase move you toward the goal's gatekeep? For the audit phase: do you have a clear catalogue of issues and a working device-testing workflow? If something's off, the Architect helps you decide — fix prompts, or a revised approach? If the phase is solid, the Architect designs the next phase spec, loading the previous phase's insights and the updated codebase context. Each phase builds on what was learned before.

Then back to step 3 — Tech Lead and Developer implement the next phase.

**Repeat steps 3–4 for each phase** until the goal is achieved.

---

### 5. Evaluate the Goal

After all phases are complete (or enough that you're satisfied):

**You test on real devices.** Not simulated viewports — actual phones. Can you complete registration, browsing, and checkout without pain?

**This is a goal-tier gatekeep — it's subjective.** "Tests pass" isn't enough. You're asking yourself: is this actually mobile-friendly? Would a real user be comfortable? If not, add another phase. If yes, you're done.

---

### What This Flow Actually Looks Like Day-to-Day

The description above is the full arc. In daily practice, most of your time is spent in step 3 — working with the AI to get code written. You'll typically stay in one session, flowing between Architect and Tech Lead thinking as the conversation moves from design to prompts. You might open a fresh session for the Developer on each prompt batch, or stay in the same session for low-risk work. You might use the Navigator stance at the start of the day when context is cold, or just ask the AI "where was I?" when context is warm. You'll find your rhythm — the methodology provides the stances and the structure, not the session management rules.

---

### When Things Go Sideways

**The Architect's roadmap was wrong.** Phase 2 reveals that the layout system can't be swapped without also reworking the navigation. You decide to go back to Planning. The AI logs the decision in the journal (per common.md), and in Architect stance writes a revised roadmap (new version — the original stays as-is). This is the process working, not failing.

**A Developer session improvises.** The AI in Developer stance encounters a CSS framework conflict and "fixes" it by rewriting the build config. This is outside the prompt's scope. The session receipt flags it. You shift to Tech Lead thinking to review, and decide whether the fix holds or needs to be reverted. The lesson goes in the journal; if it applies beyond this phase, it gets promoted to KEY_INSIGHTS.md.

**You lose momentum.** Three weeks pass. You come back and context is cold. This is when the Navigator stance earns its cost — the AI reads STATUS.md and the journal, tells you exactly which phase you were on, what was done, and what's pending. It also checks the git log for external changes that might affect the work. You pick up where you left off.

**The goal changes.** Halfway through, stakeholder feedback shifts the priority from "mobile-friendly" to "mobile-first with offline support." The original goal stays as-is (append-forward). You create a new goal that supersedes it. The AI bridges the context — whether through Navigator stance or simply carrying it forward in the same session. Everything learned in the first goal carries over.
