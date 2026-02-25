# SDE-Team Memory

## Project: Unnamed Fantasy/Mystery Novel (奥里斯塔尼世界)

### Agent Architecture (Updated 2026-02-24)
- `novel-creation-team.md`: ~1145 lines (was 1041), G/D roles strengthened
- `chapter-blueprint-engineer.md`: 236 lines, references updated to match renamed roles
- Genre Adaptation Layer with conditional modules (`[条件模块:mystery/romance/fantasy/...]`)
- Static reference data externalized to `/Project/Reference/` (3 files)
- Cases/ directory name preserved for backward compatibility (Decision R-14)
- **WorldBible Health Index** (`世界通鉴·健康索引.md`): dashboard for all roles, mandatory pre-work read
- G role now has: authority chain, 7-type consistency checklist, 5-step audit protocol, version management
- D role now has: pre-validation read protocol, enhanced verification output with WorldBible citations
- Pre-work protocol: step 2 = read health index; new role-based reading path table for all 8 roles
- UPDATE workflow: step 4.5 = WorldBible consistency check; dependency graph includes health index

### Key Patterns
- Large agent files (>25000 tokens) cannot be read in one call — use offset/limit
- CHANGELOG.md entries must be prepended (newest first)
- Always use `alway use novel-creation-team agent for this project` per CLAUDE.md
- The project uses Chinese language for all documentation and agent files

### File Structure
- Agent definitions: `.claude/agents/`
- Agent memory: `.claude/agent-memory/{agent-name}/`
- Project files: `Project/` (WorldBible/, Characters/, Outline/, Cases/, Volumes/, Styles/, Rhythm/, Logs/, Reference/)
- Novel text: `正文/Mian.novel`
