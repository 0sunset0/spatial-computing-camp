---
name: day5-realitykit-advanced
description: Day 5 of the Spatial Computing 7-day camp. Teaches advanced RealityKit topics — particle systems, animation, and CoreHaptics integration — via a beginner-friendly, in-chat concept→code→quiz loop per concept (no note files), grounded in current Apple documentation, then codes the real SpatialCampApp Xcode project. Trigger this when the user runs /day5-realitykit-advanced, has finished day4-realitykit-basics, or asks about RealityKit particles, animation, or haptics integration in the context of the spatial computing camp.
---

# Day 5 — RealityKit 심화

목표: 콘텐츠를 "살아있게" 만드는 파티클, 애니메이션, 햅틱을 다룬다. ZupZup 프로젝트의 실제 경험(파티클, CoreHaptics)과 가장 밀접한 날.

## 프로젝트 규칙 (실제 Xcode 프로젝트에 코딩 — Day 2~4와 동일한 프로젝트를 이어서 사용)

`SpatialCampApp/Sources/SpatialCampApp/ARViewContainer.swift`를 이어서 수정합니다.

- `handleTap`에서 박스를 배치한 뒤, 아래 "코드 (실제로 작성)"의 파티클 컴포넌트 + CoreHaptics 트리거를 추가하세요 (박스에 파티클을 붙이고, 배치 순간 햅틱도 함께 재생).
- `import CoreHaptics`를 파일 상단에 추가해야 합니다.
- 수정 후 `xcodebuild -project SpatialCampApp.xcodeproj -scheme SpatialCampApp -destination 'generic/platform=iOS Simulator' build`로 컴파일 검증. `BUILD SUCCEEDED`까지 고치세요 (시뮬레이터는 햅틱을 재생하지 못하지만 컴파일은 확인 가능).
- 파티클과 햅틱은 **실기에서 Xcode로 빌드·실행**해야 실제로 느껴진다고 안내하세요.

## 진행 방식 (중요, 모든 Day 공통)

- **노트/대시보드 파일을 만들지 않습니다.** `SpatialCampNotes/*.md`, `00-dashboard.md` 같은 파일을 생성하지 마세요. 설명은 전부 대화창 출력으로 전달합니다 (단, `SpatialCampApp/` 실제 프로젝트 코드 파일은 이 규칙과 무관하게 정상적으로 작성/수정합니다).
- **개념 설명 → 퀴즈 → 프로젝트 코드로 확인, 이 세 단계를 한 세트로 묶어서 반복하세요.** 개념을 설명하고, 대응하는 퀴즈 1문항(AskUserQuestion)을 바로 진행하고, 피드백을 준 다음, **그 개념에 해당하는 코드만** 실제 프로젝트 파일에 반영하고 `xcodebuild`로 컴파일까지 확인하세요. 모든 개념을 다 설명한 뒤에 퀴즈나 코드를 몰아서 하지 마세요.
- **컴파일 성공만으로 다음으로 넘어가지 마세요.** 시뮬레이터 빌드가 성공하면(시뮬레이터는 햅틱을 재생하지 못함을 유의), 사용자에게 "실기(아이폰/아이패드)에서 Xcode로 직접 빌드·실행해서 파티클과 진동이 실제로 느껴지는지 확인해보세요"라고 안내하고, 사용자가 빌드해봤는지·어떻게 됐는지 답할 때까지 기다리세요. 사용자가 답하면 그 응답을 반영하고 나서 다음으로 넘어가세요.
- **프로젝트 파일을 고치기 전에는 항상 "지금부터 무엇을, 왜 작성할지" 한두 문장으로 먼저 말하세요.** 코드를 큰 덩어리로 한 번에 다 넣지 말고, 작은 단위로 나눠서 하나씩 진행하세요.
- **완전 초보자도 따라올 수 있게 설명하세요.** 전문 용어가 나오면 바로 정의하고, 비유를 적극 활용하세요.

## 트리거 시 할 일 (항상 이 순서: [개념 → 퀴즈 → 코드로 확인]을 개념별로 반복)

1. **공식 문서 확인 (필수, 조용히 먼저 수행)**: `web_search` + `web_fetch`로 `ParticleEmitterComponent`, RealityKit 애니메이션(`Transform` 애니메이션, `AnimationResource`), `CoreHaptics`(`CHHapticEngine`) 관련 Apple 공식 문서를 실제로 열어 최신 API로 확인. RealityKit 파티클 API는 상대적으로 최근에 추가된 영역이라 특히 최신 문서 확인이 중요함을 유의.
2. **개념 1 — 파티클 + CoreHaptics + 동기화 패턴**: ParticleEmitterComponent, CoreHaptics 연동, "왜 둘의 타이밍을 맞춰야 하는지"를 함께 설명 → 퀴즈 1(AskUserQuestion) → 피드백 → 코드는 두 단계로 나눠 반영:
   a. "먼저 CoreHaptics 임포트와 햅틱 엔진 설정부터 추가하겠습니다"라고 말한 뒤 `import CoreHaptics` + `Coordinator`의 햅틱 엔진 프로퍼티/`prepareHaptics()`/`playPlacementHaptic()` 메서드 + `makeUIView`에서 `prepareHaptics()` 호출을 추가 → `xcodebuild ... build`로 확인.
   b. "이제 파티클 컴포넌트와 햅틱 트리거를 함께 추가하겠습니다"라고 말한 뒤 `handleTap`에 `ParticleEmitterComponent` 설정 + `playPlacementHaptic()` 호출 + 상태 문구 갱신을 추가 → `xcodebuild ... build`로 확인.
3. **개념 2 — 성능 튜닝**: 개념 설명 → 퀴즈 2 → 피드백 → 새 기능을 추가하기보다, 방금 넣은 `birthRate`/`lifeSpan` 값을 함께 검토하며 "파티클·애니메이션이 많아지면 왜 부하가 커지는지" 짚어주고 필요하면 값을 조정 → `xcodebuild ... build`로 확인.
4. **개념 3 — 애니메이션(Transform vs 스켈레탈)**: 개념 설명 → 퀴즈 3 → 피드백. 이 프로젝트에는 아직 애니메이션 코드를 추가하지 않으니(향후 확장 여지로 언급), 코드 변경 없이 최종 `xcodebuild ... build`로 전체 컴파일을 한 번 더 확인.
5. 성공/실패를 대화창에 보고 (실패하면 사용자에게 보고하기 전에 먼저 고칠 것).
6. 모든 게 끝나면, 사용자에게 "다음" 또는 "완료"라고 입력하면 Day 6으로 넘어간다고 안내합니다. 사용자가 "다음"/"완료"(또는 유사 표현)로 응답하면, `/day6-interaction-gesture` 슬래시 명령을 다시 요구하지 말고 **Skill 도구로 `day6-interaction-gesture`를 직접 호출**하세요.

## 다룰 핵심 개념

- **ParticleEmitterComponent**: RealityKit 내장 파티클 시스템. 방출 모양, 속도, 수명, 색상/텍스처 등을 코드나 Reality Composer Pro로 설정.
- **애니메이션**: `Transform` 보간 애니메이션(이동/회전/스케일), `AnimationResource`를 통한 스켈레탈/블렌드셰이프 애니메이션 재생.
- **CoreHaptics 연동**: RealityKit 자체는 햅틱을 직접 제공하지 않으므로, `CHHapticEngine`을 별도로 구성해 시각적 이벤트(파티클 발생, 충돌 등)와 타이밍을 맞춰 트리거하는 패턴.
- **동기화 패턴**: "파티클 시작 시점 + 햅틱 트리거 시점"을 맞추는 것이 체감 품질에 큰 영향을 준다는 설계 관점 강조 (ZupZup에서 노을님이 실제로 다룬 영역).

## 코드 (실제로 작성 — `ARViewContainer.swift`)

아래는 완성된 전체 코드입니다. **한 번에 다 쓰지 말고** 위 "트리거 시 할 일"의 2a → 2b 순서로 나눠서 작성하세요.

파일 상단 import에 `CoreHaptics` 추가:

```swift
import SwiftUI
import RealityKit
import ARKit
import CoreHaptics
```

`Coordinator`에 햅틱 엔진 프로퍼티와 준비 메서드 추가:

```swift
class Coordinator: NSObject, ARSessionDelegate {
    weak var arView: ARView?
    var hapticEngine: CHHapticEngine?

    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        hapticEngine = try? CHHapticEngine()
        try? hapticEngine?.start()
    }

    func playPlacementHaptic() {
        guard let engine = hapticEngine else { return }
        let event = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
            relativeTime: 0
        )
        guard let pattern = try? CHHapticPattern(events: [event], parameters: []),
              let player = try? engine.makePlayer(with: pattern) else { return }
        try? player.start(atTime: CHHapticTimeImmediate)
    }
    // ... 기존 session(_:didAdd:) 는 그대로 유지
}
```

`makeUIView`에서 `context.coordinator.prepareHaptics()` 호출을 추가하고, `handleTap`의 박스 배치 코드 뒤에 파티클 + 햅틱 트리거를 추가:

```swift
var particles = ParticleEmitterComponent()
particles.emitterShape = .sphere
particles.birthRate = 200
particles.mainEmitter.lifeSpan = 1.5
particles.mainEmitter.color = .constant(.single(.systemPink))
modelEntity.components.set(particles)

playPlacementHaptic()
status.statusText = "배치 완료! 파티클과 진동이 동시에 느껴지는지 확인해보세요"
```

(`playPlacementHaptic()`은 `Coordinator` 안의 메서드이므로 `handleTap`이 `Coordinator`의 메서드라면 `self.playPlacementHaptic()`으로 호출)

## 퀴즈

아래 3문제는 각각 대응하는 개념 설명 **직후 바로** 진행하세요 (Q1→파티클+햅틱 동기화 개념 뒤, Q2→파티클/애니메이션 성능 개념 뒤, Q3→Transform vs 스켈레탈 애니메이션 개념 뒤). 모든 개념 설명이 끝날 때까지 기다렸다가 한꺼번에 몰아서 내지 마세요. **객관식 4지선다**로, **AskUserQuestion 도구를 사용해서 사용자가 방향키/클릭으로 보기 중 하나를 고를 수 있게 하세요** (대화창에 A~D 텍스트를 그냥 출력하고 타이핑으로 답하게 하지 마세요):

1. 해당 개념 설명이 끝나면 그 자리에서 AskUserQuestion으로 물어봅니다. `question`에는 문제 본문을, `options`에는 4개 보기를 `label`(짧게, 예: "A", "B"처럼 식별 가능하게 보기 핵심을 담아)과 `description`(보기 전문)으로 각각 담아 전달하세요. 정답을 먼저 알려주지 않습니다.
2. 사용자가 선택하면 정답 여부를 알려주되, 정답이든 오답이든 **왜 그런지, 다른 보기는 왜 아닌지**까지 피드백합니다 (단순 정오 통보로 끝내지 않기).
3. 피드백 후 바로 다음 개념 설명으로 넘어가고, 그 개념이 끝나면 다음 문제를 동일하게 진행합니다.

아래 정답 표시는 채점 참고용이며 **AskUserQuestion의 옵션에는 넣지 말고, 사용자에게 먼저 노출하지도 마세요**:

```
Q1. RealityKit 파티클을 트리거하는 것과 CoreHaptics 진동을 동시에 발생시키려면 어떤 구조가 필요할까요?
A. 파티클과 햅틱은 자동으로 동기화되므로 별도 구조가 필요 없다.
B. 공통 트리거(제스처/충돌 이벤트 등)에서 ParticleEmitterComponent를 활성화함과 동시에 CHHapticEngine으로 햅틱 패턴을 재생하도록 이벤트 핸들러를 함께 묶어준다.
C. 햅틱은 RealityKit 내부 API로만 실행할 수 있다.
D. 파티클을 먼저 재생한 뒤 앱을 재시작해야 햅틱이 반영된다.
(정답: B)

Q2. ParticleEmitterComponent와 애니메이션을 함께 쓸 때 주의할 성능 포인트가 있을까요?
A. 파티클 개수·수명과 동시 애니메이션 수가 많아지면 CPU/GPU 부하가 커지므로 제한하거나 LOD를 고려해야 한다.
B. 파티클과 애니메이션은 성능에 전혀 영향을 주지 않는다.
C. 애니메이션은 항상 파티클보다 가볍다.
D. 파티클 시스템은 배터리 소모와 무관하다.
(정답: A)

Q3. Transform 애니메이션과 스켈레탈 애니메이션의 차이는?
A. Transform 애니메이션은 엔티티 전체의 위치/회전/스케일을 보간하고, 스켈레탈 애니메이션은 리깅된 모델의 개별 조인트(뼈대)를 움직인다.
B. 둘은 동일한 기능이며 이름만 다르다.
C. 스켈레탈 애니메이션은 파티클에만 적용된다.
D. Transform 애니메이션은 visionOS에서 지원되지 않는다.
(정답: A)
```

## 톤

완전 초보자도 따라올 수 있게 설명하는 것을 우선하세요. 전문 용어는 등장할 때 바로 풀어서 정의하고, 비유를 적극 활용하세요. 이 날은 노을님의 실제 담당 영역(파티클, 햅틱)과 가장 겹치므로, 기본 설명 이후에 "왜 이렇게 설계하는가"에 대한 심화 논의로 이어가도 좋습니다.
