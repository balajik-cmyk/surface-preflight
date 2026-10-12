# Surface Preflight

Cursor skill plus an always-on rule. When someone says **commit** or **push**, the agent prints copy and Storybook tables and stops if anything fails.

No git hook. No GitHub Action.

- **1.0.0** First installable package.

## Install in another repo

Skill and the commit/push rule, from the other repo root:

```bash
npx github:balajik-cmyk/surface-preflight
```

Skill only (Skills CLI). You still need the rule for auto-run:

```bash
npx skills add balajik-cmyk/surface-preflight
sh .cursor/skills/surface-preflight/scripts/install.sh .
```

If this folder is already on disk:

```bash
sh scripts/install.sh /path/to/their-repo
```

That writes:

```
.cursor/skills/surface-preflight/SKILL.md
.cursor/skills/surface-preflight/reference.md
.cursor/rules/surface-preflight.mdc
```

Commit those files in their repo.

## Check it

Stage a UI change. In Cursor say **commit**. You should see two tables. A miss should pause with:

> Okay, I'm attempting to commit, but these are the issues I'm seeing from copy, Storybook, and the UI that you build. Do you want to fix and then recommit again?

**preflight this commit** prints the tables only.

## Optional glossary

The bundled `reference.md` is enough. For the full Birdeye copy glossary, keep `birdeye-copy-skill-v2` under `~/.cursor/skills/` on each machine.
