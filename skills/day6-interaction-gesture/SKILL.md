---
name: day6-interaction-gesture
description: Day 6 of the Spatial Computing 7-day camp. Teaches interaction design for spatial apps — RealityKit gestures (tap/drag/rotate), collision and physics, and visionOS gaze-and-pinch interaction concepts — with Swift code examples grounded in current Apple documentation, then generates a Day 6 study note and checkpoint quiz. Trigger this when the user runs /day6-interaction-gesture, has finished day5-realitykit-advanced, or asks about AR gestures, RealityKit collisions, or visionOS interaction models in the context of the spatial computing camp.
---

# Day 6 — 상호작용 / 제스처

목표: 지금까지 만든 콘텐츠를 사용자가 실제로 "만질 수 있게" 만든다. iOS AR의 터치 기반 제스처와, visionOS의 시선+손짓 기반 인터랙션 패러다임을 함께 다룬다.

## 프로젝트 규칙 (실제 Xcode 프로젝트에 코딩 — Day 2~5와 동일한 프로젝트를 이어서 사용)

`SpatialCampApp/Sources/SpatialCampApp/ARViewContainer.swift`를 이어서 수정합니다.

- 박스를 배치하는 부분에 `generateCollisionShapes` + `arView.installGestures`를 추가해서, 배치한 박스를 드래그/회전/스케일할 수 있게 만드세요. 충돌 이벤트 구독도 추가하세요 (아래 "코드 (실제로 작성)" 참고).
- 수정 후 `xcodebuild -project SpatialCampApp.xcodeproj -scheme SpatialCampApp -destination 'generic/platform=iOS Simulator' build`로 컴파일 검증. `BUILD SUCCEEDED`까지 고치세요.
- 제스처 동작은 **실기에서 Xcode로 빌드·실행**해서 직접 만져봐야 확인된다고 안내하세요.

## 트리거 시 할 일

1. `SpatialCampNotes/day6-interaction-gesture.md` 생성.
2. **공식 문서 확인 (필수)**: `web_search` + `web_fetch`로 RealityKit 제스처(`EntityGestureRecognizer` 관련 API, `.installGestures()`), `CollisionComponent`, `PhysicsBodyComponent`, visionOS 인터랙션(`SpatialTapGesture`, 시선+핀치 모델) 관련 Apple 공식 문서를 실제로 열어 최신 API로 검증 후 작성.
3. `ARViewContainer.swift`를 열어 아래 "코드 (실제로 작성)" 내용을 반영.
4. `xcodebuild ... build`로 컴파일 검증 (위 "프로젝트 규칙" 참고).
5. 핵심 개념 + 실제로 작성한 코드를 대화창에 설명.
6. 체크포인트 퀴즈 진행.
7. `00-dashboard.md`의 Day 6 상태 갱신.
8. 퀴즈가 모두 끝나면, 사용자에게 "다음" 또는 "완료"라고 입력하면 Day 7(캡스톤)로 넘어간다고 안내합니다. 사용자가 "다음"/"완료"(또는 유사 표현)로 응답하면, `/day7-mini-project` 슬래시 명령을 다시 요구하지 말고 **Skill 도구로 `day7-mini-project`를 직접 호출**하세요.

## 다룰 핵심 개념

- **RealityKit 제스처**: 엔티티에 탭/드래그/회전/핀치 제스처를 붙이는 방법. 제스처가 동작하려면 해당 엔티티에 `CollisionComponent`가 있어야 한다는 전제 조건을 강조.
- **충돌/물리**: `CollisionComponent`(충돌 감지용 shape), `PhysicsBodyComponent`(중력/질량 등 물리 시뮬레이션 참여 여부)의 역할 차이.
- **iOS AR 인터랙션 모델**: 화면 2D 터치 좌표 → 3D 공간 동작으로 매핑되는 간접적 상호작용.
- **visionOS 인터랙션 모델**: 시선(gaze)으로 대상을 지정하고 손가락 핀치(pinch)로 확정하는 간접 조작 방식 — 컨트롤러나 직접 터치가 없는 것이 iOS AR과의 근본적 차이. `SpatialTapGesture` 등 visionOS 전용 제스처 API 언급.
- **디자인 관점**: 두 플랫폼의 인터랙션 모델이 다르기 때문에 "같은 콘텐츠, 다른 상호작용 설계"가 필요하다는 점을 강조 (UX 설계 관심사와 연결).

## 코드 (실제로 작성 — `ARViewContainer.swift`의 `handleTap` 안, 박스 배치 코드 바로 뒤에 추가)

```swift
modelEntity.generateCollisionShapes(recursive: true)
arView.installGestures([.translation, .rotation, .scale], for: modelEntity)
```

`makeUIView`(또는 `Coordinator` 초기화 시 한 번)에 충돌 이벤트 구독 추가:

```swift
_ = arView.scene.subscribe(to: CollisionEvents.Began.self) { event in
    print("충돌 발생: \(event.entityA.name) - \(event.entityB.name)")
}
```

구독 결과(`Cancellable`)를 버리지 않도록 `Coordinator`에 `var collisionSubscription: Cancellable?` 프로퍼티를 만들어 보관하세요 (그렇지 않으면 즉시 해제되어 이벤트가 안 옵니다).

## 노트 구조

Day 1~5와 동일한 템플릿 유지.

## 퀴즈

이 3문제를 **객관식 4지선다**로, 한 번에 다 보여주지 말고 **한 문제씩** 진행하세요. **AskUserQuestion 도구를 사용해서 사용자가 방향키/클릭으로 보기 중 하나를 고를 수 있게 하세요** (대화창에 A~D 텍스트를 그냥 출력하고 타이핑으로 답하게 하지 마세요):

1. Q1을 AskUserQuestion으로 물어봅니다. `question`에는 문제 본문을, `options`에는 4개 보기를 `label`(짧게, 예: "A", "B"처럼 식별 가능하게 보기 핵심을 담아)과 `description`(보기 전문)으로 각각 담아 전달하세요. 정답을 먼저 알려주지 않습니다.
2. 사용자가 선택하면 정답 여부를 알려주되, 정답이든 오답이든 **왜 그런지, 다른 보기는 왜 아닌지**까지 피드백합니다 (단순 정오 통보로 끝내지 않기).
3. 이어서 Q2 → AskUserQuestion → 피드백, 마지막으로 Q3도 동일하게 진행합니다.
4. 세 문제가 모두 끝나면 다음 단계로 안내합니다.

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

UX/제품 디자인에 관심이 있다는 맥락이 있다면, 단순 API 설명을 넘어 "왜 이 인터랙션 모델이 더 나은가"에 대한 설계 논의로 확장해도 좋습니다.
