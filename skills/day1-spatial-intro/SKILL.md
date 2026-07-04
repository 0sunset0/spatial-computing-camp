---
name: day1-spatial-intro
description: Day 1 of the Spatial Computing 7-day camp. Teaches Apple's spatial computing concept map (ARKit, RealityKit, visionOS, and how they relate), platform comparison basics, and generates a Day 1 study note plus a mini checkpoint quiz. Trigger this whenever the user runs /day1-spatial-intro, says they're starting the spatial computing camp, or asks for an intro/overview lesson on Apple spatial computing, ARKit vs RealityKit vs visionOS, or "day 1" of an AR/spatial learning plan. Always use this skill instead of a generic explanation when the user is clearly following the 7-day camp curriculum (day1 → day7).
---

# Day 1 — Spatial Computing 개론

7일 커리큘럼의 첫째 날. 목표는 "Apple 생태계 안에서 spatial computing이 어떻게 조각나 있는지"에 대한 큰 그림을 잡아주는 것입니다. 코드보다 개념 지도가 우선입니다.

## 이 스킬이 트리거되면 할 일

1. **노트 폴더 확인/생성**: 현재 작업 폴더에 `SpatialCampNotes/`가 없으면 만드세요. 없다면 `SpatialCampNotes/00-dashboard.md`도 함께 생성합니다 (아래 대시보드 포맷 참고).
2. **공식 문서 확인 (필수, 건너뛰지 말 것)**: 노트를 쓰기 전에 `web_search`로 아래 "핵심 개념"에 나온 프레임워크/개념에 대한 Apple 공식 문서(`developer.apple.com/documentation/arkit`, `.../realitykit`, `.../visionos`)를 찾고, `web_fetch`로 실제 내용을 확인하세요. 학습 데이터 시점과 달라진 부분(새 API, deprecated된 개념, 새 플랫폼 지원 등)이 있으면 노트에 반영하고 사용자에게도 짚어주세요.
3. **Day 1 학습 노트 생성**: `SpatialCampNotes/day1-spatial-intro.md` 파일을 아래 "노트 구조"에 맞춰 작성합니다. 실제로 fetch한 공식 문서 URL을 "참고 자료" 섹션에 남기세요.
4. **본문에도 핵심 요약을 대화창에 출력**합니다 (파일만 만들고 끝내지 말 것 — 사용자가 바로 읽을 수 있어야 함).
5. **체크포인트 퀴즈**로 마무리합니다 (아래 "퀴즈" 섹션).
6. 마지막에 `/day2-arkit-basics`로 넘어가라고 안내합니다.

## 다룰 핵심 개념

- **Spatial computing이란?** 디지털 콘텐츠와 물리적 공간을 실시간으로 정합(align)시켜, 사용자가 3D 공간 안에서 콘텐츠와 상호작용하게 만드는 컴퓨팅 패러다임. AR/VR/MR을 포괄하는 상위 개념으로 설명할 것.
- **Apple 생태계 지도** (이 관계를 표/다이어그램으로 명확히 설명):
  - `ARKit` — 카메라/센서 기반 월드 트래킹, 평면 감지, 앵커, 씬 이해(Scene Geometry, People Occlusion 등)를 제공하는 **저수준 프레임워크**. iPhone/iPad에서 동작.
  - `RealityKit` — ARKit이 준 공간 정보 위에서 **3D 콘텐츠 렌더링/물리/애니메이션/파티클**을 담당하는 **고수준 렌더링·시뮬레이션 프레임워크**. ECS(Entity-Component-System) 구조.
  - `visionOS` — Apple Vision Pro의 OS. RealityKit + ARKit(공간 인식 API들)을 기반으로 완전한 공간 UI 앱을 만드는 플랫폼. `windows`, `volumes`, `spaces` 같은 visionOS 전용 UI 패러다임 존재.
  - `Reality Composer Pro` — RealityKit 씬(파티클, 머티리얼, 애니메이션)을 코드 없이 조립하는 저작 도구.
- **플랫폼 비교**: iOS AR(핸드폰 화면으로 보는 AR) vs visionOS(머리에 쓰고 몰입하는 공간 컴퓨팅)의 차이를 인터랙션 모델(터치 vs 시선+손짓) 중심으로 설명.
- **왜 두 프레임워크가 나뉘어 있는가**: "센서가 보는 것(ARKit)"과 "화면에 그리는 것(RealityKit)"의 관심사 분리라는 설계 철학을 강조.

## 노트 구조 (`day1-spatial-intro.md`)

```markdown
# Day 1: Spatial Computing 개론

## 오늘의 목표
(1~2문장)

## 개념 지도
(ARKit / RealityKit / visionOS / Reality Composer Pro 관계를 표 또는 인디언트 구조로)

## 핵심 정리
- 개념별 3줄 요약

## 오늘의 한 줄 정리
> (암기용 한 문장)

## 체크포인트 퀴즈
(아래 형식 그대로)

## 참고 자료
- (실제로 fetch한 Apple 공식 문서 URL들을 여기에 나열)

## 다음 단계
Day 2 — ARKit 기초로 이동: `/day2-arkit-basics`
```

## 퀴즈

Day 1 종료 시 3문제를 대화창에 출력하세요. 형식:

```
Q1. ARKit과 RealityKit의 역할 차이를 한 문장씩 설명해보세요.
Q2. visionOS와 iOS AR의 가장 큰 인터랙션 모델 차이는?
Q3. Reality Composer Pro는 어떤 역할을 하나요?
```

사용자가 답하면 채점하지 말고 **피드백 위주**로 반응하세요 (정답/오답 이분법이 아니라, 놓친 부분을 짚어주는 방식). 이 스킬 시리즈는 시험이 아니라 학습 보조가 목적입니다.

## 대시보드 업데이트 (`00-dashboard.md`)

없으면 새로 만들고, 있으면 Day 1 행을 갱신하세요:

```markdown
# Spatial Computing 7-Day Camp — 진행 대시보드

| Day | 주제 | 상태 |
|-----|------|------|
| 1 | Spatial Computing 개론 | ✅ 완료 |
| 2 | ARKit 기초 | ⬜ |
| 3 | ARKit 심화 | ⬜ |
| 4 | RealityKit 기초 | ⬜ |
| 5 | RealityKit 심화 | ⬜ |
| 6 | 상호작용/제스처 | ⬜ |
| 7 | 미니 프로젝트 | ⬜ |
```

## 톤

이 시리즈를 쓰는 사람은 iOS/Java 백엔드 경험이 있는 개발자로 가정합니다 (완전 초보자용 설명 불필요). 개념을 아키텍처/설계 관점으로 설명하면 더 잘 와닿습니다.
