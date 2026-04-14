# Knowledge tree

The knowledge tree (`{lore_dir}/memory/knowledge-tree/`) is the project's long-term learning memory. A folder hierarchy where each node holds curated, actionable insights. The organising principle is **the boundaries where different knowledge applies**.

The knowledge tree is what makes session 10 cheaper than session 1. When a session loads the relevant nodes, it starts with everything previous sessions learned — without re-reading source material or re-discovering constraints.

Production rules and standing contracts do not live here — they live in the [Blueprint sub-pillar](./blueprint.md). The KT carries what the project has *learned*; the blueprint carries what the project has *committed to*.

## Three branches

| Branch         | Function                                                                                  |
| -------------- | ------------------------------------------------------------------------------------------ |
| **Reconciled** | Durable, validated insights — patterns, decisions, techniques, constraints. Authoritative. |
| **Working**    | Structured drafts in-flight — knowledge taking shape but not yet validated.                 |
| **Notepad**    | Unstructured observations captured in-flight. Low-friction intake.                          |

```
knowledge-tree/
├── knowledge-tree.index.md
├── reconciled/
│   ├── reconciled.index.md
│   ├── area-one/
│   └── area-two/
├── working/
│   └── working.index.md
└── notepad/
    ├── notepad.index.md
    └── archive/
```

## Reconciled branch

Durable, structured insights at the right node. This is where knowledge lives permanently. The tree follows the project's meaningful boundaries — each node is a folder with an index that maps what's there.

What those boundaries look like depends on the domain. A software project might organise by codebase structure. A tabletop campaign might organise by world region. A specification project might organise by subject area of the spec. The tree mirrors whatever structure makes knowledge findable for the work at hand.

When a specific concern accumulates enough knowledge to warrant its own file, it gets a `[name].spec.md` alongside the index.

## Working branch

Structured knowledge that's taking shape but hasn't been validated. Same format as reconciled — indexes, spec files, proper structure — but the content is provisional.

Working knowledge moves to reconciled when the Human Lead validates it. The promotion is mechanical — move the file, update one link. The structural shape is identical in both branches, so promotion doesn't require reformatting.

## Notepad branch

Low-friction scratch space for observations that surface during execution. Things noticed during work that don't belong anywhere yet.

**Focus-scoped, not general-purpose.** Each notepad node is tied to a specific focus or action. Observations not tied to a running focus go directly to the appropriate domain node in the reconciled or working branch.

**Lifecycle.** On focus close, durable findings migrate to their domain home in the reconciled branch. The notepad node archives with the focus.

## Artifact voice standard

KT artifacts are written lean, opinionated, forward-looking. The journal captures conversation history; the KT captures conclusions. If you deleted the journal, you would lose the story but not the knowledge.

**Organize by topic, not by session.** KT files carry conclusions; session provenance belongs in the journal.

Every artifact must be loadable by a future session at minimal token cost.

## How the tree grows

The tree grows organically. A new project starts almost empty — root index and the three branch folders with their indexes.

Nodes appear as work touches new areas. Depth follows complexity. Splitting is a sign of health.

## Knowledge file format

Every insight follows the same format:

```markdown
## <Insight title — imperative, actionable>

**Context:** <The specific situation or pattern.>
**Insight:** <What to do or avoid — prescriptive, not descriptive.>
**Source:** <journal entry or focus reference for full context>
```

Good insights are prescriptive, not descriptive.

## Maintenance

The knowledge tree is a living resource — not a write-once archive. Every stance contributes as part of normal work. The Human Lead owns the final quality. Retirement is healthy — when an insight no longer applies, retire it.
