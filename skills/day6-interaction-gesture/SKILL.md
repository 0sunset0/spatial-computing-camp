---
name: day6-interaction-gesture
description: Day 6 of the Spatial Computing 7-day camp. Teaches interaction design for spatial apps — RealityKit gestures (tap/drag/rotate), collision and physics, and visionOS gaze-and-pinch interaction concepts — via a beginner-friendly, in-chat concept→code→quiz loop per concept (no note files), grounded in current Apple documentation, then codes the real SpatialCampApp Xcode project. Trigger this when the user runs /day6-interaction-gesture, has finished day5-realitykit-advanced, or asks about AR gestures, RealityKit collisions, or visionOS interaction models in the context of the spatial computing camp.
---

# Day 6 — 상호작용 / 제스처

목표: 지금까지 만든 콘텐츠를 사용자가 실제로 "만질 수 있게" 만든다. iOS AR의 터치 기반 제스처와, visionOS의 시선+손짓 기반 인터랙션 패러다임을 함께 다룬다.

## 프로젝트 규칙 (실제 Xcode 프로젝트에 코딩 — Day 2~5와 동일한 프로젝트를 이어서 사용)

`SpatialCampApp/Sources/SpatialCampApp/ARViewContainer.swift`(설정 담당)와 `ARCoordinator.swift`(이벤트 반응 담당)를 이어서 수정합니다.

Day 4~5를 거치며 `ARCoordinator.swift`는 `raycastResult(for:in:)`(감지) → `makeSphereEntity()`(엔티티 생성) → `place(_:at:in:)`(배치)로, `ARViewContainer.swift`는 `makeSessionConfiguration()`/`configureDebugOptions(for:)`/`setupTapGesture(on:coordinator:)`로 역할이 나뉘어 있습니다. Day 6의 새 코드도 이 구조에 맞춰 넣습니다.

- 충돌 shape(`generateCollisionShapes`)는 엔티티 자체의 속성이므로 `makeSphereEntity()`에, 제스처 설치(`arView.installGestures`)는 엔티티가 씬에 실제로 등록된 뒤 붙여야 하므로 `place(_:at:in:)`에 추가하세요. 충돌 이벤트 구독은 `ARViewContainer.swift`에 새 private 함수(`subscribeToCollisionEvents(on:coordinator:)`)로 추가하세요 (아래 "코드 (실제로 작성)" 참고).
- **물리 시뮬레이션은 콘솔 로그보다 눈에 보이는 방식으로 확인시키세요.** `CollisionComponent`만 있고 `PhysicsBodyComponent`가 없으면, 제스처로 옮긴(kinematic) 엔티티끼리의 충돌이 물리 엔진에 안정적으로 감지되지 않는 경우가 많습니다. `makeSphereEntity()`에서 구에 `PhysicsBodyComponent(mode: .dynamic)`을 붙이고, `session(_:didAdd:)`에서 감지된 수평 평면(`ARPlaneAnchor`)마다 보이지 않는 정적(static) 물리 바닥(`addPhysicsFloor(for:)`)을 깔아서, 구가 실제로 중력에 의해 그 바닥까지 떨어지고 서로 부딪혀 튕기는 것을 눈으로 확인시키세요 (콘솔 로그 구독은 보조 확인 수단으로만 유지).
- 수정 후 `xcodebuild -project SpatialCampApp.xcodeproj -scheme SpatialCampApp -destination 'generic/platform=iOS Simulator' build`로 컴파일 검증. `BUILD SUCCEEDED`까지 고치세요.
- 제스처 동작은 **실기에서 Xcode로 빌드·실행**해서 직접 만져봐야 확인된다고 안내하세요.
- **코드 작성 시 설명 주석을 함께 남깁니다.** 새로 작성하거나 수정하는 Swift 코드 줄/블록마다, 그게 무엇을 하는지·왜 이렇게 쓰는지 설명하는 한국어 주석을 함께 답니다. 이 캠프는 학습용 자료라서 "자명한 코드엔 주석을 달지 않는다"는 일반적인 클린코드 관례의 예외입니다.

## 진행 방식 (중요, 모든 Day 공통)

- **노트/대시보드 파일을 만들지 않습니다.** `SpatialCampNotes/*.md`, `00-dashboard.md` 같은 파일을 생성하지 마세요. 설명은 전부 대화창 출력으로 전달합니다 (단, `SpatialCampApp/` 실제 프로젝트 코드 파일은 이 규칙과 무관하게 정상적으로 작성/수정합니다).
- **개념 설명 → 퀴즈 → 프로젝트 코드로 확인, 이 세 단계를 한 세트로 묶어서 반복하세요.** 개념을 설명하고, 대응하는 퀴즈 1문항(AskUserQuestion)을 바로 진행하고, 피드백을 준 다음, **그 개념에 해당하는 코드만** 실제 프로젝트 파일에 반영하고 `xcodebuild`로 컴파일까지 확인하세요. 모든 개념을 다 설명한 뒤에 퀴즈나 코드를 몰아서 하지 마세요.
- **컴파일 성공만으로 다음으로 넘어가지 마세요.** 시뮬레이터 빌드가 성공하면, 사용자에게 "실기(아이폰/아이패드)에서 Xcode로 직접 빌드·실행해서 제스처가 실제로 동작하는지 확인해보세요"라고 안내하고, 사용자가 빌드해봤는지·어떻게 됐는지 답할 때까지 기다리세요. 사용자가 답하면 그 응답을 반영하고 나서 다음으로 넘어가세요.
- **프로젝트 파일을 고치기 전에는 항상 "지금부터 무엇을, 왜 작성할지" 한두 문장으로 먼저 말하세요.** 코드를 한 번에 다 넣지 말고, 작은 단위로 나눠서 하나씩 진행하세요.
- **완전 초보자도 따라올 수 있게 설명하세요.** 전문 용어가 나오면 바로 정의하고, 비유를 적극 활용하세요.

## 트리거 시 할 일 (항상 이 순서: [개념 → 퀴즈 → 코드로 확인]을 개념별로 반복)

1. **공식 문서 확인 (필수, 조용히 먼저 수행)**: `web_search` + `web_fetch`로 RealityKit 제스처(`EntityGestureRecognizer` 관련 API, `.installGestures()`), `CollisionComponent`, `PhysicsBodyComponent`, visionOS 인터랙션(`SpatialTapGesture`, 시선+핀치 모델) 관련 Apple 공식 문서를 실제로 열어 최신 API로 확인.
2. **개념 1 — RealityKit 제스처 + 전제 조건(CollisionComponent)**: 개념 설명 → 퀴즈 1(AskUserQuestion) → 피드백 → "이제 배치된 박스에 충돌 shape와 제스처를 붙이겠습니다"라고 말한 뒤 `makeSphereEntity()`에 `generateCollisionShapes` 추가 + `place(_:at:in:)`에 `installGestures` + 상태 문구 갱신 추가 → `xcodebuild ... build`로 확인.
3. **개념 2 — 충돌/물리 (CollisionComponent vs PhysicsBodyComponent)**: 개념 설명 → 퀴즈 2 → 피드백 → "이제 구가 실제로 중력을 받아 떨어지고, 서로 부딪히는 걸 보여드리겠습니다"라고 말한 뒤 (a) `makeSphereEntity()`의 `PhysicsBodyComponent` 모드를 `.dynamic`으로 설정 (b) `session(_:didAdd:)`에서 수평 평면이 감지되면 `addPhysicsFloor(for:)`를 호출하도록 추가 (c) `addPhysicsFloor(for:)` 함수를 새로 만들어 `AnchorEntity(anchor: planeAnchor)`에 보이지 않는 정적 물리 바닥을 붙임 (d) `place(_:at:in:)`에서 구를 탭 지점보다 위에서 스폰하도록 수정 → `xcodebuild ... build`로 확인. 여유가 있다면 `ARCoordinator.swift`에 `import Combine` + `collisionSubscription` 프로퍼티, `ARViewContainer.swift`에 `subscribeToCollisionEvents(on:coordinator:)`를 추가해 콘솔 로그도 보조로 확인시켜도 좋음.
4. **개념 3 — iOS AR vs visionOS 인터랙션 모델**: 개념 설명 → 퀴즈 3 → 피드백. 이 프로젝트는 iOS 대상이라 추가 코드는 없으니, 코드 변경 없이 최종 `xcodebuild ... build`로 전체 컴파일을 한 번 더 확인.
5. 성공/실패를 대화창에 보고 (실패하면 사용자에게 보고하기 전에 먼저 고칠 것).
6. 모든 게 끝나면, 사용자에게 "다음" 또는 "완료"라고 입력하면 Day 7(캡스톤)로 넘어간다고 안내합니다. 사용자가 "다음"/"완료"(또는 유사 표현)로 응답하면, `/day7-mini-project` 슬래시 명령을 다시 요구하지 말고 **Skill 도구로 `day7-mini-project`를 직접 호출**하세요.

## 다룰 핵심 개념

- **RealityKit 제스처**: 엔티티에 탭/드래그/회전/핀치 제스처를 붙이는 방법. 제스처가 동작하려면 해당 엔티티에 `CollisionComponent`가 있어야 한다는 전제 조건을 강조.
- **충돌/물리**: `CollisionComponent`(충돌 감지용 shape) vs `PhysicsBodyComponent`(중력/질량 등 물리 시뮬레이션 참여 여부)의 역할 차이. `PhysicsBodyComponent`의 세 모드(`.dynamic`=중력·힘을 받아 움직임, `.kinematic`=내가 직접 위치를 제어하지만 충돌 판정엔 참여, `.static`=절대 안 움직이는 받침대) 구분도 함께.
- **iOS AR 인터랙션 모델**: 화면 2D 터치 좌표 → 3D 공간 동작으로 매핑되는 간접적 상호작용.
- **visionOS 인터랙션 모델**: 시선(gaze)으로 대상을 지정하고 손가락 핀치(pinch)로 확정하는 간접 조작 방식 — 컨트롤러나 직접 터치가 없는 것이 iOS AR과의 근본적 차이. `SpatialTapGesture` 등 visionOS 전용 제스처 API 언급.
- **디자인 관점**: 두 플랫폼의 인터랙션 모델이 다르기 때문에 "같은 콘텐츠, 다른 상호작용 설계"가 필요하다는 점을 강조 (UX 설계 관심사와 연결).

## 코드 (실제로 작성 — `makeSphereEntity()`, `session(_:didAdd:)`, `place(_:at:in:)`, `ARViewContainer.swift`에 나눠서 추가)

아래는 완성된 전체 코드입니다. **한 번에 다 쓰지 말고** 위 "트리거 시 할 일"에서 설명한 대로 나눠서 작성하세요: (1) `makeSphereEntity()`에 `generateCollisionShapes` + `PhysicsBodyComponent(.dynamic)` → (2) `session(_:didAdd:)`에서 수평 평면 감지 시 `addPhysicsFloor(for:)` 호출 + 그 함수 자체 추가 → (3) `place(_:at:in:)`에 스폰 높이 조정 + `installGestures` → (4) (선택) 충돌 이벤트 구독 부분.

`makeSphereEntity()` — `return sphere` 앞에 충돌 shape + 물리 바디 추가:

```swift
// 충돌 shape: 이게 있어야 제스처/충돌 감지가 동작함 (엔티티 자체의 속성이라 여기서 붙임)
sphere.generateCollisionShapes(recursive: true)

// PhysicsBodyComponent(.dynamic): 중력·충돌 반응까지 물리 엔진이 실제로 시뮬레이션하게 함.
// .kinematic(우리가 위치를 직접 제어)과 달리, .dynamic은 중력을 받아 떨어지고
// 다른 물체에 부딪히면 실제로 밀려나는 등 "진짜 구슬"처럼 움직입니다.
sphere.components.set(PhysicsBodyComponent(massProperties: .default, material: .default, mode: .dynamic))

return sphere
```

`session(_:didAdd:)` — 평면 감지 이후, 수평면일 때만 물리 바닥을 붙이도록 추가:

```swift
// 수평면(바닥)에만 물리 바닥을 붙임 — 벽 같은 수직면은 구가 떨어져서 닿을 대상이 아니므로 제외.
// arView.scene 조작도 렌더링과 관련된 작업이라 메인 스레드에서 실행
if planeAnchor.alignment == .horizontal {
    DispatchQueue.main.async { [weak self] in
        self?.addPhysicsFloor(for: planeAnchor)
    }
}
```

새 private 함수 `addPhysicsFloor(for:)`를 `ARCoordinator`에 추가 — ARKit이 실제로 감지한 평면에 보이지 않는 정적 물리 바닥을 붙입니다:

```swift
// 물리 바닥 담당: ARKit이 실제로 감지한 평면(ARPlaneAnchor)에 보이지 않는 정적(static)
// 물리 바디를 붙여서, 떨어지는 구가 "진짜 인식된 바닥"에 닿아 멈추게 함.
// AnchorEntity(anchor:)는 ARKit이 이 평면의 위치/방향을 갱신할 때 자동으로 따라오므로
// 우리가 좌표를 직접 계산·갱신할 필요가 없음
private func addPhysicsFloor(for planeAnchor: ARPlaneAnchor) {
    guard let arView = arView else { return }

    let floorAnchor = AnchorEntity(anchor: planeAnchor)
    let floor = Entity() // ModelComponent(시각 요소) 없이 충돌+물리 속성만 가진 "투명한" 엔티티
    // planeExtent.width/height: 감지된 평면의 가로/세로 크기(로컬 x축/z축 기준)
    floor.components.set(CollisionComponent(shapes: [
        .generateBox(width: planeAnchor.planeExtent.width, height: 0.01, depth: planeAnchor.planeExtent.height)
    ]))
    floor.components.set(PhysicsBodyComponent(massProperties: .default, material: .default, mode: .static))
    floorAnchor.addChild(floor)
    arView.scene.addAnchor(floorAnchor)
}
```

`place(_:at:in:)` — 구를 탭 지점보다 위에서 스폰(떨어지는 게 보이도록) + `arView.scene.addAnchor(anchorEntity)` 뒤에 제스처 설치 추가:

```swift
// 구는 탭한 지점보다 30cm 위에서 시작 — 배치되는 순간 중력에 의해 실제로 감지된
// 바닥(addPhysicsFloor(for:)가 만들어둔 물리 바닥)까지 떨어지는 게 눈에 보이도록 함
entity.transform.translation.y += 0.3
anchorEntity.addChild(entity)
arView.scene.addAnchor(anchorEntity)

arView.installGestures([.translation, .rotation, .scale], for: entity)
```

`handleTap` 마지막의 안내 문구도 이 테스트용으로 바꾸세요:

```swift
status.statusText = "배치 완료! 구슬이 떨어지는지, 여러 개를 배치해 서로 부딪히는지 확인해보세요"
```

**(선택) 콘솔 로그로도 보조 확인**하고 싶다면, `ARViewContainer.swift`에 새 private 함수를 만들어 충돌 이벤트 구독을 추가하고 `makeUIView`에서 호출하세요:

```swift
private func subscribeToCollisionEvents(on arView: ARView, coordinator: ARCoordinator) {
    coordinator.collisionSubscription = arView.scene.subscribe(to: CollisionEvents.Began.self) { event in
        print("충돌 발생: \(event.entityA.name) - \(event.entityB.name)")
    }
}
```

구독 결과(`Cancellable`)를 버리지 않도록 `ARCoordinator.swift`의 `ARCoordinator`에 `var collisionSubscription: Cancellable?` 프로퍼티를 만들어 보관하세요 (그렇지 않으면 즉시 해제되어 이벤트가 안 옵니다). **`Cancellable`은 Combine 프레임워크 타입이므로 `ARCoordinator.swift` 상단에 `import Combine`을 추가해야 합니다** (안 그러면 "cannot find type 'Cancellable' in scope" 컴파일 에러가 납니다).

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
