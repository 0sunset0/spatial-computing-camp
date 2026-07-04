---
name: day6-interaction-gesture
description: Day 6 of the Spatial Computing 7-day camp. Teaches interaction design for spatial apps — RealityKit gestures (tap/drag/rotate), collision and physics, and visionOS gaze-and-pinch interaction concepts — with Swift code examples grounded in current Apple documentation, then generates a Day 6 study note and checkpoint quiz. Trigger this when the user runs /day6-interaction-gesture, has finished day5-realitykit-advanced, or asks about AR gestures, RealityKit collisions, or visionOS interaction models in the context of the spatial computing camp.
---

# Day 6 — 상호작용 / 제스처

목표: 지금까지 만든 콘텐츠를 사용자가 실제로 "만질 수 있게" 만든다. iOS AR의 터치 기반 제스처와, visionOS의 시선+손짓 기반 인터랙션 패러다임을 함께 다룬다.

## 트리거 시 할 일

1. `SpatialCampNotes/day6-interaction-gesture.md` 생성.
2. **공식 문서 확인 (필수)**: `web_search` + `web_fetch`로 RealityKit 제스처(`EntityGestureRecognizer` 관련 API, `.installGestures()`), `CollisionComponent`, `PhysicsBodyComponent`, visionOS 인터랙션(`SpatialTapGesture`, 시선+핀치 모델) 관련 Apple 공식 문서를 실제로 열어 최신 API로 검증 후 작성.
3. 핵심 개념 + 코드 예제를 대화창에 설명.
4. 체크포인트 퀴즈 진행.
5. `00-dashboard.md`의 Day 6 상태 갱신.

## 다룰 핵심 개념

- **RealityKit 제스처**: 엔티티에 탭/드래그/회전/핀치 제스처를 붙이는 방법. 제스처가 동작하려면 해당 엔티티에 `CollisionComponent`가 있어야 한다는 전제 조건을 강조.
- **충돌/물리**: `CollisionComponent`(충돌 감지용 shape), `PhysicsBodyComponent`(중력/질량 등 물리 시뮬레이션 참여 여부)의 역할 차이.
- **iOS AR 인터랙션 모델**: 화면 2D 터치 좌표 → 3D 공간 동작으로 매핑되는 간접적 상호작용.
- **visionOS 인터랙션 모델**: 시선(gaze)으로 대상을 지정하고 손가락 핀치(pinch)로 확정하는 간접 조작 방식 — 컨트롤러나 직접 터치가 없는 것이 iOS AR과의 근본적 차이. `SpatialTapGesture` 등 visionOS 전용 제스처 API 언급.
- **디자인 관점**: 두 플랫폼의 인터랙션 모델이 다르기 때문에 "같은 콘텐츠, 다른 상호작용 설계"가 필요하다는 점을 강조 (UX 설계 관심사와 연결).

## 코드 예제 (fetch한 최신 문서로 검증 후 작성)

엔티티에 제스처 활성화 (초안 — 실제 API는 fetch한 문서 기준으로 보정):

```swift
modelEntity.generateCollisionShapes(recursive: true)
arView.installGestures([.translation, .rotation, .scale], for: modelEntity)
```

충돌 이벤트 구독:

```swift
arView.scene.subscribe(to: CollisionEvents.Began.self) { event in
    print("충돌 발생: \(event.entityA.name) - \(event.entityB.name)")
}
```

## 노트 구조

Day 1~5와 동일한 템플릿 유지.

## 퀴즈

```
Q1. 제스처가 동작하려면 엔티티에 어떤 컴포넌트가 먼저 필요할까요?
Q2. CollisionComponent와 PhysicsBodyComponent의 차이는?
Q3. iOS AR과 visionOS의 인터랙션 모델 차이를 한 문장으로 요약해보세요.
```

## 톤

UX/제품 디자인에 관심이 있다는 맥락이 있다면, 단순 API 설명을 넘어 "왜 이 인터랙션 모델이 더 나은가"에 대한 설계 논의로 확장해도 좋습니다.
