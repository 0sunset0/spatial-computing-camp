---
name: day3-arkit-advanced
description: Day 3 of the Spatial Computing 7-day camp. Teaches advanced ARKit topics — People Occlusion, Face/Body Tracking, Scene Geometry/reconstruction, and performance tuning — via a beginner-friendly, in-chat concept→code→quiz loop per concept (no note files), grounded in current Apple documentation, then codes the real SpatialCampApp Xcode project. Trigger this when the user runs /day3-arkit-advanced, has finished day2-arkit-basics, or asks about ARKit occlusion, face tracking, LiDAR scene reconstruction, or ARKit performance in the context of the spatial computing camp.
---

# Day 3 — ARKit 심화

목표: Day 2에서 배운 "기본 트래킹"을 넘어, ARKit이 제공하는 고급 씬 이해 기능들을 다룬다.

## 프로젝트 규칙 (실제 Xcode 프로젝트에 코딩 — Day 2와 동일한 프로젝트를 이어서 사용)

Day 2에서 만든 `SpatialCampApp/` 프로젝트(xcodegen 기반, `Sources/SpatialCampApp/ARViewContainer.swift`)를 이어서 수정합니다. 새 프로젝트를 만들지 마세요.

- `SpatialCampApp/`이 없다면(Day 2를 건너뛴 경우) `/day2-arkit-basics`를 완료했는지 확인하되, 막지는 말고 없으면 최소한의 베이스(ARSession + 평면 감지 + raycast 배치)부터 만들고 이어가도 괜찮습니다.
- `ARViewContainer.swift`의 `makeUIView` 안 `configuration` 설정 블록에 아래 "코드 (실제로 작성)"의 People Occlusion / Scene Reconstruction 설정을 추가하세요.
- 코드를 수정한 뒤 `xcodebuild -project SpatialCampApp.xcodeproj -scheme SpatialCampApp -destination 'generic/platform=iOS Simulator' build`로 컴파일 검증하세요. `BUILD SUCCEEDED`가 나올 때까지 고치세요.
- People Occlusion 결과나 LiDAR mesh는 시뮬레이터에서 볼 수 없으니, **실기(LiDAR 있는 기기면 더 좋음)에서 Xcode로 빌드·실행해야 실제 효과를 확인**할 수 있다고 안내하세요.

## 진행 방식 (중요, 모든 Day 공통)

- **노트/대시보드 파일을 만들지 않습니다.** `SpatialCampNotes/*.md`, `00-dashboard.md` 같은 파일을 생성하지 마세요. 설명은 전부 대화창 출력으로 전달합니다 (단, `SpatialCampApp/` 실제 프로젝트 코드 파일은 이 규칙과 무관하게 정상적으로 작성/수정합니다).
- **개념 설명 → 퀴즈 → 프로젝트 코드로 확인, 이 세 단계를 한 세트로 묶어서 반복하세요.** 개념 하나를 설명하고, 그 개념에 대응하는 퀴즈 1문항(AskUserQuestion)을 바로 진행하고, 피드백을 준 다음, **그 개념에 해당하는 코드만** 실제 프로젝트 파일에 반영하고 `xcodebuild`로 컴파일까지 확인하세요. 모든 개념을 다 설명한 뒤에 퀴즈나 코드를 몰아서 하지 마세요.
- **컴파일 성공만으로 다음 개념으로 넘어가지 마세요.** 시뮬레이터 빌드가 성공하면, 사용자에게 "실기(아이폰/아이패드, LiDAR 있는 기기면 더 좋음)에서 Xcode로 직접 빌드·실행해서 이 기능이 실제로 동작하는지 확인해보세요"라고 안내하고, 사용자가 빌드해봤는지·어떻게 됐는지 답할 때까지 기다리세요. 사용자가 답하면 그 응답을 반영하고 나서 다음 개념으로 넘어가세요.
- **프로젝트 파일을 고치기 전에는 항상 "지금부터 무엇을, 왜 작성할지" 한두 문장으로 먼저 말하세요.** 코드를 한 번에 다 바꿔치기 하고 나서 보고하지 말고, 작은 단위로 나눠서 하나씩 진행하세요.
- **완전 초보자도 따라올 수 있게 설명하세요.** 전문 용어가 나오면 바로 정의하고, 비유를 적극 활용하세요.

## 트리거 시 할 일 (항상 이 순서: [개념 → 퀴즈 → 코드로 확인]을 개념별로 반복)

1. **공식 문서 확인 (필수, 조용히 먼저 수행)**: `web_search` + `web_fetch`로 People Occlusion(`ARFrame.SegmentationBuffer`, `frameSemantics = .personSegmentationWithDepth`), Face Tracking(`ARFaceTrackingConfiguration`), Scene Reconstruction(`ARWorldTrackingConfiguration.sceneReconstruction`, LiDAR 관련) 관련 Apple 공식 문서를 실제로 열어 최신 API를 확인. 특히 이 영역은 기기 요구사항(LiDAR 유무 등)이 자주 바뀌므로 반드시 최신 문서 기준으로 확인할 것.
2. `SpatialCampApp/`이 없다면(Day 2를 건너뛴 경우) `/day2-arkit-basics`를 완료했는지 확인하되, 막지는 말고 없으면 최소한의 베이스부터 만들고 이어가도 괜찮습니다.
3. **개념 1 — People Occlusion (+ Face/Body Tracking 개요)**: 개념 설명 → 퀴즈 1(AskUserQuestion) → 피드백 → "이제 People Occlusion 설정을 추가하겠습니다"라고 말한 뒤 `ARViewContainer.swift`의 `configuration` 블록에 `frameSemantics.insert(.personSegmentationWithDepth)` 부분만 추가 → `xcodebuild ... build`로 확인.
4. **개념 2 — Scene Geometry / LiDAR**: 개념 설명 → 퀴즈 2 → 피드백 → "이제 Scene Reconstruction(LiDAR mesh) 설정을 추가하겠습니다"라고 말한 뒤 `sceneReconstruction = .mesh` 설정 + `arView.debugOptions.insert(.showSceneUnderstanding)` 부분만 추가 → `xcodebuild ... build`로 확인.
5. **개념 3 — 성능 튜닝**: 개념 설명 → 퀴즈 3 → 피드백 → 새 코드를 추가하기보다, 지금까지 켠 옵션들(occlusion + scene reconstruction)을 함께 훑어보며 "무엇을 껐다 켜면 성능에 영향이 있는지" 짚어주고, `handleTap`의 완료 안내 문구를 occlusion 테스트용으로 바꾼 뒤 최종 `xcodebuild ... build`로 확인.
6. 성공/실패를 대화창에 보고 (실패하면 사용자에게 보고하기 전에 먼저 고칠 것).
7. 모든 게 끝나면, 사용자에게 "다음" 또는 "완료"라고 입력하면 Day 4로 넘어간다고 안내합니다. 사용자가 "다음"/"완료"(또는 유사 표현)로 응답하면, `/day4-realitykit-basics` 슬래시 명령을 다시 요구하지 말고 **Skill 도구로 `day4-realitykit-basics`를 직접 호출**하세요.

## 다룰 핵심 개념

- **People Occlusion**: 사람 실루엣이 가상 콘텐츠보다 앞에 있을 때 자연스럽게 가려지도록 처리하는 기능. `frameSemantics`에 `.personSegmentation` 또는 `.personSegmentationWithDepth` 추가.
- **Face Tracking**: TrueDepth 카메라 기반, `ARFaceTrackingConfiguration`으로 얼굴 메시/블렌드셰이프 추적.
- **Body Tracking**: `ARBodyTrackingConfiguration`으로 3D 스켈레톤 추적.
- **Scene Geometry / LiDAR**: LiDAR 탑재 기기에서 `sceneReconstruction` 옵션으로 공간 메시(mesh)를 실시간 생성 — 물리적 충돌·오클루전 정확도 향상.
- **성능 튜닝**: 세션 구성 시 불필요한 semantics를 켜지 않기, `ARSession` 델리게이트 콜백에서 무거운 작업 피하기, 프레임 드랍 디버깅 방법(Xcode의 AR 디버깅 도구 언급).

## 코드 (실제로 작성 — `Sources/SpatialCampApp/ARViewContainer.swift`의 `configuration` 블록에 추가)

아래는 완성된 전체 코드입니다. **한 번에 다 쓰지 말고** 위 "트리거 시 할 일"에서 설명한 대로 나눠서 작성하세요: (1) `frameSemantics.insert(.personSegmentationWithDepth)` 부분 → (2) `sceneReconstruction = .mesh` + `showSceneUnderstanding` 부분.

```swift
let configuration = ARWorldTrackingConfiguration()
configuration.planeDetection = [.horizontal, .vertical]
configuration.environmentTexturing = .automatic

if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
    configuration.frameSemantics.insert(.personSegmentationWithDepth)
}
if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
    configuration.sceneReconstruction = .mesh
}

arView.session.run(configuration)

// Scene Reconstruction(LiDAR mesh)을 화면에서 와이어프레임으로 볼 수 있도록 디버그 옵션 추가
arView.debugOptions.insert(.showSceneUnderstanding)
```

기존 Day 2 코드의 `configuration` 설정 부분을 이 내용으로 대체하고, 나머지(델리게이트, 탭 제스처, raycast 배치 로직)는 그대로 둡니다.

`handleTap` 마지막의 `status.statusText = "배치 완료! ..."` 줄도 occlusion을 테스트하도록 문구를 바꾸세요:

```swift
status.statusText = "배치 완료! 사람이 오브젝트 앞을 지나가면 자연스럽게 가려지는지 확인해보세요"
```

## 퀴즈

아래 3문제는 각각 대응하는 개념 설명 **직후 바로** 진행하세요 (Q1→People Occlusion 개념 뒤, Q2→Scene Reconstruction/LiDAR 개념 뒤, Q3→성능 튜닝 개념 뒤). 모든 개념 설명이 끝날 때까지 기다렸다가 한꺼번에 몰아서 내지 마세요. **객관식 4지선다**로, **AskUserQuestion 도구를 사용해서 사용자가 방향키/클릭으로 보기 중 하나를 고를 수 있게 하세요** (대화창에 A~D 텍스트를 그냥 출력하고 타이핑으로 답하게 하지 마세요):

1. 해당 개념 설명이 끝나면 그 자리에서 AskUserQuestion으로 물어봅니다. `question`에는 문제 본문을, `options`에는 4개 보기를 `label`(짧게, 예: "A", "B"처럼 식별 가능하게 보기 핵심을 담아)과 `description`(보기 전문)으로 각각 담아 전달하세요. 정답을 먼저 알려주지 않습니다.
2. 사용자가 선택하면 정답 여부를 알려주되, 정답이든 오답이든 **왜 그런지, 다른 보기는 왜 아닌지**까지 피드백합니다 (단순 정오 통보로 끝내지 않기).
3. 피드백 후 바로 다음 개념 설명으로 넘어가고, 그 개념이 끝나면 다음 문제를 동일하게 진행합니다.

아래 정답 표시는 채점 참고용이며 **AskUserQuestion의 옵션에는 넣지 말고, 사용자에게 먼저 노출하지도 마세요**:

```
Q1. People Occlusion이 동작하려면 어떤 설정이 필요한가요?
A. frameSemantics에 .personSegmentationWithDepth(또는 .personSegmentation)를 추가한다.
B. sceneReconstruction을 .mesh로 설정한다.
C. 별도 설정 없이 항상 기본 활성화되어 있다.
D. LiDAR 센서가 있는 기기에서만 config를 켤 수 있다.
(정답: A)

Q2. LiDAR가 없는 기기에서도 Scene Reconstruction이 동작할까요?
A. 네, 모든 기기에서 동일하게 동작한다.
B. 아니요, Scene Reconstruction(mesh 생성)은 LiDAR 스캐너가 있는 기기에서만 지원된다.
C. LiDAR 없이도 카메라만으로 동일한 정밀도의 mesh를 생성할 수 있다.
D. Scene Reconstruction은 LiDAR와 무관하며 모든 iPhone에서 지원된다.
(정답: B)

Q3. 세션 성능이 떨어질 때 가장 먼저 의심해볼 부분은?
A. 앱 아이콘 디자인.
B. 과도한 frameSemantics(예: People Occlusion + Scene Reconstruction 동시 사용)나 너무 많은 트래킹 대상/엔티티.
C. Xcode 버전.
D. Swift 언어 버전.
(정답: B)
```

## 톤

완전 초보자도 따라올 수 있게 설명하는 것을 우선하세요. 전문 용어는 등장할 때 바로 풀어서 정의하고, 비유를 적극 활용하세요. 노을님의 ZupZup 프로젝트가 People Occlusion을 실제로 사용했다는 맥락이 있다면, 기본 설명 이후에 그 경험과 자연스럽게 연결해서 설명하세요.
