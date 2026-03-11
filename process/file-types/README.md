# File Type Catalogue

Every file in the project memory has a defined type. This catalogue is the **single source of truth** for each file type — what it's for, where it lives, who creates it, which engagement mode it belongs to, and what it looks like. All other documents point here for file-type definitions rather than re-describing them.

For the overall memory structure diagram, see [conventions.md](../conventions.md). For the recording system — how files connect, the recording pipelines per engagement mode, and the session checklists — see [journaling.md](../journaling.md).

---

## Project-Level

| Type | File | Required | Created by | Mode |
|---|---|---|---|---|
| [workspace-yaml](./workspace-yaml.md) | `workspace.yaml` | Yes | Bootstrapper | — |
| [status](./status.md) | `action-tree/STATUS.md` | Yes | Bootstrapper, then all roles | Both |

## Knowledge Tree

| Type | File | Required | Created by | Mode |
|---|---|---|---|---|
| [knowledge-index](./knowledge-index.md) | `index.spec.md` | Yes (every KT node) | Bootstrapper (root), Architect (areas) | Shaping |
| [knowledge-spec](./knowledge-spec.md) | `*.spec.md` | No | Any role, audited by Curator | Shaping |

## Action Tree (per action node)

| Type | File | Required | Created by | Mode |
|---|---|---|---|---|
| [gatekeep](./gatekeep.md) | `gatekeep.md` | Yes (every node) | Architect or Human Lead | Shaping |
| [action-context](./action-context.md) | `context.md` | No | Architect | Shaping |
| [action-index](./action-index.md) | `index.md` | No (branch nodes only) | Architect | Shaping |
| [action-log](./action-log.md) | `log.md` | No | All roles (except Developer) | Both |
| [key-insights](./key-insights.md) | `KEY_INSIGHTS.md` | No | All roles (except Developer) | Working |

## Phase-Level (inside `phases/N-name/`)

| Type | File | Required | Created by | Mode |
|---|---|---|---|---|
| [phase](./phase.md) | `phase.md` | Yes (per phase) | Architect | Shaping → Working |
| [prompt-plan](./prompt-plan.md) | `prompt-plan.md` | No (optional for simple actions) | Tech Lead | Working |
| [implementation-prompt](./implementation-prompt.md) | `NN-description.md` | Yes (per prompt) | Tech Lead | Working |
| [session-receipt](./session-receipt.md) | `NN-description.receipt.md` | Yes (per prompt executed) | Developer | Working |

## Journal

| Type | File | Required | Created by | Mode |
|---|---|---|---|---|
| [journal-entry](./journal-entry.md) | `YYYY-WNN.md` | No | All roles (except Developer) | Both (primary in Shaping) |
