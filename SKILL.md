---
name: surface-preflight
description: >
  Audits staged Birdeye UI for copy and Storybook misses, then prints two
  tables (where, current, conflict, fix). Use when the user says commit, push,
  preflight, preflight this commit, or asks to land staged UI. Catches please,
  glossary drift, name drift (BirdAI vs Bird AI, MODL vs MODAL), and missing
  stories. Pauses on misses before git write.
metadata:
  version: "1.0.0"
---

# Surface Preflight

Birdeye engineer ships UI and says **commit** or **push**. Read the diff. Print two tables. If any row is a miss, do not run git write. Ask the stop question. Clean tables (or **commit anyway**) then commit or push.

Persona: Maya Rao, Birdeye product engineer. She will not name this skill. The workspace rule loads it.

Read [reference.md](reference.md) before scoring. If `~/.cursor/skills/birdeye-copy-skill-v2/reference.md` exists, use it for glossary and § numbers. Storybook source of truth is `AGENTS.md` and `.cursor/rules/storybook-story-required.mdc` — ignore `CLAUDE.md` §1 (“no Storybook”). Icon stroke is **1.6**.

## When this runs

| User says | Input | After tables |
|-----------|--------|----------------|
| commit | `git diff --cached` only | Pause on misses, else commit |
| push | Staged or unstaged UI diff if present; else `git log @{u}..HEAD` | Same pause sentence, then push if clean or they insist |
| preflight / preflight this commit | Staged diff, or `git show <sha>` if they name a commit | Tables only. No git write |

Empty index on **commit**: say nothing is staged and stop. Do not commit nothing.

Run `git status`, `git diff --cached`, `git log -5` (and the push range when they said push).

## Tables

Scan user-facing strings only: labels, helpers, errors, empty states, placeholders, aria-labels, plus file/export names and Storybook `title` / story `name` for **name alignment**.

Skip code, SQL, CSS, JSON keys, test ids, commit subjects.

```
Subject: why this change landed

## 1. Copy review
| Where | Current copy | Conflict | Fix |
| file → spot | exact string | rule | replacement |

Style: N misses · Name alignment: N conflicts

## 2. Storybook review
| Where | Current | Conflict | Fix |
| file → spot | what is there | rule | replacement |
```

- Cap each table at 20 rows, then `+ N more`.
- No user-facing strings → section 1 `N/A`.
- No `src/app/components/**` or `src/stories/**` in the diff → section 2 `N/A`.
- Name drift is extra rows in section 1 (same conflict, one row per place). `Modl` vs `UI/MODAL` vs `Open MODL` is three rows.
- `Sheet` vs `Modal` is section 2 (reuse), not a spelling variant.
- Score mechanical rows only. No voice score.

## Pause

If **any** miss exists (copy, Storybook, or UI just built):

1. Print the tables.
2. Do **not** run `git commit` or `git push`.
3. Show this sentence **verbatim**, then wait:

> Okay, I'm attempting to commit, but these are the issues I'm seeing from copy, Storybook, and the UI that you build. Do you want to fix and then recommit again?

4. **Yes / fix then commit** — fix the rows, run this skill again, commit only if tables are clean or they say commit anyway.
5. **No / commit anyway** — commit with a short why-subject and these tables as the body.
6. Both sections N/A or no misses — commit or push in the same turn. No question.

Push uses that same sentence. Do not write a second prompt.

Follow repo git rules: issue key if they give one; no `--no-verify`; do not push unless they said push.

## Example: `0bb45a7`

Input: `git show 0bb45a7` (`feat(settings): expand business profile editor and align Aero DS controls`).

Expected copy misses include: `Please enter a URL`; `Please enter the value of Region manager.` (and the other custom-field Please strings); `customers` vs **contact**; `BirdAI` vs **Bird AI**.

Expected Storybook misses include: `HoursOfOperationFields.tsx` added with no own story; `SparseProfile` and `ReviewsTab` without sentence-case `name:`.

Because there are misses, do not commit. Print the tables, then the stop sentence.

Full expected rows: [reference.md](reference.md#example-0bb45a7).
