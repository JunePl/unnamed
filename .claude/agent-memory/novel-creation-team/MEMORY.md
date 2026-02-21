# Novel Creation Team Memory

## Project: Unnamed Fantasy/Mystery Novel (奥里斯塔尼世界)

### Key File Locations & Sizes (Updated 2026-02-20)
- WorldBible/世界通鉴.md: 5481 lines, V0.5
- Characters/人设集.md: 1383 lines, V1.0
- Outline/小说节奏规划.md: 2469 lines, **V3.1** (Ch1-7 synced with 第一卷V5.1)
- Outline/商业安全线报告.md: ~350 lines, **V2.0** (rewritten 2026-02-20, Phase 2)
- Cases/案件与伏笔集.md: 1354 lines, **V3.0** (rewritten 2026-02-20, Phase 1)
- Cases/误导路径成本表.md: ~500 lines, **V2.0** (rewritten 2026-02-20, Phase 1)
- Volumes/第一卷.md: **~8279 lines, V5.1** (Ch1-7 realigned to Mian.novel, Ch8-101 unchanged)
- 正文/Mian.novel: ~449 lines (early draft, ABSOLUTE BASELINE for Ch1-4)
- CHANGELOG.md: **V1.9** (current)
- Logs/Phase4_同步验证报告.md: V1.0
- README.md: **V2.0** (rewritten 2026-02-20)

### V3.0 Architecture (2026-02-20 Restructure)
- **Four parallel lines** replacing three sequential cases:
  - Line A: Painter's Death (surface mystery, Ch1-全卷)
  - Line B: Political Undercurrent (Antonio as living character Ch8-38, death at Ch35-38)
  - Line C: Otherside/Abyss (new, 4-phase exploration arc)
  - Line D: Blood Moon (Agnes 5 fragments + indirect clues)
- **Four-act structure**: Cracks(Ch1-26) -> Chess(Ch27-50) -> Abyss(Ch51-75) -> Convergence(Ch76-101)
- Allen mutation + Alwin awakening moved to Ch6-7 (was Ch21)
- Substitute reveal moved to Ch17-20 (was Ch26)
- Leoric entrance preserved at Ch82-84
- Agnes moonlight mask at Ch101
- 44 foreshadowing items (17 in-volume, 27 cross-volume) -- ALL VERIFIED 100% COVERED
- 19 misdirection paths (was 8), including 4 cross-line paths
- All freeze markers removed

### V5.1 Alignment Fix (正文与细纲对齐修复)
- **Core principle**: Mian.novel is ABSOLUTE BASELINE; blueprints must conform to novel text
- V5.0 Ch1 (3 scenes, ~7500w) split into V5.1 Ch1 (gallery+bar, ~3800w) + Ch2 (sibling talk, ~3700w)
- V5.0 Ch2 -> V5.1 Ch3 "丝来线去", V5.0 Ch3 -> V5.1 Ch4 "三条线"
- V5.0 Ch4 "灵痕不说谎" tea reasoning absorbed into V5.1 Ch5 opening (~800w breathing segment)
- Ch5-7 preserved as mini-climax (pressure+detonation+awakening)
- Ch8+ numbering identical to V5.0, no cascade
- Decision R-10: Novel chapter splits take priority over blueprint merging
- Decision R-11: Tea reasoning absorbed into Ch5, not standalone chapter (preserves 7-chapter constraint)
- Fragment 1 repositioned to Ch3 end (was V5.0 Ch2 scene 3)
- PA01 at L370, PA02 at L377 -- verified against novel text
- Scene marking system: 【正文已实现】vs【待写】on every scene/content block
- 节奏规划V3.1 Ch1-7 beats fully synced with 第一卷V5.1

### Phase 3 Completion Details (Chapter Blueprints V5.0->V5.1)
- 第一卷.md V5.1: ALL 101 chapters complete (Ch1-7 realigned, Ch8-101 from V5.0)
- Act 1 (Ch1-26): Ch1-4 golden templates rewritten to match Mian.novel, Ch5-7 adjusted, Ch8-26 from V5.0
- Act 2 (Ch27-51): Antonio arc, 彼界 mid-layer, fragment four, Leoric letters
- Act 3 (Ch52-75): NEW - golden templates for Ch52-53, Ch55, Ch62, Ch67, Ch73
- Act 4 (Ch76-101): NEW - golden templates for Ch76-77, Ch79-82, Ch91, Ch99, Ch101
- Comprehensive verification report appended (577 lines)
- Character checks: Agnes 92/100, Antonio 96/100, Leoric 98/100, Isolde 94/100
- 4 non-blocking suggestions (S-01 through S-04) for future iteration

### Critical Unresolved Conflicts (as of 2026-02-18)
1. **Dmitri spirit type**: 织命·人脉型 (persona/cases) vs 噬暗·亡灵型 (world bible ch8) - F-01 fixed Adrian but Dmitri may still conflict
2. **Kassarin politics**: 三执政制 (cases/chapters) vs 三顾问制 (world bible ch8)
3. **Goblins in 正文**: No non-human races in world bible
4. **正文 is DRAFT ONLY**: Skips Ch1-2, tone mismatch, wrong terminology

### World Bible Structure Notes
- Part 1-7: Core systems (spirit contracts, tiers, combat, collapse, etc.) - generally consistent
- Part 3: 天秤 rankings - CANONICAL reference for character rankings
- Part 8+: National details - OLDER VERSION, has conflicts with Part 3 rankings
- The 柱位百杰 table (Line ~2953-2961) should be treated as ground truth for character rankings
- F-01 through F-04 fixes applied in V1.4 (2026-02-18): crown table rewrite, Adrian/Vera spirit type unified, dual calendar system

### Frozen Items (Updated 2026-02-20)
- World bible Part 8 (Kassarin details) - still frozen pending conflict resolution
- All 正文 writing - frozen
- Non-human race decisions - frozen

### What Works Well
- Four-line parallel architecture creates natural cross-line misdirection opportunities
- Antonio as living character (30 chapters) massively increases emotional impact
- ABC1 misdirection (D=Dmitri) is the series' biggest investment/payoff
- Agnes five-fragment system ensures second-read satisfaction
- Writing large files in sections via Bash heredoc avoids token limit issues
- Per-chapter beat descriptions prevent vague/empty chapters
- Comprehensive verification reports catch edge cases early

### Key Architectural Decisions
- 5 volumes, 100 chapters each, ~25万字 per volume
- D-mode as through-line mystery connecting all four lines
- D is a "system" not a person (revealed gradually, Line C Ch62 first hint)
- Agnes (阿涅丝) dark line: 5 fragments across volume + Ch101 mask reveal
- Leoric (莱奥里克) appears via 5 letters then enters at Ch82-84
- Gray endings (Antonio's death) as deliberate design choice
- Misdirection path conversion rate: 100% (all paths serve truth revelation)

### ALL Restructure Phases COMPLETE
- [DONE] Phase 1: 案件与伏笔集.md V3.0 + 误导路径成本表.md V2.0
- [DONE] Phase 2: 小说节奏规划.md V3.0 + 商业安全线报告.md V2.0
- [DONE] Phase 3: 第一卷.md V5.0 (Ch1-101 complete + verification reports)
- [DONE] Phase 4: 全面同步验证 (Logs/Phase4_同步验证报告.md V1.0)
- [DONE] Phase 5: 正文与细纲对齐修复 (第一卷V5.1 + 节奏规划V3.1 + CHANGELOG V1.9)

### Phase 4 Key Findings (2026-02-20)
- **44/44 foreshadowing items verified** (100% coverage)
- **Act2 Ch36-50 desynchronized** between 节奏规划V3.0 and 第一卷V5.0 (titles/content rearranged)
  - 第一卷V5.0 is the EXECUTION STANDARD for writing
  - 节奏规划V3.0 Act2 needs update in future iteration [A-01]
- PB08 (德米特里举杯): Ch40 in cases file, Ch48 in 第一卷 -- annotation added
- 商业安全线报告V2.0 already follows 第一卷V5.0 structure (correct)
- OOC checks all pass: Agnes 92, Antonio 96, Leoric 98, Isolde 94
- D-line four-thread progression verified complete
- World bible consistency OK (frozen items excepted)

### Pending Work (Future Sessions)
- Resolve world bible Part 8 conflicts (Kassarin politics, Dmitri spirit type)
- Non-human race decision
- 正文 rewrite/continuation to match V5.1 chapter blueprints (Ch5+ all 待写)
- Volume 2-5 detailed chapter blueprints (currently only key beats defined)
- [A-01] 节奏规划V3.1 Act2(Ch36-50) still desynchronized with 第一卷V5.1 (Ch1-7 part fixed)

### Lessons Learned
- Large documents (1000+ lines) must be written in sections to avoid token limits
- Read files in sections (offset/limit) when >25000 tokens (256KB limit)
- Always verify line counts with wc -l before and after edits
- Use Bash heredoc (cat >>) to append large sections rather than Edit tool
- Files exceeding 280KB cannot be fully read by Read tool -- use Bash tail/grep instead
- Foreshadowing codes may differ between V3.0 (PD01-PD11) and earlier act blueprints (descriptive names) -- verify by description not just code
- Verification reports should check both code-based and description-based references
- When splitting chapters, always verify total count constraint (e.g., "7-chapter mini-climax") before adding new chapters
- Absorbing content into existing chapters (e.g., tea reasoning into Ch5 opening) avoids numbering cascades
- V5.1 Ch2 header says "L115-L288" (includes transition), V3.1 says "L131-L288" (content start) -- both correct, not a conflict
