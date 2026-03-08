# AI-SDLC: Flows

> Practical walkthroughs for common scenarios. Each flow shows the actual sequence of
> actions — which sessions to open, what to say, what to review — so you can follow
> the process without memorising PROCESS.md first.
>
> Flows are not simplifications. They *are* the process, viewed from the practitioner's
> perspective. The full machinery exists underneath; the flow shows you the path through it.

---

## Flow: Solo Goal — "Make It Mobile-Friendly"

**When this flow applies:** You're a solo developer. The work is outcome-oriented and subjective — "mobile-friendly" means different things depending on the app, the users, and the context. Multiple phases will be needed. You are both the Human Lead and the sole stakeholder, so you own every gatekeep.

**Roles in play:**

| Role | Sessions | Notes |
|---|---|---|
| Human Lead | You, always | Every decision, every gate |
| Orchestrator | One session, stays open | Your home base between role sessions |
| Senior Architect | Separate sessions as needed | Designs the roadmap and phase specs |
| Technical Lead | Separate sessions as needed | Writes prompts, reviews Developer output |
| Developer | Separate sessions, one per prompt batch | Executes prompts |

For a goal, full role separation is the default. The Architect and Tech Lead run in separate sessions because the cognitive demands are genuinely different — the Architect needs broad codebase context and systems thinking; the Tech Lead needs the phase spec and precision.

---

### 1. Start with the Orchestrator

**Session: Orchestrator** (load `roles/orchestrator.md`)

You come in with a rough idea: "I need to make this app mobile-friendly." You don't need a polished goal statement — that's what the next step is for.

Tell the Orchestrator you want to create a new goal. Give it the brief: "The app was built desktop-first and it's unusable on phones. I need to make the core workflows work on mobile."

The Orchestrator will:

- Scaffold the action folder (`actions/goal-mobile-friendly/`)
- Create the action entry in STATUS.md
- Set the mode to PLANNING
- Log the first journal entry
- Generate a handoff prompt for an Architect session to define the goal properly

The Orchestrator is your home base — it keeps tracking current and generates handoff prompts when you need them. You don't have to tab back to it between every session, but it's there when you need orientation, when you've lost track, or when you're picking up after a break.

---

### 2. Define the Goal and Design the Roadmap with the Architect

**Session: Senior Architect** (load `roles/architect.md`)

Paste the Orchestrator's handoff prompt. This is a conversation — you and the Architect go back and forth until the goal is clear and the roadmap makes sense.

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

Whether this takes one session or several doesn't matter. The Orchestrator is there between sessions if you need a fresh handoff. By the end, you have an approved GOAL.md, a roadmap in STATUS.md, and a phase 1 spec (SPEC.md).

---

### 3. Implementation

Open a Tech Lead session with the phase spec. From here, implementation is freestyle — the Tech Lead and Developer find their rhythm, and you decide how much oversight each phase needs. There's no single "right" way to run this loop.

**What the Tech Lead does:** reads the phase spec, breaks it into implementation prompts. Maybe it writes a full prompt plan upfront. Maybe it writes one prompt at a time, adjusting based on what the Developer reports back. You discuss the approach with the Tech Lead — it depends on how predictable the work is. An audit phase with well-known tooling? Plan it all upfront. A layout refactor touching unknown CSS? One prompt at a time, adapting as you go.

**What the Developer does:** executes prompts literally, runs verification commands, produces a session receipt — what was done, what files changed, any surprises. The receipt is the context bridge to the next prompt. The Developer doesn't design, doesn't improvise, doesn't second-guess the prompt.

**What you do:** whatever level of review makes sense. Some phases you'll want to read every prompt before the Developer touches it. Others you'll let the Tech Lead and Developer cycle through, reviewing the output at the end. For phase 1 (audit) you might barely check in. For phase 2 (layout system) you might review every prompt because it touches everything. For phase 4 (touch & interaction) you might pull the Architect back in because the patterns are unfamiliar. This is your call, phase by phase.

**The Orchestrator stays out of this loop.** The Tech Lead and Developer pass context between each other through session receipts — that's the mechanism. No Orchestrator overhead between prompts. The loop is tight: Tech Lead writes prompt → Developer executes → session receipt → Tech Lead writes next prompt.

---

### 4. Phase Handover

When a phase is done, come back to the Orchestrator. This is where it earns its keep — at the handover between phases, not within them.

The Orchestrator logs what happened during the phase, updates STATUS.md and the journal, and suggests the next move. Typically: open an Architect session to review the phase outcome together and plan the next one.

**You and the Architect review:** does this phase move you toward the goal's gatekeep? For the audit phase: do you have a clear catalogue of issues and a working device-testing workflow? If something's off, the Architect helps you decide — fix prompts from the Tech Lead, or a revised approach? If the phase is solid, the Architect designs the next phase spec, loading the previous phase's insights and the updated codebase context. Each phase builds on what was learned before.

Then back to step 3 — Tech Lead and Developer implement the next phase.

**Repeat steps 3–4 for each phase** until the goal is achieved.

---

### 5. Evaluate the Goal

After all phases are complete (or enough that you're satisfied):

**You test on real devices.** Not simulated viewports — actual phones. Can you complete registration, browsing, and checkout without pain?

**This is a goal-tier gatekeep — it's subjective.** "Tests pass" isn't enough. You're asking yourself: is this actually mobile-friendly? Would a real user be comfortable? If not, add another phase. If yes, you're done.

---

### What This Flow Actually Looks Like Day-to-Day

The description above is the full arc. In daily practice, most of your time is spent in step 3 — talking to the Tech Lead and Developer, getting code written. The Orchestrator is there for the bookends: when you start work and need to know where things stand, and when you stop and want tracking updated. In between, you're just having conversations with the right role for the job.

---

### When Things Go Sideways

**The Architect's roadmap was wrong.** Phase 2 reveals that the layout system can't be swapped without also reworking the navigation. The Tech Lead flags it. You decide to go back to Planning. The Orchestrator logs the decision, the Architect writes a revised roadmap (new version — the original stays as-is). This is the process working, not failing.

**A Developer session improvises.** The Developer encounters a CSS framework conflict and "fixes" it by rewriting the build config. This is outside the prompt's scope. The session receipt flags it. The Tech Lead reviews, and you decide whether the fix holds or needs to be reverted. The lesson goes in the journal; if it applies beyond this phase, it gets promoted to KEY_INSIGHTS.md.

**You lose momentum.** Three weeks pass. You come back, open the Orchestrator, ask "where was I?" It reads STATUS.md and the journal, tells you exactly which phase you were on, what was done, and what's pending. It also checks the git log for external changes that might affect the work. You pick up where you left off.

**The goal changes.** Halfway through, stakeholder feedback shifts the priority from "mobile-friendly" to "mobile-first with offline support." The original goal stays as-is (append-forward). You create a new goal that supersedes it. The Orchestrator bridges the context — everything learned in the first goal carries over.
