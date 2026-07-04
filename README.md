# Spatial Computing 7-Day Camp

Apple Developer Academy 학습자를 위한 7일짜리 spatial computing 학습 Skill 시리즈입니다. `tutor-skills`, `ai-native-camp/camp-1`(day1-onboarding, day2-... 구조)에서 영감을 받아 만들었습니다.

## 구성

| Day | 명령어 | 주제 |
|---|---|---|
| 1 | `/day1-spatial-intro` | Spatial Computing 개론 (ARKit/RealityKit/visionOS 관계 지도) |
| 2 | `/day2-arkit-basics` | ARKit 기초 (세션, 평면 감지, 앵커, 레이캐스트) |
| 3 | `/day3-arkit-advanced` | ARKit 심화 (People Occlusion, Face/Body Tracking, Scene Geometry) |
| 4 | `/day4-realitykit-basics` | RealityKit 기초 (ECS, Entity/Component, 머티리얼) |
| 5 | `/day5-realitykit-advanced` | RealityKit 심화 (파티클, 애니메이션, CoreHaptics) |
| 6 | `/day6-interaction-gesture` | 상호작용/제스처 (RealityKit 제스처, 충돌·물리, visionOS 인터랙션 모델) |
| 7 | `/day7-mini-project` | 미니 프로젝트 — 필수 체크리스트 + 주제 자유 캡스톤 |

## 설치

```bash
chmod +x install.sh
./install.sh
```

`~/.claude/skills/`(Claude Code)와, `~/.agents/`가 존재하면 `~/.agents/skills/`(Cursor 등)에도 각 day 폴더를 복사합니다.

## 사용법

Claude Code에서 순서대로 슬래시 명령을 입력하면 됩니다:

```
/day1-spatial-intro
```

완료되면 다음 날 명령어를 안내해줍니다. 각 스킬은 실행 위치에 `SpatialCampNotes/` 폴더를 만들어서:

- `dayN-주제.md` — 그날의 학습 노트 (개념 + 코드 예제 + 참고 자료)
- `00-dashboard.md` — 7일 진행 상황 대시보드

를 누적해서 기록합니다. Obsidian으로 이 폴더를 vault로 열면 tutor-skill 때처럼 시각적으로 볼 수 있습니다.

## 특징

- **공식 문서 기반**: 각 스킬은 노트를 쓰기 전에 Apple 공식 문서(`developer.apple.com`)를 실제로 검색·확인하도록 지시되어 있어, API가 바뀌어도 최신 정보를 반영하려고 시도합니다.
- **체크포인트 퀴즈**: 매일 끝에 2~3문제로 이해도를 점검합니다 (채점이 아니라 피드백 중심).
- **Day 7은 페어 프로그래밍 방식**: 정답 코드를 바로 주지 않고, 설계 질문을 던지며 함께 미니 프로젝트를 완성해갑니다.

## 커스터마이징

각 `skills/dayN-*/SKILL.md`를 직접 수정해서 팀 상황에 맞게 난이도, 주제, 퀴즈 문항을 조정할 수 있습니다.
