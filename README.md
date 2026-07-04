# Spatial Computing 7-Day Camp

Apple Developer Academy 학습자를 위한 7일짜리 spatial computing 학습 Skill 시리즈입니다. `tutor-skills`, `ai-native-camp/camp-1`(day1-onboarding, day2-... 구조)에서 영감을 받아 만들었습니다.

## 구성

| Day | 명령어 | 주제 |
|---|---|---|
| 1 | `/day1-spatial-intro` | Spatial Computing 개론 (ARKit/RealityKit/visionOS 관계 지도 + 코드 미리보기) |
| 2 | `/day2-arkit-basics` | ARKit 기초 (세션, 평면 감지, 앵커, 레이캐스트) — 실제 Xcode 프로젝트 시작 |
| 3 | `/day3-arkit-advanced` | ARKit 심화 (People Occlusion, Face/Body Tracking, Scene Geometry) |
| 4 | `/day4-realitykit-basics` | RealityKit 기초 (ECS, Entity/Component, PBR 머티리얼) |
| 5 | `/day5-realitykit-advanced` | RealityKit 심화 (파티클, CoreHaptics) |
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

각 Day는 아래 순서로 진행됩니다:

1. **공식 문서 확인** — Apple 공식 문서를 실제로 검색·확인 후 최신 API 기준으로 코드를 작성합니다.
2. **코드 작성** — Day 2부터는 코드를 대화창에만 보여주지 않고, 작업 폴더의 실제 iOS 앱 프로젝트(`SpatialCampApp/`)에 직접 작성/수정하고 `xcodebuild`로 컴파일까지 검증합니다.
3. **체크포인트 퀴즈** — 객관식 4지선다 3문제를 `AskUserQuestion` 도구로 한 문제씩 진행합니다 (방향키/클릭으로 선택, 채점이 아니라 피드백 중심).
4. **다음 Day로 자동 진행** — 퀴즈가 끝나면 "다음" 또는 "완료"라고 입력하기만 하면, 슬래시 명령을 다시 칠 필요 없이 다음 Day 스킬이 자동으로 이어집니다.

완료되면 다음 날 명령어를 안내해줍니다. 각 스킬은 실행 위치에 `SpatialCampNotes/` 폴더를 만들어서:

- `dayN-주제.md` — 그날의 학습 노트 (개념 + 코드 스니펫 + 참고 자료)
- `00-dashboard.md` — 7일 진행 상황 대시보드

를 누적해서 기록합니다. Obsidian으로 이 폴더를 vault로 열면 tutor-skill 때처럼 시각적으로 볼 수 있습니다.

## 실제 Xcode 프로젝트 (`SpatialCampApp/`)

Day 2부터는 작업 폴더에 `SpatialCampApp/`이라는 실제 iOS 앱 프로젝트가 생성되고, 7일에 걸쳐 하나의 앱으로 계속 발전합니다 ([xcodegen](https://github.com/yonaskolb/XcodeGen) 기반 — `project.yml` + `Sources/SpatialCampApp/*.swift`).

- **Day 2**: `ARSession` + 평면 감지 + `raycast` 탭-투-플레이스 박스 배치 (베이스 앱).
- **Day 3**: People Occlusion / Scene Reconstruction 설정 추가.
- **Day 4**: 배치되는 오브젝트를 `PhysicallyBasedMaterial`로 업그레이드.
- **Day 5**: 파티클(`ParticleEmitterComponent`) + CoreHaptics 진동 추가.
- **Day 6**: 배치한 오브젝트에 드래그/회전/스케일 제스처와 충돌 이벤트 추가.
- **Day 7**: 캡스톤 — 사용자가 고른 주제로 위 기능들을 조합/확장.

매 Day마다 코드를 수정한 뒤 `xcodebuild -project SpatialCampApp.xcodeproj -scheme SpatialCampApp -destination 'generic/platform=iOS Simulator' build`로 컴파일을 검증합니다. 단, ARKit 카메라 트래킹·햅틱·제스처 등 실제 동작은 시뮬레이터가 지원하지 않으므로, **실기(아이폰/아이패드)를 Xcode에 연결해 직접 빌드·실행**해야 확인할 수 있습니다.

## 특징

- **공식 문서 기반**: 각 스킬은 코드를 쓰기 전에 Apple 공식 문서(`developer.apple.com`)를 실제로 검색·확인하도록 지시되어 있어, API가 바뀌어도 최신 정보를 반영하려고 시도합니다.
- **실제로 동작하는 코드**: 코드 스니펫을 보여주기만 하지 않고, 하나의 앱 프로젝트에 직접 작성하며 매번 빌드로 검증합니다.
- **객관식 체크포인트 퀴즈**: 매일 끝에 `AskUserQuestion`으로 4지선다 3문제를 한 문제씩 진행합니다 (채점이 아니라 피드백 중심, 방향키/클릭 선택).
- **끊김 없는 진행**: 퀴즈 후 "다음"/"완료"라고 답하면 다음 Day 스킬이 자동으로 이어집니다.
- **Day 7은 페어 프로그래밍 방식**: 정답 코드를 바로 주지 않고, 설계 질문을 던지며 함께 미니 프로젝트를 완성해갑니다.

## 커스터마이징

각 `skills/dayN-*/SKILL.md`를 직접 수정해서 팀 상황에 맞게 난이도, 주제, 퀴즈 문항, 프로젝트 코드를 조정할 수 있습니다.
