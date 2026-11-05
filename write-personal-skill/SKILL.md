---
name: write-personal-skill
description: Repository, conventions file, installation and git handling for the user's personal skills, kept in a claude-skills git repo and loaded through junctions. Use when creating a personal skill or changing an existing one in any way (rule, example, section, description, name), including when a cross-project rule stated by the user must be recorded in a skill.
---

# Writing a personal skill

Applies to creating **and** changing a personal skill, however small the change.

## 1. Find the repo

Personal skills live in the `claude-skills` git repo, one `<name>/SKILL.md` folder per skill, loaded by Claude Code through a junction in `%USERPROFILE%\.claude\skills`.

Never hardcode the repo path. Derive it from this skill's junction:

```powershell
$repo = Split-Path (Get-Item "$env:USERPROFILE\.claude\skills\write-personal-skill").Target
```

## 2. Read the user's conventions

Before writing anything, read `$repo\personal-skill-conventions.md` in full. It holds the user's method, naming, writing and testing rules: follow it for the whole task.

The file is missing: run `& "$repo\install.ps1"`, which creates it from the base template, then read it.

## 3. Git and installation

- The user manages the repo history. Make no change to the git index: no `git add`, `git mv`, `git rm`, commit or push. Rename a folder with a plain file move.
- After a creation or a rename, run `& "$repo\install.ps1"`: it creates the new junctions and removes those of deleted or renamed skills.
- After a rename, also update every mention of the old name in the repo (other skills' descriptions, `CLAUDE.md`, `README.md`, `personal-skill-conventions.md`).

## 4. Report and propose the commit

At the end, report:

1. what changed, file by file;
2. what the conventions file required (tests included) and what was done, with results;
3. anything that departs from the user's request, with why.

Then ask the user whether to commit & push the claude-skills repo. No commit, no push without explicit confirmation.

## Red flags — stop

- About to write in a skill without having read `personal-skill-conventions.md`.
- About to run a git command other than a read (`status`, `diff`, `log`).
