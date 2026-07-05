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

각 Day는 항상 아래 순서로 진행됩니다:

1. **공식 문서 확인** — Apple 공식 문서를 실제로 검색·확인 후 최신 API 기준으로 코드를 준비합니다 (조용히 먼저 수행).
2. **[개념 → 퀴즈 → 프로젝트 코드로 확인]을 개념별로 반복** — 핵심 개념을 하나씩 순서대로 설명하고, 그 개념에 대응하는 퀴즈 1문항을 `AskUserQuestion`으로 바로 진행한 뒤(방향키/클릭으로 선택, 채점이 아니라 피드백 중심), **그 개념에 해당하는 코드만** 실제 iOS 앱 프로젝트(`SpatialCampApp/`, Day 2부터)에 반영해서 `xcodebuild`로 컴파일까지 확인하고 다음 개념으로 넘어갑니다. 모든 개념을 다 설명한 뒤 퀴즈나 코드를 몰아서 하지 않고, 완전 초보자도 따라올 수 있게 비유를 곁들여 설명합니다.
3. **코드는 항상 예고 후 작게 작성** — 프로젝트 파일을 만들거나 고치기 전에는 "지금부터 무엇을, 왜 작성할지"를 먼저 한두 문장으로 말하고, 여러 파일/큰 코드 블록을 한 번에 다 만들어버리지 않고 작은 단위로 나눠서 하나씩 작성 → 빌드 확인 → 다음 단위로 진행합니다.
4. **다음 Day로 자동 진행** — 모든 개념이 끝나면 "다음" 또는 "완료"라고 입력하기만 하면, 슬래시 명령을 다시 칠 필요 없이 다음 Day 스킬이 자동으로 이어집니다.

노트 파일이나 진행 대시보드 파일은 따로 만들지 않습니다 — 모든 설명, 코드, 퀴즈 피드백은 대화창에서만 진행됩니다 (실제 iOS 프로젝트 코드 파일은 예외).

## 실제 Xcode 프로젝트 (`SpatialCampApp/`)

Day 2부터는 작업 폴더에 `SpatialCampApp/`이라는 실제 iOS 앱 프로젝트가 생성되고, 7일에 걸쳐 하나의 앱으로 계속 발전합니다 ([xcodegen](https://github.com/yonaskolb/XcodeGen) 기반 — `project.yml` + `Sources/SpatialCampApp/*.swift`).

- **Day 2**: `ARSession` + 평면 감지 + `raycast` 탭-투-플레이스 박스 배치 (베이스 앱).
- **Day 3**: People Occlusion / Scene Reconstruction 설정 추가.
- **Day 4**: 배치되는 오브젝트를 `PhysicallyBasedMaterial`로 업그레이드.
- **Day 5**: 파티클(`ParticleEmitterComponent`) + CoreHaptics 진동 추가.
- **Day 6**: 배치한 오브젝트에 드래그/회전/스케일 제스처와 충돌 이벤트 추가.
- **Day 7**: 캡스톤 — 사용자가 고른 주제로 위 기능들을 조합/확장.

매 Day마다 코드를 수정한 뒤 `xcodebuild -project SpatialCampApp.xcodeproj -scheme SpatialCampApp -destination 'generic/platform=iOS Simulator' build`로 컴파일을 검증합니다. 단, ARKit 카메라 트래킹·햅틱·제스처 등 실제 동작은 시뮬레이터가 지원하지 않으므로, **실기(아이폰/아이패드)를 Xcode에 연결해 직접 빌드·실행**해야 확인할 수 있습니다.

앱 화면 상단에는 `ARStatusModel` 기반 상태 배너가 떠서 "지금 뭘 하면 되는지 / 방금 뭐가 됐는지"를 실시간으로 보여줍니다 (예: "평면 감지됨! 화면을 탭해서 배치해보세요" → "배치 완료!"). 콘솔 로그를 따로 열어보지 않아도 화면만 보고 테스트할 수 있습니다.

## 특징

- **공식 문서 기반**: 각 스킬은 코드를 쓰기 전에 Apple 공식 문서(`developer.apple.com`)를 실제로 검색·확인하도록 지시되어 있어, API가 바뀌어도 최신 정보를 반영하려고 시도합니다.
- **실제로 동작하는 코드**: 코드 스니펫을 보여주기만 하지 않고, 하나의 앱 프로젝트에 직접 작성하며 매번 빌드로 검증합니다.
- **화면으로 확인하는 테스트**: 콘솔 로그 대신 앱 화면 상단 상태 배너로 "지금 뭘 하면 되는지"를 바로 보여줍니다.
- **객관식 체크포인트 퀴즈**: 매일 끝에 `AskUserQuestion`으로 4지선다 3문제를 한 문제씩 진행합니다 (채점이 아니라 피드백 중심, 방향키/클릭 선택).
- **끊김 없는 진행**: 퀴즈 후 "다음"/"완료"라고 답하면 다음 Day 스킬이 자동으로 이어집니다.
- **Day 7은 페어 프로그래밍 방식**: 정답 코드를 바로 주지 않고, 설계 질문을 던지며 함께 미니 프로젝트를 완성해갑니다.

## 커스터마이징

각 `skills/dayN-*/SKILL.md`를 직접 수정해서 팀 상황에 맞게 난이도, 주제, 퀴즈 문항, 프로젝트 코드를 조정할 수 있습니다.
