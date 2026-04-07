# The Knowledge Tree

> **References**
>
> | Group | File |
> |---|---|
> | Memory model | [memory.md](./memory.md) |
> | Conventions | [conventions.md](./conventions.md) |
> | Action tree | [action-tree.md](./action-tree.md) |

> **Slot:** Domain KT payload structure — the plugin describes what the payload/ branch looks like for this domain. See [plugins.md](./plugins.md).

The knowledge tree (`knowledge-tree/`) is the project's long-term memory. A folder hierarchy where each node holds curated, actionable insights about an area of your project — patterns to follow, pitfalls to avoid, decisions that constrain future work. The organising principle is **the boundaries where different knowledge applies**.

The knowledge tree is what makes session 10 cheaper than session 1. When the AI loads the relevant nodes, it starts with everything previous sessions learned — without re-reading source material or re-discovering constraints.

---

## Three Branches

The knowledge tree has three branches, all present from project bootstrapping:

| Branch | Function |
|---|---|
| **Curated** | Durable, structured insights at the right node — patterns, decisions, techniques, constraints. Grows organically as work touches new areas. |
| **Notepad** | Unstructured observations captured in-flight — things noticed during execution that don't yet belong in a curated node. Low-friction intake that removes pressure to route prematurely. |
| **Payload** | How the product itself is structured. Core defines that this branch exists; the plugin defines its shape. |

The curated branch is where knowledge lives permanently. The notepad is where observations land before they're ready to be curated. The payload describes the thing being built, not knowledge about how to build it. Each branch is detailed in its own section below.

```
knowledge-tree/
├── knowledge-tree.index.md    ← root index, points to the three branches
├── curated/                   ← durable insights by area
│   ├── curated.index.md
│   ├── area-one/
│   ├── area-two/
│   └── area-three/
├── notepad/                   ← action-scoped scratch space
│   ├── notepad.index.md
│   └── archive/
└── payload/                   ← product description, plugin-defined
    └── payload.index.md
```

---

## Curated Branch

The tree follows your project's meaningful boundaries. Each node is a folder with a `[name].index.md` that maps what's there. Additional `*.spec.md` files hold deep knowledge about specific concerns. The structure tells the AI where to look — loading a single node's index is enough to orient on that area without loading the entire tree.

What those boundaries look like depends on the domain. A software project might organise by codebase structure (auth, API, infrastructure). A tabletop campaign might organise by world region, faction, or narrative arc. The tree mirrors whatever structure makes knowledge findable for the work at hand.

```
curated/
├── curated.index.md               ← cross-cutting patterns, key decisions
├── area-one/
│   ├── area-one.index.md          ← how this area works, key patterns
│   └── specific-concern.spec.md   ← deep knowledge about a narrow topic
├── area-two/
│   ├── area-two.index.md
│   └── detailed-topic.spec.md
└── area-three/
    └── area-three.index.md
```

### The index at each level

Every node has a `[name].index.md`. It uses the three-section navigation grammar defined in [conventions.md](./conventions.md#the-index--navigation-primitive): References, Siblings, Children. The AI navigates the KT the same way it navigates any tree — find the index, read References for context, scan Siblings and Children to decide what to load.

```markdown
# <Area>

> Last updated: YYYY-MM-DD

> **References**
>
> | Group | File |
> |---|---|
> | Parent | [../parent.index.md](../parent.index.md) |
> | Related action | [../../action-tree/...](link) |

## Siblings

| File | Role |
|---|---|
| [<specific>.spec.md](./<specific>.spec.md) | <one-line description> |

## Children

| Node | What it covers |
|---|---|
| [<child>/<child>.index.md](./<child>/<child>.index.md) | <one-line description> |

## Insights

<Insights that apply to this area broadly — not specific enough
for a child node, but important for anyone working here.>
```

The root `knowledge-tree.index.md` points to the three branches. `curated/curated.index.md` is the project-wide level for curated knowledge: cross-cutting patterns, key decisions, conventions that apply everywhere.

### Spec files

When a specific concern accumulates enough knowledge to warrant its own file, it gets a `[name].spec.md` alongside the index. The threshold is judgement — if the index is getting long or mixing concerns, split.

---

## Payload Branch

The payload branch describes the thing being built — not knowledge about how to build it. Core defines that this branch exists; the plugin defines its structure. An SDLC project's payload might describe codebase organisation, API surface, and deployment topology. A TTRPG campaign's payload might describe the world map, faction state, and active storylines.

Projects without a plugin can still use the payload branch — the human defines whatever structure makes sense for the domain. The payload is the KT's answer to "what does the product look like right now?"

---

## Notepad Branch

The notepad (`notepad/`) is a low-friction scratch space for observations that surface during execution. When working on an action, you often notice things that don't belong anywhere yet — a pattern worth revisiting, a "this will matter later" note. The notepad gives these observations a home without forcing premature routing into curated knowledge or losing them in the temporal journal.

**Why this matters for compounding.** Sessions can only compound on what was captured. The bottleneck is never generating insights; it's retaining them. Every observation that dies because the process made it too expensive to write down is a compounding opportunity lost — and the cost is invisible, because session 15 doesn't know what session 7 noticed but never recorded. The notepad lowers the capture threshold to near-zero. Capture first, curate later.

**How it works.** The `notepad/` branch exists from project setup, alongside the root index. When an action produces observations worth capturing, a matching notepad node is created under `notepad/` — named after the action it serves. Any stance can write to it during execution. There's no ceremony: just write what you noticed.

**Action-scoped, not general-purpose.** Each notepad node is tied to a specific AT action via the action's context file, which references the notepad node alongside domain KT links. Observations not tied to a running action go directly to the appropriate domain KT node.

**Lifecycle.** On action completion, the notepad node is reviewed as part of the standard completion checklist. Durable findings — insights that will apply to future work — migrate to their domain home in the KT. The notepad node archives with the action. The notepad branch itself persists; only its per-action nodes come and go.

**Not a gateway.** The notepad doesn't sit between the AT and domain KT nodes. Direct links to domain knowledge stay unchanged. The notepad is an accessory — a scratch pad, not a middleman.

```
notepad/
├── notepad.index.md             ← map of active notepad nodes
├── auth-redesign/               ← notes from the auth-redesign action
│   └── auth-redesign.index.md
└── archive/                     ← notepad nodes from completed actions
```

---

## How the Tree Grows

The tree grows organically. You don't scaffold a deep hierarchy upfront.

**A new project starts almost empty.** Setup creates `knowledge-tree.index.md` and the three branch folders with their indexes — nothing else in curated, nothing in payload.

**Nodes appear as work touches new areas.** The first time work touches an area, that area gets a node under `curated/`. The structure follows the work, not a predetermined taxonomy.

**Depth follows complexity.** An area worked on once might have just an index with two insights. An area worked on across ten actions might have an index, three spec files, and a dozen curated insights. Both are correct.

**Splitting is a sign of health.** When an index grows to the point where patterns are interleaved and hard to scan, split into spec files. The index becomes a map; the detail moves to dedicated files.

---

## Knowledge File Format

Every insight follows the same format — actionable, sourced, concise:

```markdown
## <Insight title — imperative, actionable>

**Context:** <The specific situation or pattern.>
**Insight:** <What to do or avoid — prescriptive, not descriptive.>
**Source:** <journal entry or action reference for full context>
```

Good insights are prescriptive, not descriptive. "Before any refactor that moves code between modules, write automated tests that assert current behaviour" teaches permanently. "Refactoring was hard" teaches nothing.

---

## What Belongs at Each Level

**Project-wide** (`curated/curated.index.md`) — patterns that apply everywhere. Naming conventions, key decisions, cross-cutting constraints.

**Area-level** (`curated/<area>/<area>.index.md`) — patterns specific to that area. Knowledge needed for work here but not in sibling areas.

**Deep knowledge** (`curated/<area>/<specific>.spec.md`) — detailed knowledge about a narrow concern within an area.

**Not in the knowledge tree** — observations specific to a single action that won't apply to future work. These live in the journal as part of the session record and are naturally discarded (archived) when the action completes.

---

## Maintenance

The knowledge tree is a living resource — not a write-once archive.

**Every stance contributes** as part of normal work. When a loaded insight is stale, fix it or flag it. When you encounter something worth knowing beyond the current session, propose placing it at the right node.

**The human owns** the final quality. The AI proposes; the human reviews, refines, and approves.

**Retirement is healthy.** When an insight no longer applies, retire it. The journal and archive preserve the historical context. The knowledge tree reflects the current truth.
