# Stances

> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Workflow | [workflow.md](./workflow.md) |
> | Plugins | [plugins.md](./plugins.md) |

This is a solo practitioner's framework. You — the human — are the only person. The AI is your tool, and you direct it by shifting between cognitive stances. Stances are framing techniques — telling the AI "you are a strategist, challenge assumptions" produces different output than "you are an executor, implement this plan." Different stances produce different thinking. That's the entire mechanism.

---

## You — The Human Lead

You define focuses, set gates, and have final authority over everything — approvals, direction, trade-offs. Every review gate in this process exists so you can catch mistakes before they compound.

Your primary job is defining what success looks like and verifying that it was achieved. You provide the domain context the AI cannot infer, challenge assumptions, and decide when a plan is good enough to execute. You also decide when to override the process — skip a step, change direction, simplify.

You decide session boundaries. You review knowledge contributions. You carry the full weight of gatekeeping. This is by design.

---

## Three Archetypes

The core defines three stance archetypes — fundamental kinds of thinking that recur across domains. Plugins compose these into domain-specific stances, combining or specialising them as the domain requires.

### Auditor

The process examiner. Looks at how the work is being done, not what's being done. Points out process problems, recommends corrective actions, evaluates whether the methodology is serving the project. Inward-facing: "is the process healthy?"

**When this thinking applies:** Process friction, methodology migrations, memory model health checks, post-mortems on what went wrong in the process (not the product).

### Strategist

The direction questioner. Steps outside the work to ask whether it should be done at all. Evaluates high-level strategy, alignment, differentiation, and fit. Skeptical by default — the project is not ready until the evidence convinces you. Outward-facing: "is this the right thing to do?"

**When this thinking applies:** Before committing significant effort, when an honest assessment of direction is needed, when positioning or audience claims need evaluation.

### Builder

The practitioner. Once direction is confirmed and the process is sound, the Builder produces the work — designs, implements, writes, creates. This is the stance that operates within the domain: an SDLC Builder writes code, a TTRPG Builder writes narrative, a research Builder synthesises findings.

**When this thinking applies:** All production work. The Builder is the workhorse archetype.

### How plugins compose them

A plugin's named stances are compositions of these archetypes. An SDLC "Architect" might combine Strategist thinking (challenge assumptions, evaluate trade-offs) with Builder thinking (design the approach, write specs). A "Tech Lead" is primarily Builder. An "Auditor" stance maps directly to the Auditor archetype.

Plugins are free to weight the archetypes however the domain demands. A stance can lean heavily on one archetype or blend all three. The archetypes are the vocabulary; the plugin writes the sentences.

---

## Plugin-Defined Stances

> **Slot:** Domain stances — the plugin defines which concrete stances exist, what each one does, and when to use them. See [plugins.md](./plugins.md).

Which specific stances exist, what each one is called, and when to use them — these are defined by the plugin for your domain. An SDLC plugin might define Architect and Tech Lead. A TTRPG plugin might define Narrator and Lorekeeper. A project with no plugin uses the archetypes directly or operates without named stances.

What the core provides is the infrastructure stances operate within:

- **Operating rules** — session protocols, human authority, append-forward, stance drift awareness. These apply to every stance regardless of domain. See [operating-rules.md](../roles/operating-rules.md).
- **Common responsibilities** — status updates, orientation, external change awareness. Shared duties all stances perform. See [common.md](../roles/common.md).
- **Recording system** — what gets written, where it goes. See [journaling.md](./journaling.md).

Plugins define stance entry points — files the AI loads to adopt a specific cognitive posture. Each entry point loads operating-rules.md first, then common.md, then the stance-specific file. This loading sequence is fixed; the content of the stance file is plugin territory.

---

## Model Selection

Use the strongest reasoning model available for work that requires architectural thinking, trade-off analysis, and nuanced judgement. Use whatever model is most practical for execution. Token efficiency is one benefit of session separation: different stances may load different context. In separate sessions, each loads exactly what it needs.
