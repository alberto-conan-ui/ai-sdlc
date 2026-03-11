# File Type Catalogue

Every file in the project memory has a defined type. This catalogue documents each one — what it's for, where it lives, who creates it, and what it looks like.

For the overall memory structure diagram and conventions, see [templates.md](../templates.md).

---

## Project-Level

| Type | File | Required | Created by |
|---|---|---|---|
| [workspace-yaml](./workspace-yaml.md) | `workspace.yaml` | Yes | Bootstrapper |
| [status](./status.md) | `action-tree/STATUS.md` | Yes | Bootstrapper, then all roles |

## Knowledge Tree

| Type | File | Required | Created by |
|---|---|---|---|
| [knowledge-index](./knowledge-index.md) | `index.spec.md` | Yes (every KT node) | Bootstrapper (root), Architect (areas) |
| [knowledge-spec](./knowledge-spec.md) | `*.spec.md` | No | Any role, audited by Curator |

## Action Tree (per action node)

| Type | File | Required | Created by |
|---|---|---|---|
| [gatekeep](./gatekeep.md) | `gatekeep.md` | Yes (every node) | Architect or Human Lead |
| [action-context](./action-context.md) | `context.md` | No | Architect |
| [action-index](./action-index.md) | `index.md` | No (branch nodes only) | Architect |
| [action-log](./action-log.md) | `log.md` | No | All roles (except Developer) |
| [key-insights](./key-insights.md) | `KEY_INSIGHTS.md` | No | All roles (except Developer) |

## Phase-Level (inside `phases/N-name/`)

| Type | File | Required | Created by |
|---|---|---|---|
| [phase](./phase.md) | `phase.md` | Yes (per phase) | Tech Lead |
| [prompt-plan](./prompt-plan.md) | `prompt-plan.md` | No (optional for simple actions) | Tech Lead |
| [implementation-prompt](./implementation-prompt.md) | `NN-description.md` | Yes (per prompt) | Tech Lead |
| [session-receipt](./session-receipt.md) | `NN-description.receipt.md` | Yes (per prompt executed) | Developer |

## Journal

| Type | File | Required | Created by |
|---|---|---|---|
| [journal-entry](./journal-entry.md) | `YYYY-WNN.md` | No | All roles (except Developer) |
