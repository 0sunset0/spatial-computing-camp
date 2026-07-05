---
name: day6-interaction-gesture
description: Day 6 of the Spatial Computing 7-day camp. Teaches interaction design for spatial apps — RealityKit gestures (tap/drag/rotate), collision and physics, and visionOS gaze-and-pinch interaction concepts — via a beginner-friendly, in-chat concept→code→quiz loop per concept (no note files), grounded in current Apple documentation, then codes the real SpatialCampApp Xcode project. Trigger this when the user runs /day6-interaction-gesture, has finished day5-realitykit-advanced, or asks about AR gestures, RealityKit collisions, or visionOS interaction models in the context of the spatial computing camp.
---

# Day 6 — 상호작용 / 제스처

목표: 지금까지 만든 콘텐츠를 사용자가 실제로 "만질 수 있게" 만든다. iOS AR의 터치 기반 제스처와, visionOS의 시선+손짓 기반 인터랙션 패러다임을 함께 다룬다.

## 프로젝트 규칙 (실제 Xcode 프로젝트에 코딩 — Day 2~5와 동일한 프로젝트를 이어서 사용)

`SpatialCampApp/Sources/SpatialCampApp/ARViewContainer.swift`를 이어서 수정합니다.

- 박스를 배치하는 부분에 `generateCollisionShapes` + `arView.installGestures`를 추가해서, 배치한 박스를 드래그/회전/스케일할 수 있게 만드세요. 충돌 이벤트 구독도 추가하세요 (아래 "코드 (실제로 작성)" 참고).
- 수정 후 `xcodebuild -project SpatialCampApp.xcodeproj -scheme SpatialCampApp -destination 'generic/platform=iOS Simulator' build`로 컴파일 검증. `BUILD SUCCEEDED`까지 고치세요.
- 제스처 동작은 **실기에서 Xcode로 빌드·실행**해서 직접 만져봐야 확인된다고 안내하세요.
- **선택 정리**: 사용자가 화면의 앵커 좌표축(xyz 기즈모)이 지저분하다고 느끼면, `makeUIView`의 `arView.debugOptions`에서 `.showAnchorOrigins`를 빼도 됩니다 (Day 2에서 트래킹 확인용으로 켰던 디버그 옵션인데, 이제 파티클·오브젝트·제스처로 상태가 충분히 보이므로 더 이상 필요 없습니다). `.showFeaturePoints`/`.showSceneUnderstanding`은 유지해도 무방합니다.

## 진행 방식 (중요, 모든 Day 공통)

- **노트/대시보드 파일을 만들지 않습니다.** `SpatialCampNotes/*.md`, `00-dashboard.md` 같은 파일을 생성하지 마세요. 설명은 전부 대화창 출력으로 전달합니다 (단, `SpatialCampApp/` 실제 프로젝트 코드 파일은 이 규칙과 무관하게 정상적으로 작성/수정합니다).
- **개념 설명 → 퀴즈 → 프로젝트 코드로 확인, 이 세 단계를 한 세트로 묶어서 반복하세요.** 개념을 설명하고, 대응하는 퀴즈 1문항(AskUserQuestion)을 바로 진행하고, 피드백을 준 다음, **그 개념에 해당하는 코드만** 실제 프로젝트 파일에 반영하고 `xcodebuild`로 컴파일까지 확인하세요. 모든 개념을 다 설명한 뒤에 퀴즈나 코드를 몰아서 하지 마세요.
- **컴파일 성공만으로 다음으로 넘어가지 마세요.** 시뮬레이터 빌드가 성공하면, 사용자에게 "실기(아이폰/아이패드)에서 Xcode로 직접 빌드·실행해서 제스처가 실제로 동작하는지 확인해보세요"라고 안내하고, 사용자가 빌드해봤는지·어떻게 됐는지 답할 때까지 기다리세요. 사용자가 답하면 그 응답을 반영하고 나서 다음으로 넘어가세요.
- **프로젝트 파일을 고치기 전에는 항상 "지금부터 무엇을, 왜 작성할지" 한두 문장으로 먼저 말하세요.** 코드를 한 번에 다 넣지 말고, 작은 단위로 나눠서 하나씩 진행하세요.
- **완전 초보자도 따라올 수 있게 설명하세요.** 전문 용어가 나오면 바로 정의하고, 비유를 적극 활용하세요.

## 트리거 시 할 일 (항상 이 순서: [개념 → 퀴즈 → 코드로 확인]을 개념별로 반복)

1. **공식 문서 확인 (필수, 조용히 먼저 수행)**: `web_search` + `web_fetch`로 RealityKit 제스처(`EntityGestureRecognizer` 관련 API, `.installGestures()`), `CollisionComponent`, `PhysicsBodyComponent`, visionOS 인터랙션(`SpatialTapGesture`, 시선+핀치 모델) 관련 Apple 공식 문서를 실제로 열어 최신 API로 확인.
2. **개념 1 — RealityKit 제스처 + 전제 조건(CollisionComponent)**: 개념 설명 → 퀴즈 1(AskUserQuestion) → 피드백 → "이제 배치된 박스에 충돌 shape와 제스처를 붙이겠습니다"라고 말한 뒤 `handleTap`의 박스 배치 코드 뒤에 `generateCollisionShapes` + `installGestures` + 상태 문구 갱신만 추가 → `xcodebuild ... build`로 확인.
3. **개념 2 — 충돌/물리 (CollisionComponent vs PhysicsBodyComponent)**: 개념 설명 → 퀴즈 2 → 피드백 → "이제 충돌이 실제로 감지되는지 콘솔에서 확인할 수 있는 구독 코드를 추가하겠습니다"라고 말한 뒤 파일 상단에 `import Combine` 추가 + `Coordinator`에 `collisionSubscription` 프로퍼티 + `arView.scene.subscribe(to: CollisionEvents.Began.self)` 구독을 추가 → `xcodebuild ... build`로 확인.
4. **개념 3 — iOS AR vs visionOS 인터랙션 모델**: 개념 설명 → 퀴즈 3 → 피드백. 이 프로젝트는 iOS 대상이라 추가 코드는 없으니, 코드 변경 없이 최종 `xcodebuild ... build`로 전체 컴파일을 한 번 더 확인.
5. 성공/실패를 대화창에 보고 (실패하면 사용자에게 보고하기 전에 먼저 고칠 것).
6. 모든 게 끝나면, 사용자에게 "다음" 또는 "완료"라고 입력하면 Day 7(캡스톤)로 넘어간다고 안내합니다. 사용자가 "다음"/"완료"(또는 유사 표현)로 응답하면, `/day7-mini-project` 슬래시 명령을 다시 요구하지 말고 **Skill 도구로 `day7-mini-project`를 직접 호출**하세요.

## 다룰 핵심 개념

- **RealityKit 제스처**: 엔티티에 탭/드래그/회전/핀치 제스처를 붙이는 방법. 제스처가 동작하려면 해당 엔티티에 `CollisionComponent`가 있어야 한다는 전제 조건을 강조.
- **충돌/물리**: `CollisionComponent`(충돌 감지용 shape), `PhysicsBodyComponent`(중력/질량 등 물리 시뮬레이션 참여 여부)의 역할 차이.
- **iOS AR 인터랙션 모델**: 화면 2D 터치 좌표 → 3D 공간 동작으로 매핑되는 간접적 상호작용.
- **visionOS 인터랙션 모델**: 시선(gaze)으로 대상을 지정하고 손가락 핀치(pinch)로 확정하는 간접 조작 방식 — 컨트롤러나 직접 터치가 없는 것이 iOS AR과의 근본적 차이. `SpatialTapGesture` 등 visionOS 전용 제스처 API 언급.
- **디자인 관점**: 두 플랫폼의 인터랙션 모델이 다르기 때문에 "같은 콘텐츠, 다른 상호작용 설계"가 필요하다는 점을 강조 (UX 설계 관심사와 연결).

## 코드 (실제로 작성 — `ARViewContainer.swift`의 `handleTap` 안, 박스 배치 코드 바로 뒤에 추가)

아래는 완성된 전체 코드입니다. **한 번에 다 쓰지 말고** 위 "트리거 시 할 일"에서 설명한 대로 나눠서 작성하세요: (1) `generateCollisionShapes`/`installGestures` 부분 → (2) 충돌 이벤트 구독 부분.

```swift
modelEntity.generateCollisionShapes(recursive: true)
arView.installGestures([.translation, .rotation, .scale], for: modelEntity)
status.statusText = "배치 완료! 오브젝트를 드래그/두 손가락으로 회전·확대해보세요"
```

`makeUIView`(또는 `Coordinator` 초기화 시 한 번)에 충돌 이벤트 구독 추가:

```swift
context.coordinator.collisionSubscription = arView.scene.subscribe(to: CollisionEvents.Began.self) { event in
    print("충돌 발생: \(event.entityA.name) - \(event.entityB.name)")
}
```

구독 결과(`Cancellable`)를 버리지 않도록 `Coordinator`에 `var collisionSubscription: Cancellable?` 프로퍼티를 만들어 보관하세요 (그렇지 않으면 즉시 해제되어 이벤트가 안 옵니다). **`Cancellable`은 Combine 프레임워크 타입이므로 파일 상단에 `import Combine`을 추가해야 합니다** (안 그러면 "cannot find type 'Cancellable' in scope" 컴파일 에러가 납니다).

## 퀴즈

아래 3문제는 각각 대응하는 개념 설명 **직후 바로** 진행하세요 (Q1→RealityKit 제스처 전제 조건 개념 뒤, Q2→충돌/물리 컴포넌트 개념 뒤, Q3→iOS AR vs visionOS 인터랙션 모델 개념 뒤). 모든 개념 설명이 끝날 때까지 기다렸다가 한꺼번에 몰아서 내지 마세요. **객관식 4지선다**로, **AskUserQuestion 도구를 사용해서 사용자가 방향키/클릭으로 보기 중 하나를 고를 수 있게 하세요** (대화창에 A~D 텍스트를 그냥 출력하고 타이핑으로 답하게 하지 마세요):

1. 해당 개념 설명이 끝나면 그 자리에서 AskUserQuestion으로 물어봅니다. `question`에는 문제 본문을, `options`에는 4개 보기를 `label`(짧게, 예: "A", "B"처럼 식별 가능하게 보기 핵심을 담아)과 `description`(보기 전문)으로 각각 담아 전달하세요. 정답을 먼저 알려주지 않습니다.
2. 사용자가 선택하면 정답 여부를 알려주되, 정답이든 오답이든 **왜 그런지, 다른 보기는 왜 아닌지**까지 피드백합니다 (단순 정오 통보로 끝내지 않기).
3. 피드백 후 바로 다음 개념 설명으로 넘어가고, 그 개념이 끝나면 다음 문제를 동일하게 진행합니다.

아래 정답 표시는 채점 참고용이며 **AskUserQuestion의 옵션에는 넣지 말고, 사용자에게 먼저 노출하지도 마세요**:

```
Q1. 제스처가 동작하려면 엔티티에 어떤 컴포넌트가 먼저 필요할까요?
A. ModelComponent만 있으면 충분하다.
B. CollisionComponent(및 입력을 받기 위한 InputTargetComponent)가 필요하다.
C. AnchorComponent만 있으면 제스처가 자동으로 인식된다.
D. 별도 컴포넌트 없이 모든 엔티티가 기본적으로 제스처를 인식한다.
(정답: B)

Q2. CollisionComponent와 PhysicsBodyComponent의 차이는?
A. CollisionComponent는 충돌 감지(shape, 충돌 그룹)를 정의하고, PhysicsBodyComponent는 실제 물리 시뮬레이션(질량, 중력, 힘)을 담당한다.
B. 둘은 완전히 동일한 역할을 한다.
C. PhysicsBodyComponent가 없으면 충돌 자체가 감지되지 않는다.
D. CollisionComponent는 visionOS에서만 지원된다.
(정답: A)

Q3. iOS AR과 visionOS의 인터랙션 모델 차이를 한 문장으로 요약하면?
A. iOS AR은 화면 터치/제스처 기반, visionOS는 시선(gaze)+손짓(pinch) 기반의 공간 인터랙션이다.
B. 둘 다 동일하게 컨트롤러 기반이다.
C. iOS AR은 음성 명령 기반이다.
D. visionOS는 터치스크린을 기반으로 한다.
(정답: A)
```

## 톤

완전 초보자도 따라올 수 있게 설명하는 것을 우선하세요. 전문 용어는 등장할 때 바로 풀어서 정의하고, 비유를 적극 활용하세요. UX/제품 디자인에 관심이 있다는 맥락이 있다면, 기본 설명 이후에 "왜 이 인터랙션 모델이 더 나은가"에 대한 설계 논의로 확장해도 좋습니다.

**가독성**: 긴 문단보다 표를 우선하세요. 두 가지 이상을 비교하는 내용(예: CollisionComponent vs PhysicsBodyComponent, iOS AR vs visionOS)은 마크다운 표로 정리하고, 코드를 줄 단위로 설명할 때도 "코드 조각 | 설명" 형태의 표를 쓰세요. 불릿은 표로 담기 어려운 짧은 요약에만 사용하세요.
