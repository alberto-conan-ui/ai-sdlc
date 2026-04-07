# Conventions

> **References**
>
> | Group | File |
> |---|---|
> | Memory model | [memory.md](./memory.md) |
> | Action tree | [action-tree.md](./action-tree.md) |
> | Knowledge tree | [knowledge-tree.md](./knowledge-tree.md) |

> **Slot:** Domain naming and file types — the plugin adds domain-specific conventions on top of these core structural rules. See [plugins.md](./plugins.md).

Structural conventions for the memory model. These apply across all three layers — journal, action tree, and knowledge tree.

---

## The Typed File System

Every file in the memory system follows one naming convention: **`[name].[type].md`**. The type suffix tells you what the file is without opening it. See [action-tree.md](./action-tree.md) and [knowledge-tree.md](./knowledge-tree.md) for the valid types in each tree.

---

## The Index — Navigation Primitive

The index file is the core navigation mechanism of the memory model. Every orientation decision the AI makes flows through an index. When the AI enters a folder, it reads the index. When it needs to decide what to load next, it follows links from the index. The index is not a bureaucratic requirement — it's the interface between the AI and the project's memory.

Every folder has `[folder-name].index.md`. No exceptions. The index uses a three-section navigation grammar:

**References** — external context this folder depends on. The parent index, relevant knowledge tree nodes, relevant journal entries. References point up and sideways — they tell the AI what else it needs to understand this node. References appear on all files (not just indexes), but they're the first section of every index.

**Siblings** — typed companion files in the same folder. Siblings are listed with a brief role description so the AI knows what each file contributes without opening it.

**Children** — nodes below this one in the hierarchy. Child folders or files, listed with brief descriptions. Children are the downward navigation path — the AI follows them when the task requires going deeper.

The grammar is the same everywhere: AT indexes, KT indexes, journal indexes. The AI uses the same pattern to navigate: find the index, read References to understand context, scan Siblings to see companion files, scan Children to decide whether to go deeper.

---

## Reference Headers

Every file in the memory system has a reference header that declares its dependencies — what other files need to be read to understand this one. Content lives in exactly one place; references point to it. In index files, this is the References section of the navigation grammar. In non-index files, it serves the same purpose: declare what the reader needs to load for context.

```markdown
> **References**
>
> | Group | File |
> |---|---|
> | Foundation | [principles.md](./principles.md) |
> | Parent context | [../parent.index.md](../parent.index.md) |
```

Conventions: groups are labeled (why the reference matters), ordered by importance (reading strategy for the AI), and point up and sideways (downward traversal is implicit — the AI reads children when the task requires it).

When a file moves, update the references that point to it. Single-source means there's nothing else to update.

---

## Naming Conventions

- Project memory folder: `.ai-lore/memory/`
- File naming: `[name].[type].md` — every file declares its type in the name
- Every folder: `[folder-name].index.md` — navigation entry point
- Node numbering: two-digit IDs starting at `05`, incrementing by `5` — see [action-tree.md — Numbering Convention](./action-tree.md#numbering-convention)
- AT node folders: `NN.type.kebab-case-name/` — the type is plugin-defined (e.g., SDLC uses goal, topic, phase, step)
- AT leaf files: `NN.type.kebab-case-name.md` — single file, no folder
- Journal files: `YYYY-MM-DD_NN.md` in `journal/live/`

---

## Linking Rules

All links in index files follow the navigation grammar. These mechanical rules apply everywhere:

- All links point to `.md` files, never to folders. Use `[child/child.index.md](./child/child.index.md)`, not `[child/](./child/)`.
- **References** point up and sideways — parent index, relevant KT nodes, relevant journal entries. Each reference includes a group label explaining why it matters.
- **Siblings** list companion files in the same folder — gatekeep, context, spec. Each includes a brief role description.
- **Children** list contained nodes — child folders (via their index) and child task files. Each includes a brief description.
- Links use relative paths. When a file moves, update the references that point to it.

---

## Status Vocabulary

One vocabulary for all node types. The mode (Planning, Executing, or Reflecting — see [principles.md](./principles.md#interaction-modes)) tells you how to interpret artifacts; the status tells you where the work stands.

- `Pending` — defined, not started
- `Active` — work in progress
- `Paused` — stopped temporarily, reason in journal
- `Review` — work complete, awaiting human assessment
- `Done` — human confirmed (ungatkept nodes: steps, tasks)
- `Achieved` — human confirmed, gate passed (gatekept nodes: goals, topics, phases)

**The rule:** no node transitions to Done or Achieved without an explicit human decision. The AI can move things to Review. Only the human moves things past Review. This enforces human accountability at the status vocabulary level.

---

## Hierarchy Discipline

Well-structured trees keep references short and navigation efficient. This is a human responsibility — the process signals when the hierarchy is degraded, but only the human decides how to restructure.

### What makes a good node

A node earns its folder when it has a distinct concern that's loaded independently. In the KT, that means the information is needed for work in this area but not in sibling areas. In the AT, that means the work has its own completion criteria and its own lifecycle.

### Signals the hierarchy needs attention

- A file exceeds ~200 lines — split into children.
- A folder has more than 5–7 direct children — add intermediate grouping.
- A reference header has more than 4–5 entries — the hierarchy isn't carrying enough context implicitly.
- The same information appears in multiple siblings — cross-cutting concern should move up.

The human owns the tree shape. AI stances propose; the human confirms, redirects, or restructures.
