---
name: day5-realitykit-advanced
description: Day 5 of the Spatial Computing 7-day camp. Teaches advanced RealityKit topics — particle systems and Transform-based animation (interpolating position/rotation/scale in 3D space) — via a beginner-friendly, in-chat concept→code→quiz loop per concept (no note files), grounded in current Apple documentation, then codes the real SpatialCampApp Xcode project. Trigger this when the user runs /day5-realitykit-advanced, has finished day4-realitykit-basics, or asks about RealityKit particles or Transform animation in the context of the spatial computing camp.
---

# Day 5 — RealityKit 심화

목표: 콘텐츠를 "살아있게" 만드는 파티클과 Transform 애니메이션을 다룬다. 둘 다 3D 공간 안에서 벌어지는 진짜 "공간 컴퓨팅" 개념이라는 점에 집중한다 (CoreHaptics 같은 일반 iOS 인터랙션 API는 공간 개념이 아니라서 이 Day에서 다루지 않는다).

## 프로젝트 규칙 (실제 Xcode 프로젝트에 코딩 — Day 2~4와 동일한 프로젝트를 이어서 사용)

`SpatialCampApp/Sources/SpatialCampApp/ARViewContainer.swift`를 이어서 수정합니다.

- **배포 타깃을 iOS 18.0으로 올려야 합니다**: `ParticleEmitterComponent`(이 코드에서 쓰는 형태)는 iOS 18.0부터 지원됩니다. `SpatialCampApp/project.yml`의 `deploymentTarget.iOS`가 아직 `"17.0"`이면 `"18.0"`으로 바꾸고, `cd SpatialCampApp && xcodegen generate`로 프로젝트를 재생성하세요. (Day 2~4 코드는 iOS 18에서도 그대로 잘 동작합니다.)
- `handleTap`에서 오브젝트를 배치한 뒤, 아래 "코드 (실제로 작성)"의 파티클 컴포넌트 + Transform 애니메이션(팝인 효과)을 추가하세요.
- 수정 후 `xcodebuild -project SpatialCampApp.xcodeproj -scheme SpatialCampApp -destination 'generic/platform=iOS Simulator' build`로 컴파일 검증. `BUILD SUCCEEDED`까지 고치세요.
- 파티클과 애니메이션은 **실기에서 Xcode로 빌드·실행**해야 실제로 보인다고 안내하세요 (시뮬레이터는 ARKit 카메라 트래킹을 지원하지 않음). 실기가 iOS 18 미만이면 실행이 안 되니, 그 경우 컴파일 확인까지만으로 충분하다고 안내하세요.

## 진행 방식 (중요, 모든 Day 공통)

- **노트/대시보드 파일을 만들지 않습니다.** `SpatialCampNotes/*.md`, `00-dashboard.md` 같은 파일을 생성하지 마세요. 설명은 전부 대화창 출력으로 전달합니다 (단, `SpatialCampApp/` 실제 프로젝트 코드 파일은 이 규칙과 무관하게 정상적으로 작성/수정합니다).
- **개념 설명 → 퀴즈 → 프로젝트 코드로 확인, 이 세 단계를 한 세트로 묶어서 반복하세요.** 개념을 설명하고, 대응하는 퀴즈 1문항(AskUserQuestion)을 바로 진행하고, 피드백을 준 다음, **그 개념에 해당하는 코드만** 실제 프로젝트 파일에 반영하고 `xcodebuild`로 컴파일까지 확인하세요. 모든 개념을 다 설명한 뒤에 퀴즈나 코드를 몰아서 하지 마세요.
- **컴파일 성공만으로 다음으로 넘어가지 마세요.** 시뮬레이터 빌드가 성공하면, 사용자에게 "실기(아이폰/아이패드)에서 Xcode로 직접 빌드·실행해서 파티클과 애니메이션이 실제로 보이는지 확인해보세요"라고 안내하고, 사용자가 빌드해봤는지·어떻게 됐는지 답할 때까지 기다리세요. 사용자가 답하면 그 응답을 반영하고 나서 다음으로 넘어가세요.
- **프로젝트 파일을 고치기 전에는 항상 "지금부터 무엇을, 왜 작성할지" 한두 문장으로 먼저 말하세요.** 코드를 큰 덩어리로 한 번에 다 넣지 말고, 작은 단위로 나눠서 하나씩 진행하세요.
- **완전 초보자도 따라올 수 있게 설명하세요.** 전문 용어가 나오면 바로 정의하고, 비유를 적극 활용하세요.

## 트리거 시 할 일 (항상 이 순서: [개념 → 퀴즈 → 코드로 확인]을 개념별로 반복)

1. **공식 문서 확인 (필수, 조용히 먼저 수행)**: `web_search` + `web_fetch`로 `ParticleEmitterComponent`, `Entity.move(to:relativeTo:duration:timingFunction:)`, `AnimationResource` 관련 Apple 공식 문서를 실제로 열어 최신 API로 확인. RealityKit 파티클 API는 상대적으로 최근에 추가된 영역이라 특히 최신 문서 확인이 중요함을 유의.
2. **개념 1 — ParticleEmitterComponent**: 개념 설명 → 퀴즈 1(AskUserQuestion) → 피드백 → "이제 배포 타깃을 iOS 18로 올리고 파티클 컴포넌트를 오브젝트에 붙이겠습니다"라고 말한 뒤 `project.yml`의 `deploymentTarget.iOS`를 `"18.0"`으로 바꾸고 `xcodegen generate` 실행 → `handleTap`에 `ParticleEmitterComponent` 설정을 추가 → `xcodebuild ... build`로 확인.
3. **개념 2 — Transform 애니메이션**: 개념 설명 → 퀴즈 2 → 피드백 → "이제 오브젝트가 배치될 때 작게 시작해서 커지는 팝인 애니메이션을 추가하겠습니다"라고 말한 뒤 `handleTap`에 `move(to:relativeTo:duration:timingFunction:)` 애니메이션 코드를 추가 → `xcodebuild ... build`로 확인.
4. **개념 3 — 성능 튜닝**: 개념 설명 → 퀴즈 3 → 피드백 → 새 기능을 추가하기보다, 지금까지 넣은 파티클(`mainEmitter.birthRate`/`lifeSpan`)과 애니메이션 동시 실행이 왜 부하를 키우는지 짚어주고 필요하면 값을 조정 → 최종 `xcodebuild ... build`로 확인.
5. 성공/실패를 대화창에 보고 (실패하면 사용자에게 보고하기 전에 먼저 고칠 것).
6. 모든 게 끝나면, 사용자에게 "다음" 또는 "완료"라고 입력하면 Day 6으로 넘어간다고 안내합니다. 사용자가 "다음"/"완료"(또는 유사 표현)로 응답하면, `/day6-interaction-gesture` 슬래시 명령을 다시 요구하지 말고 **Skill 도구로 `day6-interaction-gesture`를 직접 호출**하세요.

## 다룰 핵심 개념

- **ParticleEmitterComponent**: RealityKit 내장 파티클 시스템. 엔티티에 붙이는 Component로, 방출 모양(`emitterShape`)·초당 방출량(`mainEmitter.birthRate`)·입자 수명(`mainEmitter.lifeSpan`)·색상 등을 설정. iOS 18.0 이상 필요. 파티클은 3D 공간 안에서 실제로 퍼져나가는 입자들이라는 점에서 순수하게 공간적인 효과.
- **Transform 애니메이션**: `entity.move(to:relativeTo:duration:timingFunction:)`으로 현재 Transform(위치/회전/스케일)에서 목표 Transform까지 지정한 시간에 걸쳐 보간(interpolate). 이것도 "3D 공간 안에서 좌표가 시간에 따라 어떻게 바뀌는가"를 다루는 순수 공간 개념.
- **참고 (스켈레탈 애니메이션)**: 리깅된 3D 모델의 개별 조인트(뼈대)를 움직이는 스켈레탈/블렌드셰이프 애니메이션(`AnimationResource`)도 있지만, 이번 프로젝트는 단순 도형(구)이라 조인트가 없으므로 다루지 않음 — Transform 애니메이션만으로 충분히 "살아있는" 느낌을 줄 수 있다는 것만 알아두면 됨.
- **성능 튜닝**: 파티클 개수·수명과 동시에 재생되는 애니메이션이 많아지면 CPU/GPU 부하가 커짐. 필요 이상으로 파티클을 안 켜두거나(트리거 이후 일정 시간 뒤 정리), 화면에 동시에 존재하는 오브젝트 수를 제한하는 것이 관건.

| 개념 | 왜 "공간 컴퓨팅"인가 |
|---|---|
| ParticleEmitterComponent | 입자들이 3D 공간 좌표를 갖고 실제로 퍼져나감 |
| Transform 애니메이션 | 3D 좌표(위치/회전/스케일)가 시간에 따라 보간됨 |
| (제외) CoreHaptics | 진동 명령일 뿐, 공간/좌표 개념이 전혀 없음 |

## 코드 (실제로 작성 — `ARViewContainer.swift`의 `handleTap` 안, 오브젝트 배치 코드 뒤에 추가)

아래는 완성된 전체 코드입니다. **한 번에 다 쓰지 말고** 위 "트리거 시 할 일"에서 설명한 대로 나눠서 작성하세요: (1) 파티클 부분 → (2) Transform 애니메이션(팝인) 부분.

```swift
// 1. 파티클: 오브젝트에서 입자를 뿜어내는 시각 효과
var particles = ParticleEmitterComponent()
particles.emitterShape = .sphere
particles.mainEmitter.birthRate = 200
particles.mainEmitter.lifeSpan = 1.5
particles.mainEmitter.color = .constant(.single(.systemPink))
modelEntity.components.set(particles)

// 2. Transform 애니메이션: 아주 작게(scale 0.01) 시작해서 원래 크기(scale 1.0)로
// 0.3초에 걸쳐 커지는 "팝인" 효과. 배치되는 순간이 시각적으로 뚜렷하게 느껴집니다.
modelEntity.transform.scale = SIMD3<Float>(repeating: 0.01)
var poppedTransform = modelEntity.transform
poppedTransform.scale = SIMD3<Float>(repeating: 1.0)
modelEntity.move(to: poppedTransform, relativeTo: anchorEntity, duration: 0.3, timingFunction: .easeOut)

status.statusText = "배치 완료! 파티클과 팝인 애니메이션이 보이는지 확인해보세요"
```

`modelEntity.transform.scale = SIMD3<Float>(repeating: 0.01)`은 `anchorEntity.addChild(modelEntity)` 이전, `arView.scene.addAnchor(anchorEntity)` 이전 어느 시점이든 상관없지만, 애니메이션 호출(`move(to:)`)은 `anchorEntity`가 씬에 추가된 뒤(또는 최소한 `relativeTo`로 넘기는 `anchorEntity`가 만들어진 뒤)에 와야 합니다.

## 퀴즈

아래 3문제는 각각 대응하는 개념 설명 **직후 바로** 진행하세요 (Q1→ParticleEmitterComponent 개념 뒤, Q2→Transform 애니메이션 개념 뒤, Q3→성능 튜닝 개념 뒤). 모든 개념 설명이 끝날 때까지 기다렸다가 한꺼번에 몰아서 내지 마세요. **객관식 4지선다**로, **AskUserQuestion 도구를 사용해서 사용자가 방향키/클릭으로 보기 중 하나를 고를 수 있게 하세요** (대화창에 A~D 텍스트를 그냥 출력하고 타이핑으로 답하게 하지 마세요):

1. 해당 개념 설명이 끝나면 그 자리에서 AskUserQuestion으로 물어봅니다. `question`에는 문제 본문을, `options`에는 4개 보기를 `label`(짧게, 예: "A", "B"처럼 식별 가능하게 보기 핵심을 담아)과 `description`(보기 전문)으로 각각 담아 전달하세요. 정답을 먼저 알려주지 않습니다.
2. 사용자가 선택하면 정답 여부를 알려주되, 정답이든 오답이든 **왜 그런지, 다른 보기는 왜 아닌지**까지 피드백합니다 (단순 정오 통보로 끝내지 않기).
3. 피드백 후 바로 다음 개념 설명으로 넘어가고, 그 개념이 끝나면 다음 문제를 동일하게 진행합니다.

아래 정답 표시는 채점 참고용이며 **AskUserQuestion의 옵션에는 넣지 말고, 사용자에게 먼저 노출하지도 마세요**:

```
Q1. ParticleEmitterComponent를 엔티티에 실제로 적용하려면 어떻게 해야 할까요?
A. entity.components.set(particles)로 Component를 Entity에 등록한다 (Day 4의 ECS 패턴 그대로).
B. 별도의 파일로 저장한 뒤 앱을 재시작해야 적용된다.
C. ARSessionDelegate에 파티클을 등록해야 한다.
D. RealityView에서만 파티클을 쓸 수 있고 ARView에서는 불가능하다.
(정답: A)

Q2. entity.move(to:relativeTo:duration:timingFunction:)가 실제로 하는 일은?
A. 지정한 시간(duration) 동안 현재 Transform에서 목표 Transform(위치/회전/스케일)까지 보간(interpolate)한다.
B. Transform을 즉시 바꾸고 시각적인 변화는 없다.
C. relativeTo는 항상 무시되고 월드 좌표 기준으로만 움직인다.
D. duration은 초 단위가 아니라 프레임 수를 의미한다.
(정답: A)

Q3. 파티클과 애니메이션을 함께 쓸 때 주의할 성능 포인트가 있을까요?
A. 파티클 개수·수명과 동시 애니메이션 수가 많아지면 CPU/GPU 부하가 커지므로 제한하거나 정리 시점을 고려해야 한다.
B. 파티클과 애니메이션은 성능에 전혀 영향을 주지 않는다.
C. 애니메이션은 항상 파티클보다 가볍다.
D. 파티클 시스템은 배터리 소모와 무관하다.
(정답: A)
```

## 톤

완전 초보자도 따라올 수 있게 설명하는 것을 우선하세요. 전문 용어는 등장할 때 바로 풀어서 정의하고, 비유를 적극 활용하세요. 기본 설명 이후에 "왜 이렇게 설계하는가"에 대한 심화 논의로 이어가도 좋습니다.

**가독성**: 긴 문단보다 표를 우선하세요. 두 가지 이상을 비교하는 내용은 마크다운 표로 정리하고, 코드를 줄 단위로 설명할 때도 "코드 조각 | 설명" 형태의 표를 쓰세요. 불릿은 표로 담기 어려운 짧은 요약에만 사용하세요.
