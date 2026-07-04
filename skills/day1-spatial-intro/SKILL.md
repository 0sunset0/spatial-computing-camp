---
name: day1-spatial-intro
description: Day 1 of the Spatial Computing 7-day camp. Teaches Apple's spatial computing concept map (ARKit, RealityKit, visionOS, and how they relate), platform comparison basics, and generates a Day 1 study note plus a mini checkpoint quiz. Trigger this whenever the user runs /day1-spatial-intro, says they're starting the spatial computing camp, or asks for an intro/overview lesson on Apple spatial computing, ARKit vs RealityKit vs visionOS, or "day 1" of an AR/spatial learning plan. Always use this skill instead of a generic explanation when the user is clearly following the 7-day camp curriculum (day1 → day7).
---

# Day 1 — Spatial Computing 개론

7일 커리큘럼의 첫째 날. 목표는 "Apple 생태계 안에서 spatial computing이 어떻게 조각나 있는지"에 대한 큰 그림을 잡아주는 것입니다. 개념 지도가 중심이지만, 다른 Day들과 동일하게 짧은 샘플 코드도 함께 보여줘서 "코드 예제로 학습 → 퀴즈 → 다음 스킬" 패턴을 Day 1부터 일관되게 유지합니다.

## 이 스킬이 트리거되면 할 일

1. **노트 폴더 확인/생성**: 현재 작업 폴더에 `SpatialCampNotes/`가 없으면 만드세요. 없다면 `SpatialCampNotes/00-dashboard.md`도 함께 생성합니다 (아래 대시보드 포맷 참고).
2. **공식 문서 확인 (필수, 건너뛰지 말 것)**: 노트를 쓰기 전에 `web_search`로 아래 "핵심 개념"에 나온 프레임워크/개념에 대한 Apple 공식 문서(`developer.apple.com/documentation/arkit`, `.../realitykit`, `.../visionos`)를 찾고, `web_fetch`로 실제 내용을 확인하세요. 학습 데이터 시점과 달라진 부분(새 API, deprecated된 개념, 새 플랫폼 지원 등)이 있으면 노트에 반영하고 사용자에게도 짚어주세요.
3. **Day 1 학습 노트 생성**: `SpatialCampNotes/day1-spatial-intro.md` 파일을 아래 "노트 구조"에 맞춰 작성합니다. 실제로 fetch한 공식 문서 URL을 "참고 자료" 섹션에 남기세요.
4. **본문에도 핵심 요약과 "코드 예제" 섹션을 대화창에 출력**합니다 (파일만 만들고 끝내지 말 것 — 사용자가 바로 읽을 수 있어야 함).
5. **체크포인트 퀴즈**로 마무리합니다 (아래 "퀴즈" 섹션).
6. 퀴즈가 모두 끝나면, 사용자에게 "다음" 또는 "완료"라고 입력하면 Day 2로 넘어간다고 안내합니다.
7. 사용자가 "다음", "완료" 또는 이에 준하는 표현(예: 넘어가자, next, ㄱㄱ)으로 응답하면, `/day2-arkit-basics` 슬래시 명령을 다시 입력하라고 요구하지 말고 **Skill 도구로 `day2-arkit-basics`를 직접 호출**해 바로 이어서 진행하세요.

## 다룰 핵심 개념

- **Spatial computing이란?** 디지털 콘텐츠와 물리적 공간을 실시간으로 정합(align)시켜, 사용자가 3D 공간 안에서 콘텐츠와 상호작용하게 만드는 컴퓨팅 패러다임. AR/VR/MR을 포괄하는 상위 개념으로 설명할 것.
- **Apple 생태계 지도** (이 관계를 표/다이어그램으로 명확히 설명):
  - `ARKit` — 카메라/센서 기반 월드 트래킹, 평면 감지, 앵커, 씬 이해(Scene Geometry, People Occlusion 등)를 제공하는 **저수준 프레임워크**. iPhone/iPad에서 동작.
  - `RealityKit` — ARKit이 준 공간 정보 위에서 **3D 콘텐츠 렌더링/물리/애니메이션/파티클**을 담당하는 **고수준 렌더링·시뮬레이션 프레임워크**. ECS(Entity-Component-System) 구조.
  - `visionOS` — Apple Vision Pro의 OS. RealityKit + ARKit(공간 인식 API들)을 기반으로 완전한 공간 UI 앱을 만드는 플랫폼. `windows`, `volumes`, `spaces` 같은 visionOS 전용 UI 패러다임 존재.
  - `Reality Composer Pro` — RealityKit 씬(파티클, 머티리얼, 애니메이션)을 코드 없이 조립하는 저작 도구.
- **플랫폼 비교**: iOS AR(핸드폰 화면으로 보는 AR) vs visionOS(머리에 쓰고 몰입하는 공간 컴퓨팅)의 차이를 인터랙션 모델(터치 vs 시선+손짓) 중심으로 설명.
- **왜 두 프레임워크가 나뉘어 있는가**: "센서가 보는 것(ARKit)"과 "화면에 그리는 것(RealityKit)"의 관심사 분리라는 설계 철학을 강조.

## 코드 예제 (개념 비교용 미리보기)

깊이 설명하지 말고 "이런 모양이다"라는 감만 잡게 짧게 보여주세요. 자세한 설명은 Day 2(ARKit)와 Day 4(RealityKit)에서 다룹니다.

ARKit — "공간을 이해한다":

```swift
let session = ARSession()
let configuration = ARWorldTrackingConfiguration()
configuration.planeDetection = [.horizontal, .vertical]
session.run(configuration)
```

RealityKit — "그 공간 위에 그린다":

```swift
let arView = ARView(frame: .zero)
let anchor = AnchorEntity(plane: .horizontal)
let box = ModelEntity(mesh: .generateBox(size: 0.1))
anchor.addChild(box)
arView.scene.addAnchor(anchor)
```

두 코드를 나란히 보여주면서, `ARSession`/`ARWorldTrackingConfiguration`은 "트래킹 설정"이고 `ARView`/`AnchorEntity`/`ModelEntity`는 "렌더링 설정"이라는 계층 차이를 코드 모양으로도 확인시켜 주세요.

## 노트 구조 (`day1-spatial-intro.md`)

```markdown
# Day 1: Spatial Computing 개론

## 오늘의 목표
(1~2문장)

## 개념 지도
(ARKit / RealityKit / visionOS / Reality Composer Pro 관계를 표 또는 인디언트 구조로)

## 코드 예제
(ARKit vs RealityKit 설정 코드 비교 스니펫)

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

이 3문제를 **객관식 4지선다**로, 한 번에 다 보여주지 말고 **한 문제씩** 진행하세요. **AskUserQuestion 도구를 사용해서 사용자가 방향키/클릭으로 보기 중 하나를 고를 수 있게 하세요** (대화창에 A~D 텍스트를 그냥 출력하고 타이핑으로 답하게 하지 마세요):

1. Q1을 AskUserQuestion으로 물어봅니다. `question`에는 문제 본문을, `options`에는 4개 보기를 `label`(짧게, 예: "A", "B"처럼 식별 가능하게 보기 핵심을 담아)과 `description`(보기 전문)으로 각각 담아 전달하세요. 정답을 먼저 알려주지 않습니다.
2. 사용자가 선택하면 정답 여부를 알려주되, 정답이든 오답이든 **왜 그런지, 다른 보기는 왜 아닌지**까지 피드백합니다 (단순 정오 통보로 끝내지 않기).
3. 이어서 Q2 → AskUserQuestion → 피드백, 마지막으로 Q3도 동일하게 진행합니다.
4. 세 문제가 모두 끝나면 다음 단계로 안내합니다.

아래 정답 표시는 채점 참고용이며 **AskUserQuestion의 옵션에는 넣지 말고, 사용자에게 먼저 노출하지도 마세요**:

```
Q1. ARKit과 RealityKit의 역할 차이를 가장 정확하게 설명한 것은?
A. ARKit은 3D 렌더링을 담당하고, RealityKit은 카메라 트래킹을 담당한다.
B. ARKit은 카메라/센서 기반으로 공간을 트래킹하고, RealityKit은 그 위에 3D 콘텐츠를 렌더링·시뮬레이션한다.
C. 둘은 완전히 동일한 기능을 제공하며 플랫폼만 다르다.
D. ARKit은 visionOS 전용이고, RealityKit은 iOS 전용이다.
(정답: B)

Q2. visionOS와 iOS AR의 가장 큰 인터랙션 모델 차이는?
A. visionOS는 터치 기반, iOS AR은 음성 기반이다.
B. visionOS는 시선(gaze)과 손짓(pinch) 기반, iOS AR은 화면 터치 기반이다.
C. 둘 다 컨트롤러 기반 인터랙션을 사용한다.
D. iOS AR은 시선 추적을, visionOS는 터치를 사용한다.
(정답: B)

Q3. Reality Composer Pro의 역할은?
A. ARKit 세션을 코드로 디버깅하는 도구.
B. RealityKit 씬(머티리얼, 파티클, 애니메이션)을 코드 없이 조립하는 저작 도구.
C. visionOS 앱을 App Store에 배포하는 도구.
D. Swift 코드를 자동 생성하는 컴파일러.
(정답: B)
```

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
