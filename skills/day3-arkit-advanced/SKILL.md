---
name: day3-arkit-advanced
description: Day 3 of the Spatial Computing 7-day camp. Teaches advanced ARKit topics — People Occlusion, Face/Body Tracking, Scene Geometry/reconstruction, and performance tuning — with Swift code examples grounded in current Apple documentation, then generates a Day 3 study note and checkpoint quiz. Trigger this when the user runs /day3-arkit-advanced, has finished day2-arkit-basics, or asks about ARKit occlusion, face tracking, LiDAR scene reconstruction, or ARKit performance in the context of the spatial computing camp.
---

# Day 3 — ARKit 심화

목표: Day 2에서 배운 "기본 트래킹"을 넘어, ARKit이 제공하는 고급 씬 이해 기능들을 다룬다.

## 트리거 시 할 일

1. `SpatialCampNotes/day3-arkit-advanced.md` 생성.
2. **공식 문서 확인 (필수)**: `web_search` + `web_fetch`로 People Occlusion(`ARFrame.SegmentationBuffer`, `frameSemantics = .personSegmentationWithDepth`), Face Tracking(`ARFaceTrackingConfiguration`), Scene Reconstruction(`ARWorldTrackingConfiguration.sceneReconstruction`, LiDAR 관련) 관련 Apple 공식 문서를 실제로 열어 최신 API를 확인 후 작성. 특히 이 영역은 기기 요구사항(LiDAR 유무 등)이 자주 바뀌므로 반드시 최신 문서 기준으로 안내할 것.
3. 핵심 개념 + 코드 예제를 대화창에 설명.
4. 체크포인트 퀴즈 진행.
5. `00-dashboard.md`의 Day 3 상태 갱신.

## 다룰 핵심 개념

- **People Occlusion**: 사람 실루엣이 가상 콘텐츠보다 앞에 있을 때 자연스럽게 가려지도록 처리하는 기능. `frameSemantics`에 `.personSegmentation` 또는 `.personSegmentationWithDepth` 추가.
- **Face Tracking**: TrueDepth 카메라 기반, `ARFaceTrackingConfiguration`으로 얼굴 메시/블렌드셰이프 추적.
- **Body Tracking**: `ARBodyTrackingConfiguration`으로 3D 스켈레톤 추적.
- **Scene Geometry / LiDAR**: LiDAR 탑재 기기에서 `sceneReconstruction` 옵션으로 공간 메시(mesh)를 실시간 생성 — 물리적 충돌·오클루전 정확도 향상.
- **성능 튜닝**: 세션 구성 시 불필요한 semantics를 켜지 않기, `ARSession` 델리게이트 콜백에서 무거운 작업 피하기, 프레임 드랍 디버깅 방법(Xcode의 AR 디버깅 도구 언급).

## 코드 예제 (fetch한 최신 문서로 검증 후 작성)

People Occlusion 활성화:

```swift
let configuration = ARWorldTrackingConfiguration()
if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
    configuration.frameSemantics.insert(.personSegmentationWithDepth)
}
session.run(configuration)
```

Scene Reconstruction (LiDAR):

```swift
let configuration = ARWorldTrackingConfiguration()
if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
    configuration.sceneReconstruction = .mesh
}
session.run(configuration)
```

## 노트 구조

Day 1/2와 동일한 템플릿(목표 → 핵심 개념 → 코드 → 한 줄 정리 → 퀴즈 → 참고 자료 → 다음 단계) 유지.

## 퀴즈

```
Q1. People Occlusion이 동작하려면 어떤 설정이 필요한가요?
Q2. LiDAR가 없는 기기에서도 Scene Reconstruction이 동작할까요? (직접 문서 찾아 답해보게 유도해도 좋음)
Q3. 세션 성능이 떨어질 때 가장 먼저 의심해볼 부분은?
```

## 톤

노을님의 ZupZup 프로젝트가 People Occlusion을 실제로 사용했다는 맥락이 있다면, 그 경험과 자연스럽게 연결해서 설명하세요.
