# Personal skill conventions

The user's own rules for writing personal skills. `write-personal-skill` reads this file before any writing in a personal skill. The user may rewrite it entirely.

These conventions govern the user's personal skills. They do not apply to `write-personal-skill` itself, which comes from the base repo.

## Method

**REQUIRED:** Use superpowers:writing-skills for the writing and testing method. Where it disagrees with this file, this file wins.

## Name

- Lowercase letters, digits and single hyphens, 64 characters at most, identical to the folder name.
- The family comes first, then the specific part: `coding-style-csharp`, `specs-propose`, `worktree-finish`. A family's shared rules take the bare family name: `coding-style`.
- Before creating a skill, look for its family: the prefix its sibling skills share. Siblings that share only a suffix (`csharp-writing-style`, `angular-writing-style`) form no family yet: build the family name from what they cover (`coding-style-sql`), and propose renaming the siblings.
- A name the user proposes that breaks these rules: before creating or renaming anything, point it out with the compliant alternative and wait for the user's choice.

## Description

- English, third person, 1024 characters at most.
- One phrase on what the skill covers, then `Use when …` with concrete triggers.
- Never list the skill's steps: an agent would follow the summary instead of the body.

## Body

- English. Code identifiers and domain terms stay exactly as they appear in code.
- An existing skill not yet written in English keeps its language for a single-rule change. A rewrite switches it to English.
- `SKILL.md` stays under 500 lines and states every rule with a short ✅ / ❌ example, so a rule applies even when no reference file is read.
- `SKILL.md` also stays under 5,000 tokens: after a context compaction, Claude Code keeps only the first 5,000 tokens of a skill and drops the rest. Measure it after every change (tiktoken `cl100k_base` gives a close estimate). Close to the limit, move long examples or reasons to `references/` before adding a rule. Move, never delete: whatever leaves `SKILL.md` lands in a reference file.
- Long examples, edge cases and sources go in `references/<topic>.md`. Plan this folder as soon as the user announces many examples or sources.
- Each reference file is linked directly from `SKILL.md`, with when to read it: "Before writing an EF query, read `references/ef.md`." A reference file never links to another one. A reference file over 100 lines starts with a table of contents.
- Code examples are **always generic** (`Order`, `Customer`, `Invoice`…): never taken from or inspired by a project's code, with no real class, table, field or business rule name. This holds **even when the rule comes from code just corrected in a project**, and even when the user offers that code as the example.
- The form of a rule follows the failure it prevents:
  - style rule: a ✅ example and one line on why it matters;
  - discipline rule (git, process steps the agent skips under pressure): a table of excuses and a list of red flags, both taken from test observations, never imagined.
- No `paths` field in the frontmatter: it would stop the skill from loading outside matching files.

## References to other skills

- A skill may name its own sub-skills, and a method it is built on (such as superpowers:writing-skills).
- A skill never names another personal skill: not to delegate a step, not to require loading it, not as an example. It proposes the action to the user instead ("Propose to commit the changes"), and the user's answer triggers the other skill through its own description.
- A skill that needs rules carried by another: widen the other skill's description so it also triggers in that case, rather than copying its rules.

## Tests

No change ships untested, whatever its size or the time pressure.

| Change | Test |
|--------|------|
| Creation or rewrite | Three realistic scenarios, each run by a fresh subagent without the skill, then with it. Run them on the model that will use the skill, and on Sonnet. |
| One rule added or changed | Micro-test: a scenario that tempts the violation, run a few times with the skill before the change, then after. |
| Several skills rewritten | `/skill-doctor` before and after, to compare context cost and triggering. |

- Run the "without" runs before writing the skill or the change.
- For the "without" run, turn the skill off (`skillOverrides: "off"`) or give the subagent the previous version explicitly.
- Subagents work on a copy of the repo outside it, never on the repo itself. Test outputs stay outside the repo.
- Report a test that did not run as not run. Never present it as passed.

| Excuse | Reality |
|--------|---------|
| "The user is in a hurry and said no complex tests" | A micro-test takes a few minutes. Run it and say so. |
| "It's a small change" | Size does not change the rule. Small rules are the ones that go unnoticed. |
| "The rule is obvious, it will work" | A rule nobody watched an agent break may teach nothing. |
| "I'll ask the user whether to run the test" | The test is not optional. Run it, then report. |

## Red flags — stop

- About to write an example with a name from the user's project.
- About to finish without having run a test.
- About to write "follow the X skill" for another personal skill.
