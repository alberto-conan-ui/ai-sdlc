# Blueprint

The blueprint holds the project's production rules and standing commitments for the Payload. It answers: what does good Payload look like for this project, right now, and what must it honor?

Blueprint is distinct from the [Knowledge tree](./knowledge-tree.md). The KT carries what the project has *learned* — accumulated insights, patterns, constraints discovered along the way. The blueprint carries what the project has *committed to* — the rules it produces against and the contracts it must honor. Learning compounds; rules govern.

## What goes in it

The blueprint is a place, not a template. It is the home for whatever production rules and standing commitments the project has accumulated — and only those. There is no required shape: each project grows its blueprint into whatever serves the work. A freshly bootstrapped project may have an almost-empty blueprint and still be in good standing; the file fills as real commitments accumulate.

Bootstrap seeds the blueprint from the chosen plugin, so a new project starts with whatever shape that plugin thinks is a useful jumping-off point. Adapt it freely — rename sections, drop ones that do not apply, add ones the plugin did not anticipate.

Questions a blueprint typically grows to answer, when the project has answers to them:

- **What is the Payload?** The project root minus the Lore folder. Usually answered at bootstrap.
- **What shape must the Payload take?** Format conventions, structural rules, the things a Payload file is expected to honor. Grows as conventions are decided.
- **What is the frontier?** What is in scope for production right now versus what is planned for later. Grows as scope is set.
- **What contracts must the Payload honor?** Standing, evergreen rules the Payload must meet across all work — quality bars, integration obligations, invariants that must hold across releases. Grows as contracts are committed to.

These are examples, not required sections. A project that has nothing to say about one of them simply does not have that content in its blueprint, and that is fine.

## Contracts

Contracts are standing rules — commitments the Payload must honor across all work, regardless of the active focus. A contract is concrete and evaluable: *"All Payload files must have front matter,"* *"Tests must pass before any merge,"* *"The public API surface stays backwards-compatible within a minor version."* If a contract cannot be checked by reading the Payload against it, it is not a contract — it is an aspiration.

Contracts differ from [focus gates](../tracker/tracker.index.md#gates). A gate defines done for a specific focus and expires when the focus closes. A contract is evergreen — it applies to all production, all focuses, across the life of the project.

The session reads contracts at session open (via `ai_readme.md`) so it knows what rules the Payload must meet before it produces anything.

## The blueprint is just memory

It follows the same rules as every other memory node — the same index grammar, the same reference headers, the same [tree discipline](./tree-discipline.md) and append-forward protocol.
