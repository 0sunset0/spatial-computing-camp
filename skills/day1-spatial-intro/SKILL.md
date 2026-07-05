---
name: day1-spatial-intro
description: Day 1 of the Spatial Computing 7-day camp. Teaches Apple's spatial computing concept map (ARKit, RealityKit, visionOS, and how they relate) and platform comparison basics via a beginner-friendly, in-chat concept→code→quiz loop per concept (no note files generated). Trigger this whenever the user runs /day1-spatial-intro, says they're starting the spatial computing camp, or asks for an intro/overview lesson on Apple spatial computing, ARKit vs RealityKit vs visionOS, or "day 1" of an AR/spatial learning plan. Always use this skill instead of a generic explanation when the user is clearly following the 7-day camp curriculum (day1 → day7).
---

# Day 1 — Spatial Computing 개론

7일 커리큘럼의 첫째 날. 목표는 "Apple 생태계 안에서 spatial computing이 어떻게 조각나 있는지"에 대한 큰 그림을 잡아주는 것입니다. 개념 지도가 중심이지만, 다른 Day들과 동일하게 짧은 샘플 코드도 함께 보여줘서 "코드 예제로 학습 → 퀴즈 → 다음 스킬" 패턴을 Day 1부터 일관되게 유지합니다.

## 진행 방식 (중요, 모든 Day 공통)

- **노트/대시보드 파일을 만들지 않습니다.** `SpatialCampNotes/*.md`, `00-dashboard.md` 같은 파일을 생성하지 마세요. 모든 설명과 코드는 대화창 출력만으로 전달합니다.
- **개념 하나 설명 → (코드가 있으면) 코드 설명 → 그 개념에 대응하는 퀴즈 1문항**을 곧바로 AskUserQuestion으로 진행하고, 이 사이클을 다음 개념으로 넘어가며 반복하세요. 모든 개념을 다 설명한 뒤에 퀴즈를 몰아서 내지 마세요.
- **완전 초보자도 따라올 수 있게 설명하세요.** 전문 용어가 나오면 바로 정의하고, 비유를 적극 활용하세요.

## 이 스킬이 트리거되면 할 일

1. **공식 문서 확인 (필수, 건너뛰지 말 것, 조용히 먼저 수행)**: `web_search`로 아래 "핵심 개념"에 나온 프레임워크/개념에 대한 Apple 공식 문서(`developer.apple.com/documentation/arkit`, `.../realitykit`, `.../visionos`)를 찾고, `web_fetch`로 실제 내용을 확인하세요. 학습 데이터 시점과 달라진 부분(새 API, deprecated된 개념, 새 플랫폼 지원 등)이 있으면 설명에 반영하고 사용자에게도 짚어주세요.
2. **핵심 개념을 하나씩 순서대로**: 개념 설명 → 코드 예제 설명 → 그 개념에 대응하는 퀴즈 1문항(AskUserQuestion) → 피드백, 을 "다룰 핵심 개념"에 나열된 순서대로 반복합니다.
3. 모든 개념+퀴즈가 끝나면, 사용자에게 "다음" 또는 "완료"라고 입력하면 Day 2로 넘어간다고 안내합니다.
4. 사용자가 "다음", "완료" 또는 이에 준하는 표현(예: 넘어가자, next, ㄱㄱ)으로 응답하면, `/day2-arkit-basics` 슬래시 명령을 다시 입력하라고 요구하지 말고 **Skill 도구로 `day2-arkit-basics`를 직접 호출**해 바로 이어서 진행하세요.

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

## 퀴즈

아래 3문제는 각각 대응하는 개념 설명 **직후 바로** 진행하세요 (Q1→ARKit/RealityKit 역할 구분 개념 뒤, Q2→visionOS 인터랙션 개념 뒤, Q3→Reality Composer Pro 개념 뒤). 모든 개념 설명이 끝날 때까지 기다렸다가 한꺼번에 몰아서 내지 마세요. **객관식 4지선다**로, **AskUserQuestion 도구를 사용해서 사용자가 방향키/클릭으로 보기 중 하나를 고를 수 있게 하세요** (대화창에 A~D 텍스트를 그냥 출력하고 타이핑으로 답하게 하지 마세요):

1. 해당 개념 설명이 끝나면 그 자리에서 AskUserQuestion으로 물어봅니다. `question`에는 문제 본문을, `options`에는 4개 보기를 `label`(짧게, 예: "A", "B"처럼 식별 가능하게 보기 핵심을 담아)과 `description`(보기 전문)으로 각각 담아 전달하세요. 정답을 먼저 알려주지 않습니다.
2. 사용자가 선택하면 정답 여부를 알려주되, 정답이든 오답이든 **왜 그런지, 다른 보기는 왜 아닌지**까지 피드백합니다 (단순 정오 통보로 끝내지 않기).
3. 피드백 후 바로 다음 개념 설명으로 넘어가고, 그 개념이 끝나면 다음 문제를 동일하게 진행합니다.

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

## 톤

완전 초보자도 따라올 수 있게 설명하는 것을 우선하세요. 전문 용어는 등장할 때 바로 풀어서 정의하고, 비유를 적극 활용하세요. 이미 아는 개념이 있다면 아키텍처/설계 관점 설명을 덧붙여도 좋지만, 기본 설명 자체를 초보자 눈높이 아래로 생략하지 마세요.
