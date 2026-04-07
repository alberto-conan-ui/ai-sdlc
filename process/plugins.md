# Plugins

> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Memory model | [memory.md](./memory.md) |
> | Workflow | [workflow.md](./workflow.md) |

AI-Lore's core is domain-agnostic — the memory model, workflow, focus mechanics, journaling, and operating principles work for any kind of project. Plugins add the domain-specific layer: the stances, conventions, and checkpoints that make the process feel native to a particular kind of work.

---

## What the Core Provides

The core is the shared foundation that every project uses, regardless of domain:

- **Memory model** — journal, action tree, knowledge tree, status/focus entry point
- **Workflow** — focus, modes, transitions, session persistence
- **Operating principles** — human accountability, append-forward, reconciliation, simplicity
- **Journaling** — session recording, handovers, close protocol

Every project declares a plugin. The plugin is what makes the core concrete for your domain — without one, the AI has no stances, no domain conventions, and no way to adopt the right cognitive posture for the work.

---

## Declaring a Plugin

A project declares its plugin in `workspace.yaml` — the manifest read at session start. The manifest names the plugin and points to its session configuration file:

```yaml
plugin: sdlc
plugin_readme: "{methodology}/process/plugins/sdlc/ai_readme.md"
```

One plugin per project. A missing plugin declaration is an error — see [Missing Plugin](#missing-plugin).

The `ai_readme.md` (core session entry point) tells the AI to read `workspace.yaml` for the plugin, then read the plugin's session configuration file. That file contains the plugin's loading table, stance catalogue, and quick reference — everything the AI needs to layer the plugin on top of core.

The `ai_readme` itself does not use the slot/join pattern. It is the entry point — there is nothing before it to provide context. Instead, the manifest acts as the bridge: `ai_readme` → `workspace.yaml` → plugin's `ai_readme`.

---

## Slots and Joins

Core files declare **slots** — places where the core is deliberately abstract because a plugin provides the concrete. Plugin files declare **joins** — which core file they attach to and how.

### How it works

**Core side.** A core file that has a slot declares it with a brief description of what the plugin fills:

```markdown
> **Slot:** Domain-specific work cycle — filled by plugin
```

**Plugin side.** Each plugin file declares its join as the first line of the header. The join is self-describing — it names the core file, the relationship type, and explains exactly what to load and how:

```markdown
> **Joins:** [workflow.md](../../workflow.md) — Addendum: load core workflow first
> (focus, modes, stack, headless, checkpoints), then layer this file for the
> SDLC-specific design → implementation cycle and stance flow.
```

The join carries its own semantics. A reader — human or AI — understands the relationship from the declaration alone, without looking up abstract rules.

### Relationship types

Two types, but each join explains its own meaning concretely:

- **Addendum** — load core first, then layer the plugin file on top. Both apply. The join declaration says what core provides and what the plugin adds.
- **Substitution** — the plugin replaces a specific part of core's content. The join declaration says what to skip in core and what the plugin provides instead. Core's framework (principles, operating rules, infrastructure) still applies — only the named content is replaced.

### Core slots

| Core file | Slot | Typical relationship |
|---|---|---|
| `roles.md` | Domain stances | Substitution — concrete stances replace core archetypes |
| `workflow.md` | Domain work cycle | Addendum — domain cycle layers on core focus/modes |
| `action-tree.md` | Domain node types | Addendum — domain nodes layer on core containers/leaves |
| `conventions.md` | Domain naming and file types | Addendum — domain conventions layer on core grammar |
| `knowledge-tree.md` | Domain KT payload structure | Addendum — domain payload layers on core branches |

Not every plugin fills every slot. A minimal plugin might only join `roles.md` (one stance) and leave everything else to core defaults.

---

## What a Plugin Adds

A plugin layers domain-specific structure on top of the core by filling slots:

| Slot | What the plugin defines | Example |
|---|---|---|
| **Stances** | Domain-specific cognitive postures the AI adopts | SDLC: Architect, Tech Lead. TTRPG: Game Master. |
| **Conventions** | Naming, file types, structural rules specific to the domain | SDLC: phase specs, node type naming. |
| **Checkpoints** | Additional gates beyond the core focus gate | SDLC: spec review before implementation. |
| **KT payload** | Structure of the knowledge tree's payload branch | SDLC: codebase patterns, API surface. TTRPG: world lore, faction state. |

A plugin never replaces core mechanics — it extends or specialises them. The focus gate still works. Modes still work. The journal still works.

---

## The Boundary

**Core owns:**
- The memory model and its three layers
- Focus, modes, and mode transitions
- Session protocols (open, close, handover)
- Operating rules (human authority, append-forward, reconciliation)
- The workflow's structure

**Plugins own:**
- Which stances exist and what each one does
- Domain-specific conventions and file types
- Additional checkpoints layered on the core
- The shape of the KT payload branch
- Any domain-specific workflow extensions (e.g., an SDLC plugin's design → implementation cycle)

**The test:** If you removed all plugins, would the core still function as a complete (if general) process? Yes. If you removed the core, would a plugin function? No. Plugins depend on core; core does not depend on plugins.

---

## Missing Plugin

Every project must declare a plugin. If the AI reads `workspace.yaml` and finds no `plugin` field, this is not a valid state — the project is either not bootstrapped or predates the plugin architecture.

**The AI must not proceed without a plugin.** Instead, it should:

1. Tell the human: the project is missing a plugin declaration.
2. Ask which plugin the project should use.
3. Suggest loading the **Auditor** stance to diagnose and migrate.

The Auditor owns version migration — transitioning a project's memory structures from one process version to another. A missing plugin declaration is the v0.2 → v0.3 migration signal. The Auditor reads the changelog, assesses the project, proposes the migration (including plugin selection and bootstrap), and executes after human approval. See the [Auditor stance](../roles/auditor.md) — a core stance available to all plugins that handles process health evaluation and version migration.

---

## Bootstrapping a New Project

A new project is set up through the bootstrap process (see [bootstrap/README.md](../bootstrap/README.md)):

1. Choose a plugin — the domain this project operates in (SDLC, TTRPG, spec, etc.)
2. Generate `workspace.yaml` with the plugin declaration and path references
3. Generate `ai_readme.md` from the core template
4. Create the memory folder structure (`.ai-lore/memory/` with status, journal, and empty trees)

The result: the AI can read `ai_readme.md`, find the plugin in `workspace.yaml`, and begin working immediately.
