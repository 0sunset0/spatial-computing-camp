#!/bin/bash
# Spatial Computing 7-Day Camp — 설치 스크립트
# 각 day 스킬 폴더를 Claude Code(및 Cursor 등 호환 에이전트)의 스킬 디렉토리로 복사합니다.

set -e

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills"

# Claude Code 기본 위치
TARGET_CLAUDE="$HOME/.claude/skills"
# npx skills / Cursor 등 다수 에이전트가 공유하는 위치 (환경에 따라 존재하지 않을 수 있음)
TARGET_AGENTS="$HOME/.agents/skills"

install_to() {
  local target_dir="$1"
  mkdir -p "$target_dir"
  for skill in "$SOURCE_DIR"/*/; do
    skill_name="$(basename "$skill")"
    cp -r "$skill" "$target_dir/$skill_name"
    echo "  ✓ $skill_name → $target_dir"
  done
}

echo "Spatial Computing 7-Day Camp 스킬 설치 중..."
echo ""
echo "[Claude Code]"
install_to "$TARGET_CLAUDE"

if [ -d "$HOME/.agents" ]; then
  echo ""
  echo "[Cursor / 기타 에이전트]"
  install_to "$TARGET_AGENTS"
fi

echo ""
echo "설치 완료! Claude Code(또는 지원 에이전트)를 실행한 뒤 아래 순서로 진행하세요:"
echo ""
echo "  /day1-spatial-intro"
echo "  /day2-arkit-basics"
echo "  /day3-arkit-advanced"
echo "  /day4-realitykit-basics"
echo "  /day5-realitykit-advanced"
echo "  /day6-interaction-gesture"
echo "  /day7-mini-project"
echo ""
echo "각 스킬은 노트 파일을 따로 만들지 않고, 대화창에서 개념→코드→퀴즈를 개념별로 반복하며 진행합니다."
