# The Memory Model

AI-SDLC gives your project a durable memory through two complementary trees and a journal that bridges them. This is the central mechanism — everything else in the methodology serves it. Without persistent memory, every AI session starts from zero. With it, session 10 benefits from every lesson learned in sessions 1 through 9.

This document is the single reference for how memory works. Every role participates in maintaining it. The [Curator](../roles/curator.md) audits it. The Human Lead owns it.

---

## The Two Trees

The project memory holds two trees. They serve different purposes and follow different rules, but they feed each other continuously.

### The Action Tree — Short-Term Memory

The action tree (`action-tree/`) holds the work in progress. It is the project's short-term memory — what's happening *right now*. Each action node carries files that capture the live state of the work: `log.md` (session history), `KEY_INSIGHTS.md` (working scratchpad for insights), `context.md` (links to relevant knowledge), and `gatekeep.md` (completion criteria). The action tree is temporary by design — when an action completes, its insights migrate to the knowledge tree and the action subtree moves to `archive/`.

See [action-tree.md](./action-tree.md) for the full tree structure, node files, gatekeeping model, and the active stack.

### The Knowledge Tree — Long-Term Memory

The knowledge tree (`knowledge-tree/`) is a folder hierarchy organised by the boundaries where different knowledge applies — typically mirroring your codebase, but also accommodating cross-cutting concerns. Each node holds curated insights as knowledge specs (`.spec.md` files) — patterns to follow, pitfalls to avoid, architectural decisions that constrain future work.

Unlike the action tree, the knowledge tree is permanent and living. Insights get added, refined, moved to a different node, or retired when they're no longer relevant. The tree grows organically as work takes you into different areas of the codebase — you don't scaffold it upfront.

See [knowledge-tree.md](./knowledge-tree.md) for the full structural guide — how to organise nodes, growth patterns, monorepo layouts, and what belongs at each level.

---

## The Journal — Bridge and Audit Trail

The journal (`journal/`) captures cross-cutting annotations — project-level decisions, observations spanning multiple actions, process changes. It sits between the two trees and serves two purposes:

**As a bridge:** The journal captures what transcends individual actions. A decision that affects the whole project, a pattern noticed across multiple actions, a process change — these don't belong in any single action's log. The journal is where they live.

**As an audit trail:** The journal is the Curator's primary input. When the Curator audits the memory, the journal is how they verify that insights were captured correctly, placed at the right level, and nothing important was lost. Every cross-cutting decision, every observation worth preserving, passes through the journal on its way to the knowledge tree. If the journal says a decision was made but the knowledge tree doesn't reflect it, something was missed. If the knowledge tree contains an insight with no journal or action-log source, it's unverifiable.

Journal entries are tagged by type:

- `[decision]` — a non-trivial project-level choice with context and reasoning
- `[observation]` — cross-cutting patterns, recurring issues, something worth tracking
- `[process]` — changes to how the team works, tooling updates, methodology adjustments

The journal follows the append-forward principle: entries are never edited or deleted. Weekly rolling files (`YYYY-WNN.md`) keep it manageable.

Detailed session history lives in each action's `log.md`, not in the journal. The journal captures what transcends individual actions.

---

## How Memory Flows

The two trees and the journal form a pipeline. Work produces raw material; the pipeline turns it into durable knowledge.

```
┌─────────────────────────────────────────────────────────┐
│                     ACTION TREE                         │
│                                                         │
│  Sessions produce:                                      │
│    • log.md entries (what happened)                     │
│    • KEY_INSIGHTS.md entries (what was learned)         │
│                                                         │
│  Cross-cutting observations go to:                      │
│    • journal/ entries (decisions, patterns, process)     │
│                                                         │
└──────────────────────┬──────────────────────────────────┘
                       │
                       │  On action completion:
                       │  KEY_INSIGHTS.md reviewed
                       │  Worth-keeping insights migrate
                       │
                       ▼
┌─────────────────────────────────────────────────────────┐
│                    KNOWLEDGE TREE                        │
│                                                         │
│  Receives curated insights at the right structural node │
│  Maintained by all roles, audited by the Curator        │
│  Loaded by future sessions for relevant areas           │
│                                                         │
└─────────────────────────────────────────────────────────┘
                       ▲
                       │
                       │  Curator audits using:
                       │  journal/ + action logs + KEY_INSIGHTS
                       │
┌──────────────────────┴──────────────────────────────────┐
│                      JOURNAL                            │
│                                                         │
│  The audit trail that lets the Curator verify:          │
│    • Were insights captured?                            │
│    • Are they at the right level?                       │
│    • Is anything missing or stale?                      │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

The flow is continuous, not ceremonial. It happens as part of normal work:

1. **During sessions**, every role writes log entries in the active action's `log.md` and surfaces insights to `KEY_INSIGHTS.md`. Cross-cutting decisions go to the journal. This is not extra work — it's part of the role's normal output.

2. **During the work**, insights that clearly belong in the knowledge tree can go there immediately. If an insight is about a specific area of the codebase and it's durable (not just relevant to the current action), propose placing it in the knowledge tree at the right node. Don't wait for action completion.

3. **On action completion**, the Human Lead and the active role review `KEY_INSIGHTS.md`. Anything worth keeping migrates to the appropriate knowledge tree node. The action subtree moves to `archive/`. The knowledge outlives the action that produced it.

4. **Periodically**, the Curator audits the full memory — reading the journal, action logs, and KEY_INSIGHTS files to catch what was missed, retire what's stale, and ensure the knowledge tree accurately reflects what the project has learned. The journal is the Curator's primary audit input.

---

## The KEY_INSIGHTS.md Lifecycle

KEY_INSIGHTS.md is the scratchpad that bridges the gap between "something was learned" and "the knowledge tree reflects it." Understanding its lifecycle prevents insights from being lost or accumulating as noise.

**When to create an entry:** When you encounter something during the work that matters beyond the current session — a pattern, a pitfall, a decision rationale, a codebase quirk. Write it immediately. Don't wait to see if it'll matter; write it and let review sort it out.

**Format — actionable, not descriptive:**

```markdown
## <Insight title — imperative, actionable>

**Context:** <the specific situation or pattern>
**Insight:** <what to do or avoid — prescriptive, not descriptive>
**Source:** journal/YYYY-WNN.md, YYYY-MM-DD (or action log reference)
```

Bad: "Refactoring was hard."
Good: "Before any refactor that moves code between modules, write automated tests that assert current behaviour. Run them before and after. If they pass without test changes, the refactor preserved behaviour."

**Where it lives while active:** In the action node's `KEY_INSIGHTS.md`. This is the working scratchpad scoped to the current work. Every role that works on the action can read and contribute to it.

**When to migrate to the knowledge tree:**

- **Immediately**, if the insight is clearly about a specific codebase area and is durable — not just relevant to this action. Propose placement and let the Human Lead confirm.
- **On action completion**, as part of the completion review. Everything still in KEY_INSIGHTS.md gets evaluated: keep (migrate to knowledge tree), discard (turned out to be transient), or revise (the insight was right but needs sharpening).

**When to discard:** When the insight turned out to be wrong, was superseded by a later discovery, or is too specific to the action to be useful elsewhere. Discarding is fine — KEY_INSIGHTS.md is a scratchpad, not a permanent record. The action's `log.md` preserves the historical context if you ever need to understand why something was tried.

**Who reviews:** The Human Lead reviews knowledge contributions as they appear. The Curator audits the full pipeline periodically. Both can propose additions, moves, rewrites, or retirements.

---

## Every Role's Memory Responsibilities

Memory maintenance is not a separate activity — it's woven into every role's normal work. The specifics differ by stance, but the core responsibilities are shared.

### What every role does (except Developer)

**Write log entries.** Every session's work gets logged in the active action's `log.md`. What was accomplished, what was decided, what's pending. Keep entries concise — the log is a trail, not a report.

```markdown
## YYYY-MM-DD — <Your Role>

<What happened in this session.>

**Detail:** *(optional — include for complex sessions, skip for simple ones)*
- **Phase:** N — <name>
- **Files touched:** <paths>
- **Open threads:** <anything pending>
- **Next:** <what to pick up next session>
```

**Surface insights.** When you produce or encounter something that matters beyond this session, write it to the appropriate place:

- Specific to this action's work → **`KEY_INSIGHTS.md`** at the action node
- About a specific area of the codebase → **knowledge tree** node matching that area
- Cross-cutting, project-wide → **knowledge tree** root `knowledge-tree/index.spec.md`

If you're unsure about placement, propose it and let the Human Lead confirm or redirect.

**Log cross-cutting decisions.** Things that affect the project beyond the current action go in the journal (`journal/YYYY-WNN.md`) tagged as `[decision]`, `[observation]`, or `[process]`.

**Read the relevant memory on session start.** Read `knowledge-tree/index.spec.md` to orient on the codebase and identify relevant knowledge tree nodes. Load the nodes that apply to this action. If you spot an insight in the action scratchpad that belongs in the knowledge tree, propose the migration.

### The Developer exception

The Developer is largely exempt from memory maintenance. The Developer's session receipt serves as its log contribution, and it doesn't manage insights, STATUS.md, or the journal. The Developer loads only the current implementation prompt — nothing else. This isolation is by design; it keeps the Developer focused on literal execution.

### The Curator's audit role

The Curator is the memory auditor. In dedicated sessions, the Curator reads the full journal, all action logs, and all KEY_INSIGHTS.md files — then proposes editorial actions: promote, demote, retire, rewrite, or add insights in the knowledge tree. The journal is the Curator's primary audit input — the trail that lets them verify the memory pipeline is working correctly.

See [curator.md](../roles/curator.md) for the full audit process.

---

## Project-Level Map

`knowledge-tree/index.spec.md` serves as the project-level map alongside the two trees. It's a lightweight file that describes repo structure and points into knowledge tree nodes for deeper insight by area. It tells the AI "here's the shape of the codebase, and here's where to find deeper knowledge about each area." When the codebase structure changes, the Architect updates `knowledge-tree/index.spec.md`. When the Curator notices drift, they flag it for the Architect.
