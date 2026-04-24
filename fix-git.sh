#!/bin/bash
# 自动修复 git 仓库损坏的脚本
# 策略：先尝试删除空对象+fetch，失败则重新 clone（保留工作区文件）

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

# 检查是否是 git 仓库
if [ ! -d ".git" ]; then
    echo "错误：当前目录不是 git 仓库"
    exit 1
fi

# 获取远程地址
REMOTE_URL=$(git remote get-url origin 2>/dev/null || true)
if [ -z "$REMOTE_URL" ]; then
    echo "错误：没有找到 origin 远程仓库"
    exit 1
fi

# 检查是否有损坏：用 fsck 输出判断
# 不能用 --quick（旧版 git 不支持，配合 set -e + grep 会被误判为"正常"）
FSCK_OUT=$(git fsck --no-dangling 2>&1 || true)
if echo "$FSCK_OUT" | grep -qE "error:|fatal:|corrupt|missing|invalid"; then
    echo "检测到 git 仓库损坏，开始修复..."
else
    echo "git 仓库正常，无需修复"
    exit 0
fi

# === 方案1：删除空对象 + fetch ===
echo ""
echo "=== 尝试方案1：删除空对象 + fetch ==="

EMPTY_FILES=$(find .git/objects -type f -empty 2>/dev/null || true)
if [ -n "$EMPTY_FILES" ]; then
    echo "找到以下空对象文件，删除中..."
    echo "$EMPTY_FILES"
    echo "$EMPTY_FILES" | xargs rm -f
fi

if git fetch origin 2>/dev/null && git reset --mixed origin/main 2>/dev/null; then
    echo ""
    echo "方案1修复成功！"
    git status --short
    exit 0
fi

echo "方案1失败，转到方案2..."

# === 方案2：重新 clone（保留工作区） ===
echo ""
echo "=== 尝试方案2：重新 clone ==="

TMPDIR=$(mktemp -d)
echo "克隆远程仓库到临时目录..."

if ! git clone "$REMOTE_URL" "$TMPDIR/repo" 2>/dev/null; then
    echo "错误：无法从远程克隆，请检查网络或远程仓库地址"
    rm -rf "$TMPDIR"
    exit 1
fi

echo "替换 .git 目录..."
rm -rf .git
mv "$TMPDIR/repo/.git" .git
rm -rf "$TMPDIR"

git reset --mixed HEAD

echo ""
echo "方案2修复成功！"
git status --short
