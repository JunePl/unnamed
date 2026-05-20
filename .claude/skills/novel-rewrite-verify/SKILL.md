---
name: novel-rewrite-verify
description: 独立的小说段落验证 skill。由 novel-rewrite 写完段落后强制调用。跑所有 feedback 检查并输出违规清单+修改建议。这是"写作的我"和"验证的我"分离机制——避免认知盲点。
allowed-tools: [Read, Bash, Grep]
---

# 小说段落独立验证流程

**Why：** 让"写作的我"和"验证的我"用不同的注意力分配——写作时关注剧情和语感，验证时纯客观跑规则检查。**这是 2026 神殿章 13 条反馈后的核心架构升级**。

**触发条件**：novel-rewrite Step 5 强制调用本 skill。

---

## 输入

待验证段落写到 `/tmp/check.txt`（或用户指定的临时文件路径）。

参数说明：
- 段落类型（必填）：探索观察 / 战斗 / 对话 / 感官冲击 / 内心独白 / 高密度信息
- 威胁级别（场景有危险时必填）：L0-L4
- 是否对话密集段（默认否）

---

## 完整验证流程（不可跳过任何检查）

### Layer 1：黑名单 grep（必须全 0 残留）

```bash
CHECK_FILE=/tmp/check.txt

echo "=== Layer 1.1：原始 AI 拐杖黑名单 ==="
for w in "跳到\|跳回\|跌到" "再切" "坚韧地" "终极于此" "一格一格" "剥到最里" \
         "挂歪" "扩大锁定" "唇形" "收了一收" "甜腻味$" \
         "这一线" "腰腹的力" "倒抽一" "借的是动静" "目光锁着" \
         "在闪$" "抠了一下" "这一秒变了" "稳稳地" \
         "脊背发凉" "后背发凉" "呼吸停了" "瞳孔一缩" "心跳漏了" \
         "愣在原地" "喉咙发紧" "投影仪" "肌肉记忆" "统计学" "立刻知道"; do
    c=$(grep -c "$w" $CHECK_FILE 2>/dev/null)
    [ "$c" != "0" ] && echo "▲ 残留: $w -> $c 次"
done

echo ""
echo "=== Layer 1.2：2026 新增 cliché 比喻黑名单 ==="
for w in "无形的手" "心被攥" "心脏一沉" "死一样的压力" "窒息的恐惧" \
         "心被狠狠揪" "脊背一阵发凉" "头皮发麻" \
         "浑身的血都凉" "后背瞬间湿透" "时间彷佛静止" \
         "周围的一切都消失" "思绪一片空白"; do
    c=$(grep -c "$w" $CHECK_FILE 2>/dev/null)
    [ "$c" != "0" ] && echo "▲ cliché 残留: $w -> $c 次"
done

echo ""
echo "=== Layer 1.3：凭空植入背景知识 ==="
grep -nE "按理说|按规矩|按常理|正常来说|按惯例|通常来说" $CHECK_FILE && echo "▲ 凭空植入"
grep -nE "按.{0,4}原则" $CHECK_FILE
grep -nE ".{1,3}都该有" $CHECK_FILE

echo ""
echo "=== Layer 1.4：抽象触感词+了一下 ==="
grep -nE "(烫|痛|麻|紧|酸|胀)了一下" $CHECK_FILE && echo "▲ 抽象触感未具体化"

echo ""
echo "=== Layer 1.5：单一类型名词独段 ==="
grep -nE "^是[一-龥]{1,3}。$" $CHECK_FILE && echo "▲ 单名词独段未带特征"

echo ""
echo "=== Layer 1.6：小学生对仗/格言句式 ==="
grep -nE "能.{1,8}的.{1,8}先.{1,8}，.{1,8}的.{1,8}更要" $CHECK_FILE && echo "▲ 小学生格言"
grep -nE "这是他在.{0,8}养出来的(本能|原则|习惯)" $CHECK_FILE && echo "▲ 显式标注本能"

echo ""
echo "=== Layer 1.7：伏笔几何明示 ==="
grep -nE "正对着|正好对着|的方向就是|指向.{0,4}(神像|那)" $CHECK_FILE && echo "▲ 几何明示伏笔"
```

### Layer 2：数量化指标

```bash
echo ""
echo "=== Layer 2：数量化指标 ==="
echo "字符数: $(wc -m < $CHECK_FILE)"
echo "破折号 ——: $(grep -o '——' $CHECK_FILE | wc -l)（限 ≤4 整段；200字内≤1；只能为戏剧节点）"
echo "不是X，是Y: $(grep -oE '不是[^，。]+，是' $CHECK_FILE | wc -l)（每段≤1）"
echo "X的那种/那样: $(grep -oE '.的那种|.的那样' $CHECK_FILE | wc -l)（必须 0）"
echo "省略号 ……: $(grep -o '……' $CHECK_FILE | wc -l)"
```

### Layer 3：短独段堆砌检测

```bash
echo ""
echo "=== Layer 3：连续 3+ 短叙述独段（≤36字 非对话非卡牌） ==="
awk 'NF == 0 { next }
{
  is_short = (length($0) <= 36 && !match($0, /^[""【]/))
  if (is_short) {
    chain++
    pos[chain] = NR ": [" length($0) "字] " substr($0, 1, 45)
    if (chain == 3) {
      print "▶▶ 连续 3+ 短独段:"
      for (i = 1; i <= 3; i++) print "   " pos[i]
    } else if (chain > 3) {
      print "   " pos[chain]
    }
  } else {
    chain = 0; delete pos
  }
}' $CHECK_FILE
```

### Layer 4：人工检查项（生成检查清单）

以下检查需要 verify skill 输出 **检查清单+实际段落片段**，请用户/写作 agent 逐项确认：

```
=== Layer 4.1：已知类型事物的"第一眼识别"过程 ===
- 段落里第一次出现的事物是否走了"形状→联想→命名"过程？
- 是否有直接命名（"一尊女神像立在身后"）？
- grep 提示：
  grep -nE "一(座|尊|个|条|只).{1,5}(神像|怪物|建筑|门|桌|椅|窗)" $CHECK_FILE

=== Layer 4.2：反应强度匹配威胁级别 ===
- 威胁级别 L3/L4 场景下，反应是否是"僵硬冻结"级？
- 是否出现"胃里翻""喘不过气"这种 L2 级反应配 L3+ 场景？

=== Layer 4.3：行为与感知逻辑一致性 ===
- "X 不敢/不能 Y" + 紧接"Z 是 W"（描述 Y 应该看不到的东西）= 矛盾
- 例：神像脸不敢看，却写"眼睛太多"——怎么数的？

=== Layer 4.4：物理逻辑自洽 ===
- 任何超凡现象/异常感官：物理上能成立吗？
- 单个/小物件能"有方向地"做事吗？
- 例：单个印记"亮的位置正对着..."——单个印记是整体亮还是有方向亮？

=== Layer 4.5：角色智识水平校准 ===
- 阿尔温的内心独白是顶级分析师该说的话吗？
- 还是小学生作文范本/执法局新人手册？
- 检查"原则/本能"句式：grep -nE "这是他在.{0,8}养出来的" $CHECK_FILE

=== Layer 4.6：场景一致性 ===
- 描写元素是否在该场景的"真实属性"里？
- 例：神殿写"灰未沉"——神殿哪来的灰？是不是把犯罪现场描写硬塞过来？

=== Layer 4.7：前文术语严格继承 ===
- 用户已发布正文中已用的术语，本段是否换说法了？
- grep 用户已发布正文找对应术语：
  grep -n "<本段用的术语>" /root/Pi/unnamed/正文/正文.novel
- 例：用户写"灵纹"，本段用"蛛印"——错！

=== Layer 4.8：节奏蓝图执行度检查 ===
- Step 2.5 的节奏蓝图说"中长句连缀"，本段实际节奏是否符合？
- 节奏蓝图说"威胁级别 L3"，本段反应强度是否匹配？
- 节奏蓝图的"参考锚点"，本段是否真的对照该参考写？
```

### Layer 5：参考贴合度抽查

```bash
echo ""
echo "=== Layer 5：参考贴合度抽查 ==="
echo "请人工选 3-5 个本段最不寻常的动词/形容词/名词，对每个跑："
echo ""
REF="/root/Pi/unnamed/Project/Reference/术师手册_utf8.txt \
     /root/Pi/unnamed/Project/Reference/一世之尊_utf8.txt \
     /root/Pi/unnamed/Project/Reference/文风参考.md \
     /root/Pi/unnamed/正文/正文.novel"
echo "REF=\"$REF\""
echo "for w in <词1> <词2> <词3>; do"
echo "    c=\$(grep -h \"\$w\" \$REF 2>/dev/null | wc -l)"
echo "    echo \"\$w: \$c 次\""
echo "    [ \"\$c\" = \"0\" ] && echo \"▲ 自造词: \$w\""
echo "done"
```

---

## 输出格式

```markdown
# 验证报告

## ✅ 通过项
- 黑名单：0 残留
- 破折号：N（合规）
- ...

## ⚠️ 警告项
- Layer X.Y: <具体问题>
- ...

## ❌ 必须修复项
- Layer X.Y: <具体问题> —— 建议改成 <具体方向>
- ...

## 修改建议
1. ...
2. ...
```

---

## 调用方式

```
Skill: novel-rewrite-verify
段落类型: 探索观察 + 致命压感
威胁级别: L3
段落路径: /tmp/check.txt
```

或者由 novel-rewrite Step 5 自动调用。

---

## 红线

1. ❌ 跳过任何 Layer 的检查
2. ❌ "我看了一遍没问题"——必须跑实际命令
3. ❌ 验证完不输出"违规清单+修改建议"
4. ❌ 不报告 Layer 4 人工检查项（即使无 grep 命中也必须列出来让用户确认）

---

## 协同关系

- `novel-rewrite` — 本 skill 由 novel-rewrite Step 5 强制调用
- 所有 `feedback_*.md` — 本 skill 实现这些 feedback 的自动化检查
- `MEMORY.md` — 本 skill 跑完后建议读 MEMORY 找针对性建议
