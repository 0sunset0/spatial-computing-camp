---
name: day4-realitykit-basics
description: Day 4 of the Spatial Computing 7-day camp. Teaches RealityKit fundamentals — the Entity-Component-System architecture, materials, lighting, and AnchorEntity — via a beginner-friendly, in-chat concept→code→quiz loop per concept (no note files), grounded in current Apple documentation, then codes the real SpatialCampApp Xcode project. Trigger this when the user runs /day4-realitykit-basics, has finished day3-arkit-advanced, or asks about RealityKit ECS, Entity, Component, materials, or AnchorEntity in the context of the spatial computing camp.
---

# Day 4 — RealityKit 기초

목표: ARKit이 인식한 공간 위에 실제로 3D 콘텐츠를 "그리는" RealityKit의 구조를 이해한다. Day 2의 `AnchorEntity(world:)` 코드가 여기서 이어진다.

## 프로젝트 규칙 (실제 Xcode 프로젝트에 코딩 — Day 2~3과 동일한 프로젝트를 이어서 사용)

`SpatialCampApp/Sources/SpatialCampApp/ARViewContainer.swift`를 이어서 수정합니다. 새 프로젝트를 만들지 마세요.

- `handleTap`에서 박스를 배치하던 부분(`SimpleMaterial` 박스)을 아래 "코드 (실제로 작성)" 내용으로 교체해, `PhysicallyBasedMaterial`을 쓰고 ECS 구조(엔티티/컴포넌트)를 더 명확히 보여주도록 다듬으세요.
- 수정 후 `xcodebuild -project SpatialCampApp.xcodeproj -scheme SpatialCampApp -destination 'generic/platform=iOS Simulator' build`로 컴파일 검증. `BUILD SUCCEEDED`까지 고치세요.
- 실제 재질/조명 변화는 **실기에서 Xcode로 빌드·실행**해야 눈으로 확인할 수 있다고 안내하세요.

## 진행 방식 (중요, 모든 Day 공통)

- **노트/대시보드 파일을 만들지 않습니다.** `SpatialCampNotes/*.md`, `00-dashboard.md` 같은 파일을 생성하지 마세요. 설명은 전부 대화창 출력으로 전달합니다 (단, `SpatialCampApp/` 실제 프로젝트 코드 파일은 이 규칙과 무관하게 정상적으로 작성/수정합니다).
- **개념 하나 설명 → 그 개념의 코드 설명 → 그 개념에 대응하는 퀴즈 1문항**을 AskUserQuestion으로 바로 진행하고, 다음 개념으로 넘어가며 반복하세요. 모든 개념을 다 설명한 뒤에 퀴즈를 몰아서 내지 마세요.
- **완전 초보자도 따라올 수 있게 설명하세요.** 전문 용어가 나오면 바로 정의하고, 비유를 적극 활용하세요.

## 트리거 시 할 일 (항상 이 순서: 개념→코드→퀴즈 반복 → 프로젝트에 실제 코딩)

1. **공식 문서 확인 (필수, 조용히 먼저 수행)**: `web_search` + `web_fetch`로 `Entity`, `Component`, `ModelComponent`, `AnchorEntity`, `RealityKit` 머티리얼(`PhysicallyBasedMaterial` 등) 관련 Apple 공식 문서(`developer.apple.com/documentation/realitykit`)를 실제로 열어 최신 API로 확인.
2. **핵심 개념을 하나씩 순서대로**: 개념 설명 → 관련 코드 설명(ECS 구조가 어떻게 조립되는지, 아직 파일에 쓰지 않음) → 그 개념에 대응하는 퀴즈 1문항(AskUserQuestion) → 피드백, 을 "다룰 핵심 개념"에 나열된 순서대로 반복합니다.
3. **프로젝트에 실제로 코딩** (모든 개념+퀴즈가 끝난 뒤): `handleTap`에서 박스를 배치하던 `SimpleMaterial` 부분을 설명한 `PhysicallyBasedMaterial` 코드로 교체.
4. `xcodebuild ... build`로 컴파일 검증 (위 "프로젝트 규칙" 참고). 성공/실패를 대화창에 보고.
5. 모든 게 끝나면, 사용자에게 "다음" 또는 "완료"라고 입력하면 Day 5로 넘어간다고 안내합니다. 사용자가 "다음"/"완료"(또는 유사 표현)로 응답하면, `/day5-realitykit-advanced` 슬래시 명령을 다시 요구하지 말고 **Skill 도구로 `day5-realitykit-advanced`를 직접 호출**하세요.

## 다룰 핵심 개념

- **ECS(Entity-Component-System)**: RealityKit의 핵심 설계. `Entity`는 빈 컨테이너, `Component`가 실제 데이터(위치, 모델, 물리 등)를 담고, System이 매 프레임 컴포넌트를 처리. 게임 엔진에서 흔한 패턴임을 언급.
- **Entity 종류**: `ModelEntity`(시각적 메시를 가진 엔티티), `AnchorEntity`(공간의 특정 지점에 고정되는 루트 엔티티).
- **Component 종류**: `ModelComponent`(geometry + material), `Transform`, `PhysicsBodyComponent`, `CollisionComponent` 등.
- **머티리얼**: `SimpleMaterial`(빠른 프로토타이핑용) vs `PhysicallyBasedMaterial`(PBR, 실제감 있는 렌더링용) 차이.
- **조명**: RealityKit의 기본 환경광(IBL, Image-Based Lighting) 개념과 커스텀 라이트 엔티티.
- **씬 계층 구조**: `AnchorEntity`를 루트로 자식 엔티티들을 붙여나가는 트리 구조.

## 코드 (실제로 작성 — `ARViewContainer.swift`의 `handleTap` 내부 박스 배치 부분을 교체)

```swift
@objc func handleTap(_ recognizer: UITapGestureRecognizer) {
    guard let arView = arView else { return }
    let tapLocation = recognizer.location(in: arView)

    let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
    guard let firstResult = results.first else {
        print("탭한 위치에서 평면을 찾지 못했습니다")
        return
    }

    var material = PhysicallyBasedMaterial()
    material.baseColor = .init(tint: .white)
    material.roughness = .init(floatLiteral: 0.3)
    material.metallic = .init(floatLiteral: 0.8)

    let mesh = MeshResource.generateBox(size: 0.1)
    let modelEntity = ModelEntity(mesh: mesh, materials: [material])

    let anchorEntity = AnchorEntity(world: firstResult.worldTransform)
    anchorEntity.addChild(modelEntity)
    arView.scene.addAnchor(anchorEntity)
}
```

기존 `SimpleMaterial(color: .systemBlue, isMetallic: false)` 박스 코드를 이 `PhysicallyBasedMaterial` 버전으로 바꿔치기하세요. `Entity`(ModelEntity/AnchorEntity)와 `Component`(ModelComponent 역할을 하는 mesh+materials)가 어떻게 조립되는지 대화창에서 짚어주세요.

## 퀴즈

아래 3문제는 각각 대응하는 개념 설명 **직후 바로** 진행하세요 (Q1→ECS 개념 뒤, Q2→머티리얼 개념 뒤, Q3→AnchorEntity 개념 뒤). 모든 개념 설명이 끝날 때까지 기다렸다가 한꺼번에 몰아서 내지 마세요. **객관식 4지선다**로, **AskUserQuestion 도구를 사용해서 사용자가 방향키/클릭으로 보기 중 하나를 고를 수 있게 하세요** (대화창에 A~D 텍스트를 그냥 출력하고 타이핑으로 답하게 하지 마세요):

1. 해당 개념 설명이 끝나면 그 자리에서 AskUserQuestion으로 물어봅니다. `question`에는 문제 본문을, `options`에는 4개 보기를 `label`(짧게, 예: "A", "B"처럼 식별 가능하게 보기 핵심을 담아)과 `description`(보기 전문)으로 각각 담아 전달하세요. 정답을 먼저 알려주지 않습니다.
2. 사용자가 선택하면 정답 여부를 알려주되, 정답이든 오답이든 **왜 그런지, 다른 보기는 왜 아닌지**까지 피드백합니다 (단순 정오 통보로 끝내지 않기).
3. 피드백 후 바로 다음 개념 설명으로 넘어가고, 그 개념이 끝나면 다음 문제를 동일하게 진행합니다.

아래 정답 표시는 채점 참고용이며 **AskUserQuestion의 옵션에는 넣지 말고, 사용자에게 먼저 노출하지도 마세요**:

```
Q1. Entity, Component, System의 역할을 가장 정확히 짝지은 것은?
A. Entity=로직, Component=데이터, System=오브젝트
B. Entity=씬의 오브젝트(컨테이너), Component=데이터/특성, System=해당 Component를 가진 Entity들에 동작하는 로직
C. 셋 다 동일한 역할이며 이름만 다르다.
D. Entity=렌더링 엔진, Component=씬 그래프, System=물리 엔진
(정답: B)

Q2. SimpleMaterial과 PhysicallyBasedMaterial은 언제 각각 쓰는 게 좋을까요?
A. SimpleMaterial은 항상 프로덕션에, PhysicallyBasedMaterial은 프로토타입에만 써야 한다.
B. SimpleMaterial은 빠른 프로토타이핑/단순 색상 표현에, PhysicallyBasedMaterial은 사실적인 금속성·거칠기 등 물리 기반 렌더링이 필요할 때 쓴다.
C. 두 머티리얼은 기능이 완전히 동일하다.
D. PhysicallyBasedMaterial은 visionOS에서만 사용 가능하다.
(정답: B)

Q3. AnchorEntity는 왜 필요할까요? ARAnchor와의 관계는?
A. AnchorEntity는 ARAnchor를 대체하는 완전히 새로운 개념으로 서로 무관하다.
B. AnchorEntity는 RealityKit에서 ARAnchor(또는 평면/이미지 등 트래킹 대상)를 씬 그래프에 연결해, 그 위치에 엔티티들을 붙일 수 있게 해주는 다리 역할을 한다.
C. ARAnchor가 AnchorEntity의 렌더링을 담당한다.
D. AnchorEntity는 오직 수동 좌표 입력으로만 생성할 수 있다.
(정답: B)
```

## 톤

완전 초보자도 따라올 수 있게 설명하는 것을 우선하세요. 전문 용어는 등장할 때 바로 풀어서 정의하고, 비유를 적극 활용하세요. ZupZup 프로젝트의 ECS 패턴 경험이 있다면 기본 설명 이후에 자연스럽게 연결해도 좋습니다.
