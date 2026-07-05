---
name: day4-realitykit-basics
description: Day 4 of the Spatial Computing 7-day camp. Teaches RealityKit fundamentals — the Entity-Component-System architecture, materials, lighting, and AnchorEntity — via a beginner-friendly, in-chat concept→code→quiz loop per concept (no note files), grounded in current Apple documentation, then codes the real SpatialCampApp Xcode project. Trigger this when the user runs /day4-realitykit-basics, has finished day3-arkit-advanced, or asks about RealityKit ECS, Entity, Component, materials, or AnchorEntity in the context of the spatial computing camp.
---

# Day 4 — RealityKit 기초

목표: ARKit이 인식한 공간 위에 실제로 3D 콘텐츠를 "그리는" RealityKit의 구조를 이해한다. Day 2의 `AnchorEntity(world:)` 코드가 여기서 이어진다.

## 프로젝트 규칙 (실제 Xcode 프로젝트에 코딩 — Day 2~3과 동일한 프로젝트를 이어서 사용)

`SpatialCampApp/Sources/SpatialCampApp/ARViewContainer.swift`를 이어서 수정합니다. 새 프로젝트를 만들지 마세요.

- `handleTap`에서 박스를 배치하던 부분(`SimpleMaterial` 박스)을 아래 "코드 (실제로 작성)" 내용으로 교체해, `PhysicallyBasedMaterial`을 쓰고 ECS 구조(엔티티/컴포넌트)를 더 명확히 보여주도록 다듬으세요. 이때 mesh도 `generateBox`에서 `generateSphere`로 바꾸세요 (아래 "주의" 참고 — 큐브는 하이라이트가 잘 안 보입니다).
- 수정 후 `xcodebuild -project SpatialCampApp.xcodeproj -scheme SpatialCampApp -destination 'generic/platform=iOS Simulator' build`로 컴파일 검증. `BUILD SUCCEEDED`까지 고치세요.
- 실제 재질/조명 변화는 **실기에서 Xcode로 빌드·실행**해야 눈으로 확인할 수 있다고 안내하세요. `metallic`은 `0.0`으로 유지하세요 — 환경 반사를 별도로 연결하지 않으면 금속 재질은 반사할 게 없어 그냥 회색으로 보입니다 (아래 "주의" 참고).

## 진행 방식 (중요, 모든 Day 공통)

- **노트/대시보드 파일을 만들지 않습니다.** `SpatialCampNotes/*.md`, `00-dashboard.md` 같은 파일을 생성하지 마세요. 설명은 전부 대화창 출력으로 전달합니다 (단, `SpatialCampApp/` 실제 프로젝트 코드 파일은 이 규칙과 무관하게 정상적으로 작성/수정합니다).
- **개념 설명 → 퀴즈 → 프로젝트 코드로 확인, 이 세 단계를 한 세트로 묶어서 반복하세요.** 개념 하나를 설명하고, 그 개념에 대응하는 퀴즈 1문항(AskUserQuestion)을 바로 진행하고, 피드백을 준 다음, **그 개념에 해당하는 코드만** 실제 프로젝트 파일에 반영하고 `xcodebuild`로 컴파일까지 확인하세요. 모든 개념을 다 설명한 뒤에 퀴즈나 코드를 몰아서 하지 마세요.
- **컴파일 성공만으로 다음 개념으로 넘어가지 마세요.** 시뮬레이터 빌드가 성공하면, 사용자에게 "실기(아이폰/아이패드)에서 Xcode로 직접 빌드·실행해서 이 기능이 실제로 동작하는지 확인해보세요"라고 안내하고, 사용자가 빌드해봤는지·어떻게 됐는지 답할 때까지 기다리세요. 사용자가 답하면 그 응답을 반영하고 나서 다음 개념으로 넘어가세요.
- **프로젝트 파일을 고치기 전에는 항상 "지금부터 무엇을, 왜 작성할지" 한두 문장으로 먼저 말하세요.** `handleTap` 전체를 한 번에 갈아엎지 말고, 아래 3단계로 나눠서 조금씩 바꾸세요.
- **완전 초보자도 따라올 수 있게 설명하세요.** 전문 용어가 나오면 바로 정의하고, 비유를 적극 활용하세요.

## 트리거 시 할 일 (항상 이 순서: [개념 → 퀴즈 → 코드로 확인]을 개념별로 반복)

1. **공식 문서 확인 (필수, 조용히 먼저 수행)**: `web_search` + `web_fetch`로 `Entity`, `Component`, `ModelComponent`, `AnchorEntity`, `RealityKit` 머티리얼(`PhysicallyBasedMaterial` 등) 관련 Apple 공식 문서(`developer.apple.com/documentation/realitykit`)를 실제로 열어 최신 API로 확인.
2. **개념 1 — ECS(Entity/Component/System)**: 개념 설명 → 퀴즈 1(AskUserQuestion) → 피드백 → "이제 오브젝트의 mesh를 별도 변수로 분리해서 Entity가 어떻게 조립되는지 보여드리겠습니다"라고 말한 뒤 `handleTap`에서 `let mesh = MeshResource.generateSphere(radius: 0.05)`(기존 `generateBox` 대신 구 사용 — 아래 "주의" 참고)를 분리하고 `ModelEntity(mesh:, materials:)`로 조립하는 부분만 반영(재질은 아직 기존 `SimpleMaterial` 유지) → `xcodebuild ... build`로 확인.
3. **개념 2 — 머티리얼(SimpleMaterial vs PhysicallyBasedMaterial)**: 개념 설명 → 퀴즈 2 → 피드백 → "이제 재질을 PhysicallyBasedMaterial로 바꾸겠습니다"라고 말한 뒤 `material` 변수(`baseColor`/`roughness`/`metallic`)를 추가하고 `ModelEntity`가 이 재질을 쓰도록 교체 → `xcodebuild ... build`로 확인. **`metallic`은 반드시 `0.0`으로 두세요** (위 "주의" 참고 — 환경 반사 연결 없이 `metallic`을 높이면 그냥 회색으로 보이는 흔한 함정이 있습니다). 실기 확인을 안내할 때도 "금속처럼 반짝인다"가 아니라 "매끈한 흰색 플라스틱처럼 은은한 광택이 도는지, 조명이 있는 쪽으로 폰을 움직이면 하이라이트가 움직이는지" 확인해보라고 안내하세요.
4. **개념 3 — AnchorEntity와 씬 계층 구조**: 개념 설명 → 퀴즈 3 → 피드백 → "이제 이 엔티티가 실제 공간 앵커에 어떻게 연결되는지 확인해보겠습니다"라고 말한 뒤 기존 `AnchorEntity(world:)` → `addChild` → `scene.addAnchor` 흐름을 대화창에서 짚어주며 필요하면 다듬고 → 최종 `xcodebuild ... build`로 확인.
5. 성공/실패를 대화창에 보고 (실패하면 사용자에게 보고하기 전에 먼저 고칠 것).
6. 모든 게 끝나면, 사용자에게 "다음" 또는 "완료"라고 입력하면 Day 5로 넘어간다고 안내합니다. 사용자가 "다음"/"완료"(또는 유사 표현)로 응답하면, `/day5-realitykit-advanced` 슬래시 명령을 다시 요구하지 말고 **Skill 도구로 `day5-realitykit-advanced`를 직접 호출**하세요.

## 다룰 핵심 개념

- **ECS(Entity-Component-System)**: RealityKit의 핵심 설계. `Entity`는 빈 컨테이너, `Component`가 실제 데이터(위치, 모델, 물리 등)를 담고, System이 매 프레임 컴포넌트를 처리. 게임 엔진에서 흔한 패턴임을 언급.
- **Entity 종류**: `ModelEntity`(시각적 메시를 가진 엔티티), `AnchorEntity`(공간의 특정 지점에 고정되는 루트 엔티티).
- **Component 종류**: `ModelComponent`(geometry + material), `Transform`, `PhysicsBodyComponent`, `CollisionComponent` 등.
- **머티리얼**: `SimpleMaterial`(빠른 프로토타이핑용) vs `PhysicallyBasedMaterial`(PBR, 실제감 있는 렌더링용) 차이.
- **주의 (실제로 겪는 흔한 함정)**: `ARView`는 기본적으로 실제 카메라로 보는 방을 반사 재질에 자동으로 연결해주지 않습니다 — `environmentTexturing = .automatic`을 켜도 ARKit이 환경 프로브(`AREnvironmentProbeAnchor`)만 만들 뿐, 이걸 `arView.environment.lighting.resource`에 직접 연결해야 반사가 생깁니다. 그래서 `metallic`을 높게 주면 반사할 게 없어 그냥 회색으로 보입니다 ([Apple 공식 문서](https://developer.apple.com/documentation/realitykit/applying-realistic-material-and-lighting-effects-to-entities), [개발자 포럼](https://forums.developer.apple.com/forums/thread/763481)). 이 프로젝트에서는 환경 프로브 연결까지는 다루지 않고, `metallic`을 0으로 두고 `roughness`만 낮춰서 ARKit의 실시간 조명 추정만으로 자연스러운 광택(글로시 플라스틱 느낌)을 보여주는 것으로 범위를 제한합니다.
- **주의 (모양도 하이라이트에 영향을 줍니다)**: 큐브(평평한 면)는 빛-표면-카메라의 반사각이 정확히 맞아야만 하이라이트가 보여서, 바닥에 놓인 박스 윗면(항상 하늘을 향함)과 손에 든 폰의 비스듬한 시야각이 우연히 맞지 않으면 광택이 거의 안 보입니다. 구(둥근 면)는 표면이 사방으로 굽어 있어 거의 모든 각도에서 표면 어딘가는 반사각이 맞아떨어지므로 하이라이트가 훨씬 안정적으로 보입니다. 그래서 이 프로젝트는 `generateBox` 대신 `generateSphere`를 씁니다.
- **조명**: RealityKit의 기본 환경광(IBL, Image-Based Lighting) 개념과 커스텀 라이트 엔티티.
- **씬 계층 구조**: `AnchorEntity`를 루트로 자식 엔티티들을 붙여나가는 트리 구조.

## 코드 (실제로 작성 — `ARViewContainer.swift`의 `handleTap` 내부 박스 배치 부분을 교체)

아래는 완성된 전체 코드입니다. **한 번에 다 쓰지 말고** 위 "트리거 시 할 일"에서 설명한 대로 3단계로 나눠서 작성하세요: (1) `mesh`/`modelEntity` 분리(재질은 기존 것 유지) → (2) `material`(PhysicallyBasedMaterial) 도입 → (3) `AnchorEntity`/씬 연결 확인.

```swift
@objc func handleTap(_ recognizer: UITapGestureRecognizer) {
    guard let arView = arView else { return }
    let tapLocation = recognizer.location(in: arView)

    let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
    guard let firstResult = results.first else {
        print("탭한 위치에서 평면을 찾지 못했습니다")
        return
    }

    // metallic은 0으로 둡니다 — ARView는 실제 방을 반사 재질에 자동으로 연결해주지 않아서
    // (별도로 AREnvironmentProbeAnchor를 잡아 연결해야 함), metallic을 높게 주면 반사할 게
    // 없어 그냥 회색으로 보입니다. 낮은 roughness로 실시간 조명 추정만으로 광택을 보여줍니다.
    var material = PhysicallyBasedMaterial()
    material.baseColor = .init(tint: .white)
    material.roughness = .init(floatLiteral: 0.2)
    material.metallic = .init(floatLiteral: 0.0)

    // 큐브(평평한 면)는 카메라 각도가 반사각과 정확히 맞아야만 하이라이트가 보여서
    // 손에 든 폰 각도로는 잘 안 보입니다. 구는 표면이 둥글게 굽어 있어 거의 모든
    // 각도에서 하이라이트가 보이므로, 재질 테스트에는 구가 훨씬 적합합니다.
    let mesh = MeshResource.generateSphere(radius: 0.05)
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

완전 초보자도 따라올 수 있게 설명하는 것을 우선하세요. 전문 용어는 등장할 때 바로 풀어서 정의하고, 비유를 적극 활용하세요. 사용자가 게임 엔진 등 다른 ECS 기반 프로젝트 경험이 있다면 기본 설명 이후에 자연스럽게 연결해도 좋습니다.

**가독성**: 긴 문단보다 표를 우선하세요. 두 가지 이상을 비교하는 내용(예: SimpleMaterial vs PhysicallyBasedMaterial)은 마크다운 표로 정리하고, 코드를 줄 단위로 설명할 때도 "코드 조각 | 설명" 형태의 표를 쓰세요. 불릿은 표로 담기 어려운 짧은 요약에만 사용하세요.
