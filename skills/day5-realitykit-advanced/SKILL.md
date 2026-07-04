---
name: day5-realitykit-advanced
description: Day 5 of the Spatial Computing 7-day camp. Teaches advanced RealityKit topics — particle systems, animation, and CoreHaptics integration — with Swift code examples grounded in current Apple documentation, then generates a Day 5 study note and checkpoint quiz. Trigger this when the user runs /day5-realitykit-advanced, has finished day4-realitykit-basics, or asks about RealityKit particles, animation, or haptics integration in the context of the spatial computing camp.
---

# Day 5 — RealityKit 심화

목표: 콘텐츠를 "살아있게" 만드는 파티클, 애니메이션, 햅틱을 다룬다. ZupZup 프로젝트의 실제 경험(파티클, CoreHaptics)과 가장 밀접한 날.

## 트리거 시 할 일

1. `SpatialCampNotes/day5-realitykit-advanced.md` 생성.
2. **공식 문서 확인 (필수)**: `web_search` + `web_fetch`로 `ParticleEmitterComponent`, RealityKit 애니메이션(`Transform` 애니메이션, `AnimationResource`), `CoreHaptics`(`CHHapticEngine`) 관련 Apple 공식 문서를 실제로 열어 최신 API로 검증 후 작성. RealityKit 파티클 API는 상대적으로 최근에 추가된 영역이라 특히 최신 문서 확인이 중요함을 유의.
3. 핵심 개념 + 코드 예제를 대화창에 설명.
4. 체크포인트 퀴즈 진행.
5. `00-dashboard.md`의 Day 5 상태 갱신.

## 다룰 핵심 개념

- **ParticleEmitterComponent**: RealityKit 내장 파티클 시스템. 방출 모양, 속도, 수명, 색상/텍스처 등을 코드나 Reality Composer Pro로 설정.
- **애니메이션**: `Transform` 보간 애니메이션(이동/회전/스케일), `AnimationResource`를 통한 스켈레탈/블렌드셰이프 애니메이션 재생.
- **CoreHaptics 연동**: RealityKit 자체는 햅틱을 직접 제공하지 않으므로, `CHHapticEngine`을 별도로 구성해 시각적 이벤트(파티클 발생, 충돌 등)와 타이밍을 맞춰 트리거하는 패턴.
- **동기화 패턴**: "파티클 시작 시점 + 햅틱 트리거 시점"을 맞추는 것이 체감 품질에 큰 영향을 준다는 설계 관점 강조 (ZupZup에서 노을님이 실제로 다룬 영역).

## 코드 예제 (fetch한 최신 문서로 검증 후 작성)

파티클 컴포넌트 추가 (초안 — 실제 프로퍼티명은 fetch한 문서 기준으로 보정):

```swift
var particles = ParticleEmitterComponent()
particles.emitterShape = .sphere
particles.birthRate = 200
particles.mainEmitter.lifeSpan = 1.5
particles.mainEmitter.color = .constant(.single(.systemPink))
modelEntity.components.set(particles)
```

Transform 애니메이션:

```swift
var transform = modelEntity.transform
transform.scale = [1.5, 1.5, 1.5]
modelEntity.move(to: transform, relativeTo: modelEntity.parent, duration: 0.3, timingFunction: .easeInOut)
```

CoreHaptics 트리거 (파티클 발생과 동시에):

```swift
let engine = try CHHapticEngine()
try engine.start()

let event = CHHapticEvent(eventType: .hapticTransient,
                           parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)],
                           relativeTime: 0)
let pattern = try CHHapticPattern(events: [event], parameters: [])
let player = try engine.makePlayer(with: pattern)
try player.start(atTime: CHHapticTimeImmediate)
```

## 노트 구조

Day 1~4와 동일한 템플릿 유지.

## 퀴즈

```
Q1. RealityKit 파티클을 트리거하는 것과 CoreHaptics 진동을 동시에 발생시키려면 어떤 구조가 필요할까요?
Q2. ParticleEmitterComponent와 애니메이션을 함께 쓸 때 주의할 성능 포인트가 있을까요? (추측 답변도 환영)
Q3. Transform 애니메이션과 스켈레탈 애니메이션의 차이는?
```

## 톤

이 날은 노을님의 실제 담당 영역(파티클, 햅틱)과 가장 겹치므로, 개념 설명보다 "왜 이렇게 설계하는가"에 대한 심화 논의로 이어가도 좋습니다.
