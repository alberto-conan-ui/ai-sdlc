# Foundations

This methodology rests on three insights about how LLMs change the economics of software development. Each one enables a piece of the process that wouldn't have been practical before.

---

## Insight 1: Planning Is Now Cheap

Traditional software development resisted upfront planning for a good reason: humans can't hold enough context to plan accurately. By the time you've read the codebase, traced the dependencies, considered the edge cases, and mapped the existing patterns, you've already forgotten the first half. Waterfall failed because it demanded detailed plans from people who couldn't realistically produce them — so the industry moved to iterative discovery. Write code, see what breaks, adjust.

LLMs change this equation. An AI can read an entire codebase, hold it in context, trace execution paths, and produce a detailed plan — in minutes, not weeks. The cognitive bottleneck that made upfront planning impractical for humans does not apply to AI. Planning is now cheap.

But "plan more" is not "do waterfall." The distinction matters:

**Waterfall locks in the plan.** You plan once, at the start, and then execute that plan to completion. When reality diverges from the plan (and it always does), you either force the code to match the plan or engage a costly change control process. The plan is sacred.

**AI-SDLC locks in the discipline of planning, not the plan itself.** You plan before every phase. You execute. Implementation reveals new information. You replan. The cycle is tight — hours, not months. A plan that gets revised three times in two days isn't a failure of planning; it's the process working as designed. The plans are disposable. The discipline of producing them is not.

This is what makes the approach possible *now* in a way it wasn't before. The Architect can load the full codebase, every previous decision, every lesson learned, and produce a phase plan that accounts for the real state of the system — not a guess from a whiteboard session. And when that plan turns out to be partially wrong (which it will), the same Architect can reload context, absorb what was learned during implementation, and produce a corrected plan just as quickly.

The process is structured. The project execution is adaptive. Don't confuse the two.

---

## Insight 2: Knowledge Compounds Across Sessions

The biggest problem with AI-assisted development isn't the AI's ability to write code — it's the AI's inability to remember anything. Every new session starts from zero. The AI doesn't know why decisions were made, which approaches were tried and rejected, or what patterns your codebase follows. Without intervention, you pay the same teaching cost every session: re-explaining the architecture, re-discovering the constraints, re-learning the patterns. Session 10 is as expensive as session 1.

AI-SDLC fixes this with two layers of persistent memory:

**The Journal** is the tactical layer. A rolling chronological log — weekly files, append-only — that captures what happened: sessions, decisions, lessons learned. It is the raw, honest record of the work. Nothing gets edited, nothing gets deleted. When something changes, a new entry explains why. The journal answers "what did we do?" and "why did we decide that?"

**The Knowledge Tree** is the curated layer. A folder hierarchy that mirrors your codebase, where each node holds what you've learned about that area of the code. Unlike the journal, the knowledge tree is a living resource — insights get added, refined, promoted to broader scope, or retired when they're no longer relevant. It answers "what do we know about this part of the system?"

The two layers serve different purposes. The journal is for continuity — making sure the next session knows what just happened. The knowledge tree is for compound learning — making sure session 10 benefits from everything sessions 1 through 9 discovered, not just what happened yesterday.

The flow between them is organic, not ceremonial. Work produces journal entries. Conversation between you and the AI surfaces insights worth keeping. Those insights land in the knowledge tree at the right structural node. There's no formal "write-back step" — it happens naturally as part of the work, whenever something comes up that matters beyond the current session.

Each new session loads the relevant nodes from the knowledge tree — not the entire thing, just the parts that apply to the area of the codebase being touched. The AI reads what was learned and starts producing useful output in minutes instead of spending the first half-hour re-learning the project.

The compound curve is real but not instant. For a two-session task, the overhead barely pays for itself. For a five-phase epic spanning three weeks, the difference is dramatic. The overhead per session stays roughly constant — a few minutes of review — but the value it delivers grows with every session that contributes to the knowledge tree.

This is the core mechanism that turns individual sessions into cumulative progress. And it only works if the human reviews what the AI writes — refining vague insights, correcting inaccurate summaries, removing noise. The AI populates the journal and proposes knowledge. Your review makes it trustworthy.

---

## Insight 3: Cognitive Framing Produces Different Output

The same LLM behaves differently when told "you are an Architect — challenge assumptions and design systems" versus "you are a Developer — follow this prompt literally." This isn't role-play — it's cognitive framing. The entry point shapes which patterns the model activates, how it interprets ambiguity, what it prioritises, and what it considers "done."

This matters because design and execution are fundamentally different cognitive modes. An AI that designs a system and then immediately writes the code carries its design reasoning into execution — it second-guesses the prompt, over-engineers edge cases, and improvises beyond scope. An AI that receives only an implementation prompt, with no memory of the design discussion, follows the prompt more literally, flags discrepancies instead of silently working around them, and produces more disciplined output.

AI-SDLC exploits this by defining five distinct stances — Architect (design), Tech Lead (prompt craft), Developer (execution), Navigator (orientation), and Curator (knowledge maintenance). Each stance has an entry point that defines what the AI sees, how it thinks, and what it must not do. The boundaries prevent role bleed: the Architect doesn't over-specify implementation details, the Developer doesn't redesign the spec, the Curator doesn't write code.

Different stances also have different cognitive demands, which maps to a model tier system. Design and architectural thinking (Architect, Tech Lead on complex work) benefits from the strongest reasoning models. Literal code execution (Developer) runs well on faster, cheaper models. You match the model to the stance, optimising both cost and output quality.

In practice, you'll often stay in one session and shift stances as the conversation flows — that's the default. Separate sessions are the escalation path for complex work where you notice the AI's output degrading from stance bleed. The point isn't rigid separation — it's having the framework to separate when it matters.

---

## Who This Is For

This methodology is for senior developers. It assumes you can already architect software, evaluate trade-offs, recognise when AI output is wrong, and make sound technical decisions without guidance. The process doesn't teach you how to build software — it gives you a structure for building software *with AI* that doesn't degrade over time.

A junior developer will struggle with this methodology — not because of its complexity, but because every review gate requires you to evaluate AI output with experienced judgement. When the Architect produces a phase spec, you need to know whether the approach is sound. When the Developer produces code, you need to spot the subtle bugs that pass the tests. When the AI pushes back on your goal, you need to know when it's right and when it's wrong. These are senior skills. The process amplifies them; it doesn't replace them.

---

## When to Use This — and When Not To

AI-SDLC exists to bring structure to work that's complex enough to benefit from it. Not all work qualifies.

**Use this when** the work has dependencies, touches shared state, spans multiple files, or requires decisions that will constrain future work. When a mistake would be expensive to undo. When the AI needs to understand context that won't fit in a single prompt. When you'll come back to this code in three months and need to understand why decisions were made. Even a task — the lightest tier — earns its keep when the fix is non-obvious or the code is load-bearing.

**Don't use this when** the work is straightforward enough that you'd just do it. A one-line config change, a dependency bump, a typo fix, renaming a variable — if you can see the entire change in your head and there's no architectural judgement involved, skip the process and do the work directly. You can use AI to help with these — just don't route them through AI-SDLC. The methodology's value comes from structured context persistence, and trivial changes don't produce context worth persisting.

The test: **would you benefit from a written plan before coding this?** If yes, create an action. If the answer is obviously no, just do the work. If you're unsure, start with a task — the overhead is minimal and you can always drop it if the fix turns out to be trivial.

This is a judgement call, and the methodology trusts you to make it. That's by design — this is a tool for senior developers, not a rulebook that removes the need for experience.
