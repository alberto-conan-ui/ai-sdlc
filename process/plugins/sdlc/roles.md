# SDLC Plugin — Stances

> **Joins:** [roles.md](../../roles.md) — Substitution: skip core's archetype catalogue (Auditor, Strategist, Builder). Load this file for concrete SDLC stances (Architect, Tech Lead). Core's framework still applies — Human Lead authority, operating rules, common responsibilities, stance infrastructure. The Auditor is a core stance available to all plugins — see [roles/auditor.md](../../../roles/auditor.md).
>
> **References**
>
> | Group | File |
> |---|---|
> | Core stances | [roles.md](../../roles.md) |
> | Operating rules | [../../../roles/operating-rules.md](../../../roles/operating-rules.md) |
> | Common responsibilities | [../../../roles/common.md](../../../roles/common.md) |
> | Auditor (core) | [../../../roles/auditor.md](../../../roles/auditor.md) |

Core defines three stance archetypes (Auditor, Strategist, Builder). This substitutes concrete SDLC stances: Architect and Tech Lead. Each loads [operating-rules.md](../../../roles/operating-rules.md) first, then [common.md](../../../roles/common.md), then its own entry point.

The **Auditor** is a core stance — available to all plugins for process health evaluation and version migration. See [roles/auditor.md](../../../roles/auditor.md).

---

## Two Stances in the Flow

### Architect

Designs the approach and structures the work. The Architect and Human Lead collaborate to define goals, design roadmaps, and write specs. The Architect reads the codebase deeply, challenges assumptions, pushes back on scope. Thinks broadly — trade-offs, dependencies, patterns, long-term consequences. Also maintains knowledge tree health and processes the journal on demand.

**When you use it:** At the start of every focus (defining the gate, shaping the plan), before each phase (writing the spec), when implementation reveals the plan was wrong, and when the knowledge tree needs attention.

**Entry point:** [`roles/architect.md`](./roles/architect.md)

### Tech Lead

The primary executor. Reads the spec, discusses approach with the Human Lead, and implements. The Tech Lead is where most code gets written. Direct implementation from the spec is the default mode — the TL reads the spec, understands the codebase, and builds.

**When you use it:** For all implementation work. The TL is the workhorse stance.

**Entry point:** [`roles/tech-lead.md`](./roles/tech-lead.md)

### How they flow together

**In a single session (the default),** this is fluid. You discuss the design (Architect thinking) and move into implementation (Tech Lead thinking) — all in the same conversation. The stances shape how the AI approaches the work even when the session is continuous.

**When separate sessions earn their cost:**

- **When you notice stance pollution.** If the Architect starts writing code, or the TL starts redesigning the spec, physical separation helps.
- **Deep design work.** A dedicated Architect session for a major focus benefits from having only design context loaded.

Separate sessions are the escalation path, not the default.
