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

| Role | Typical session setup | Notes |
|---|---|---|
| Human Lead | You, always | Every decision, every gate |
| Orchestrator | Inline or dedicated — your call | Dedicated when context is cold; inline for quick updates |
| Senior Architect | Often shared with Tech Lead | Designs the roadmap and phase specs |
| Technical Lead | Often shared with Architect | Writes prompts, reviews Developer output |
| Developer | Fresh session recommended | Cleanest output with no design context baggage |

For a goal, you might choose full role separation if the design work is deep and the Developer prompts are complex. For simpler goals, the Architect and Tech Lead can share a session — the Tech Lead benefits from having been part of the design conversation. The Human Lead decides based on the work.

---

### 1. Get oriented and set up the action

You come in with a rough idea: "I need to make this app mobile-friendly." You don't need a polished goal statement — that's what the next step is for.

**If starting fresh or context is cold:** open an Orchestrator session (load `roles/orchestrator.md`). Tell it you want to create a new goal. It will scaffold the action folder, update STATUS.md, log the first journal entry, and generate a handoff prompt for the Architect.

**If you're already in a session and context is warm:** ask your current role to set up the action folder and STATUS.md entry, or do it yourself. Then switch to Architect mode to define the goal.

Either way, by the end of this step you have: an action folder (`actions/goal-mobile-friendly/`), a STATUS.md entry in PLANNING mode, and a first journal entry.

---

### 2. Define the Goal and Design the Roadmap with the Architect

**Session: Senior Architect** (load `roles/architect.md` — fresh session or mode switch, your call)

If you have an Orchestrator handoff prompt, paste it. If you're mode-switching, give the Architect the context: "I want to define a goal around making the app mobile-friendly. Read CONTEXT.md and let's shape it." This is a conversation — you and the Architect go back and forth until the goal is clear and the roadmap makes sense.

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

Whether this takes one session or several doesn't matter. If you need a fresh handoff between sessions, ask the Orchestrator (or write one yourself). By the end, you have an approved GOAL.md, a roadmap in STATUS.md, and a phase 1 spec (SPEC.md).

---

### 3. Implementation

Switch to the Tech Lead role with the phase spec. You can continue in the same session as the Architect (the shared context often helps) or open a fresh one — your call. From here, implementation is freestyle — the Tech Lead and Developer find their rhythm, and you decide how much oversight each phase needs. There's no single "right" way to run this loop.

**What the Tech Lead does:** reads the phase spec, breaks it into implementation prompts. Maybe it writes a full prompt plan upfront. Maybe it writes one prompt at a time, adjusting based on what the Developer reports back. You discuss the approach with the Tech Lead — it depends on how predictable the work is. An audit phase with well-known tooling? Plan it all upfront. A layout refactor touching unknown CSS? One prompt at a time, adapting as you go.

**What the Developer does:** executes prompts literally, runs verification commands, produces a session receipt — what was done, what files changed, any surprises. The receipt is the context bridge to the next prompt. The Developer doesn't design, doesn't improvise, doesn't second-guess the prompt. For complex prompts, consider running the Developer in a fresh session — a Developer with no memory of the design discussion produces more disciplined output.

**What you do:** whatever level of review makes sense. Some phases you'll want to read every prompt before the Developer touches it. Others you'll let the Tech Lead and Developer cycle through, reviewing the output at the end. For phase 1 (audit) you might barely check in. For phase 2 (layout system) you might review every prompt because it touches everything. For phase 4 (touch & interaction) you might pull the Architect back in because the patterns are unfamiliar. This is your call, phase by phase.

**The Orchestrator stays out of this loop.** The Tech Lead and Developer pass context between each other through session receipts — that's the mechanism. No Orchestrator overhead between prompts. The loop is tight: Tech Lead writes prompt → Developer executes → session receipt → Tech Lead writes next prompt.

---

### 4. Phase Handover

When a phase is done, handle the handover. For complex handovers (especially after a long phase or when context has drifted), the Orchestrator is valuable here — it logs what happened, updates STATUS.md and the journal, and suggests the next move. For simple handovers, update tracking yourself and move on.

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

The description above is the full arc. In daily practice, most of your time is spent in step 3 — talking to the Tech Lead and Developer, getting code written. You might run the Architect and Tech Lead in one session, switching modes as the conversation flows from design to prompts. You might open a fresh Developer session for each prompt batch, or share the session for low-risk work. The Orchestrator might be a dedicated session at the start of the day, or just a quick "where was I?" question to whatever role is active. You'll find your rhythm — the methodology provides the roles and the structure, not the session management rules.

---

### When Things Go Sideways

**The Architect's roadmap was wrong.** Phase 2 reveals that the layout system can't be swapped without also reworking the navigation. The Tech Lead flags it. You decide to go back to Planning. The Orchestrator logs the decision, the Architect writes a revised roadmap (new version — the original stays as-is). This is the process working, not failing.

**A Developer session improvises.** The Developer encounters a CSS framework conflict and "fixes" it by rewriting the build config. This is outside the prompt's scope. The session receipt flags it. The Tech Lead reviews, and you decide whether the fix holds or needs to be reverted. The lesson goes in the journal; if it applies beyond this phase, it gets promoted to KEY_INSIGHTS.md.

**You lose momentum.** Three weeks pass. You come back and context is cold. This is when a dedicated Orchestrator session earns its cost — it reads STATUS.md and the journal, tells you exactly which phase you were on, what was done, and what's pending. It also checks the git log for external changes that might affect the work. You pick up where you left off.

**The goal changes.** Halfway through, stakeholder feedback shifts the priority from "mobile-friendly" to "mobile-first with offline support." The original goal stays as-is (append-forward). You create a new goal that supersedes it. The Orchestrator bridges the context — everything learned in the first goal carries over.
