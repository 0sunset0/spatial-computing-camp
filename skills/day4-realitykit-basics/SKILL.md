---
name: day4-realitykit-basics
description: Day 4 of the Spatial Computing 7-day camp. Teaches RealityKit fundamentals — the Entity-Component-System architecture, materials, lighting, and AnchorEntity — with Swift code examples grounded in current Apple documentation, then generates a Day 4 study note and checkpoint quiz. Trigger this when the user runs /day4-realitykit-basics, has finished day3-arkit-advanced, or asks about RealityKit ECS, Entity, Component, materials, or AnchorEntity in the context of the spatial computing camp.
---

# Day 4 — RealityKit 기초

목표: ARKit이 인식한 공간 위에 실제로 3D 콘텐츠를 "그리는" RealityKit의 구조를 이해한다. Day 2의 `AnchorEntity(world:)` 코드가 여기서 이어진다.

## 트리거 시 할 일

1. `SpatialCampNotes/day4-realitykit-basics.md` 생성.
2. **공식 문서 확인 (필수)**: `web_search` + `web_fetch`로 `Entity`, `Component`, `ModelComponent`, `AnchorEntity`, `RealityKit` 머티리얼(`PhysicallyBasedMaterial` 등) 관련 Apple 공식 문서(`developer.apple.com/documentation/realitykit`)를 실제로 열어 최신 API로 검증 후 작성.
3. 핵심 개념 + 코드 예제를 대화창에 설명.
4. 체크포인트 퀴즈 진행.
5. `00-dashboard.md`의 Day 4 상태 갱신.

## 다룰 핵심 개념

- **ECS(Entity-Component-System)**: RealityKit의 핵심 설계. `Entity`는 빈 컨테이너, `Component`가 실제 데이터(위치, 모델, 물리 등)를 담고, System이 매 프레임 컴포넌트를 처리. 게임 엔진에서 흔한 패턴임을 언급.
- **Entity 종류**: `ModelEntity`(시각적 메시를 가진 엔티티), `AnchorEntity`(공간의 특정 지점에 고정되는 루트 엔티티).
- **Component 종류**: `ModelComponent`(geometry + material), `Transform`, `PhysicsBodyComponent`, `CollisionComponent` 등.
- **머티리얼**: `SimpleMaterial`(빠른 프로토타이핑용) vs `PhysicallyBasedMaterial`(PBR, 실제감 있는 렌더링용) 차이.
- **조명**: RealityKit의 기본 환경광(IBL, Image-Based Lighting) 개념과 커스텀 라이트 엔티티.
- **씬 계층 구조**: `AnchorEntity`를 루트로 자식 엔티티들을 붙여나가는 트리 구조.

## 코드 예제 (fetch한 최신 문서로 검증 후 작성)

기본 박스 엔티티 배치 (Day 2의 raycast 결과 앵커에 이어서):

```swift
let mesh = MeshResource.generateBox(size: 0.1)
let material = SimpleMaterial(color: .systemBlue, isMetallic: false)
let modelEntity = ModelEntity(mesh: mesh, materials: [material])

let anchorEntity = AnchorEntity(world: firstResult.worldTransform)
anchorEntity.addChild(modelEntity)
arView.scene.addAnchor(anchorEntity)
```

PBR 머티리얼 예제:

```swift
var material = PhysicallyBasedMaterial()
material.baseColor = .init(tint: .white)
material.roughness = .init(floatLiteral: 0.3)
material.metallic = .init(floatLiteral: 0.8)
```

## 노트 구조

Day 1~3과 동일한 템플릿 유지 (목표 → 핵심 개념 → 코드 → 한 줄 정리 → 퀴즈 → 참고 자료 → 다음 단계).

## 퀴즈

```
Q1. Entity, Component, System의 역할을 각각 한 문장으로 설명해보세요.
Q2. SimpleMaterial과 PhysicallyBasedMaterial은 언제 각각 쓰는 게 좋을까요?
Q3. AnchorEntity는 왜 필요할까요? ARAnchor와의 관계는?
```

## 톤

ZupZup 프로젝트의 ECS 패턴 경험이 있다면 자연스럽게 연결하되, 처음 배우는 사람도 이해할 수 있게 설명하세요.
