# Agent Skills Catalog

A portable collection of focused Agent Skills for coding agents. Every skill is self-contained in `skills/<name>/` and starts with a standard `SKILL.md` manifest.

Use this catalog to install a small, intentional set of reusable workflows rather than a tool-specific plugin bundle.

## Quick start

Clone the catalog and install all skills into a target skills directory:

```sh
git clone https://github.com/joaoajmatos/skills.git agent-skills
cd agent-skills
./skills/install-agent-skills/scripts/install-catalog.sh --dest <target-skills-dir> --all
```

For a personal Codex catalog, use:

```sh
./skills/install-agent-skills/scripts/install-catalog.sh \
  --dest "${CODEX_HOME:-$HOME/.codex}/skills" \
  --all
```

For a project-local catalog, run the installer from the target project and use its existing skills location. If the project has no convention, use `.agents/skills/`:

```sh
/path/to/agent-skills/skills/install-agent-skills/scripts/install-catalog.sh \
  --dest .agents/skills \
  code-review research
```

The installer copies skills, validates that each source has a `SKILL.md`, and never replaces an existing target directory. Start a new agent session afterward if your coding agent discovers skills only at startup.

## Choose skills

Install a small, task-relevant subset when possible:

```sh
./skills/install-agent-skills/scripts/install-catalog.sh \
  --dest <target-skills-dir> \
  code-review research principle-fix-root-causes
```

`install-agent-skills` is itself a skill, so an agent can guide subsequent installs once it is available. See [ADAPTERS.md](ADAPTERS.md) for the portable skill contract and conventions for project-local skills.

## Catalog

| Area | Skills |
| --- | --- |
| Catalog management | `install-agent-skills` |
| Agent communication | `bro`, `in-your-own-words`, `ketchup`, `sharpen`, `teach` |
| Engineering discipline | `correct`, `principle-attack-the-premise`, `principle-exhaust-the-design-space`, `principle-experience-first`, `principle-fix-root-causes`, `reflect` |
| Verification | `create-verification-skill`, `maintain-verification-skill` |
| Architecture and research | `codebase-design`, `domain-modeling`, `improve-codebase-architecture`, `research`, `code-review` |
| Collaboration | `grilling`, `handoff` |
| UI and design | `ui-ux-pro-max`, `impeccable` |

## Portability

The repository distributes skills, not agent-specific plugins. A portable skill directory contains `SKILL.md` plus only the files it references. Agent-specific discovery paths and wrappers belong outside `skills/`.

For project-local skills, prefer the project's established convention. The neutral fallback is:

```text
.agents/skills/<skill-name>/
```

## Safety and updates

Review a skill before installing it, especially when it includes executable scripts or can access external services. The installer only copies files; it does not execute installed skill scripts.

To update a skill, re-import it into the same `skills/<name>/` directory, review the diff, and test any bundled scripts. Preserve documented compatibility adaptations when updating upstream sources.

## Provenance and licensing

Imported skills retain their upstream content and licensing. This catalog documents source provenance but does not replace the upstream license text or notices.

| Source | Imported skills | License |
| --- | --- | --- |
| [cursor/plugins](https://github.com/cursor/plugins/tree/main/harness/pstack/claude-code/skills) | `bro`, `correct`, `ketchup`, `reflect`, `sharpen`, verification skills, and four principles | MIT |
| [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills) | architecture, research, review, and collaboration skills | MIT |
| [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill/tree/main/.claude/skills/ui-ux-pro-max) | `ui-ux-pro-max` | MIT |
| [pbakaus/impeccable](https://github.com/pbakaus/impeccable/tree/main/.agents/skills/impeccable) | `impeccable` | Apache-2.0 |

`create-verification-skill` and `maintain-verification-skill` are adapted only to replace Cursor- and Claude-specific paths with the generic `<project-skills-dir>` convention. Refer to upstream repositories for complete license terms and notices.
