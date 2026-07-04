---
name: day2-arkit-basics
description: Day 2 of the Spatial Computing 7-day camp. Teaches ARKit fundamentals — world tracking, session configuration, plane detection, anchors, hit testing — with Swift code examples, then generates a Day 2 study note and checkpoint quiz. Trigger this when the user runs /day2-arkit-basics, has completed day1-spatial-intro and wants to continue, or asks about ARKit basics, ARSession, plane detection, or anchors in the context of the spatial computing camp.
---

# Day 2 — ARKit 기초

목표: ARKit이 "물리 공간을 어떻게 이해하는지"에 대한 실전 감각을 잡는다. Day 1이 개념 지도였다면, Day 2는 실제로 동작하는 코드 레벨로 내려간다.

## 트리거 시 할 일

1. `SpatialCampNotes/day2-arkit-basics.md` 생성 (Day 1과 동일한 폴더 관례 사용; 폴더 없으면 새로 생성).
2. **공식 문서 확인 (필수)**: 노트 작성 전에 `web_search` + `web_fetch`로 `ARSession`, `ARWorldTrackingConfiguration`, `ARPlaneAnchor`, `raycast` 등 아래에 등장하는 API의 Apple 공식 문서(`developer.apple.com/documentation/arkit`)를 실제로 열어 최신 시그니처를 확인하세요. 아래 코드 예제는 참고용 초안이며, 실제 API가 바뀌었다면 fetch한 내용 기준으로 코드를 수정해서 작성하세요.
3. 확인한 핵심 개념 + 코드 예제를 대화창에도 설명.
4. 체크포인트 퀴즈 진행.
5. `00-dashboard.md`의 Day 2 상태를 ✅로 갱신.
6. Day 1 노트가 없다면("처음 오는 사용자") 먼저 `/day1-spatial-intro`를 완료했는지 가볍게 확인하되, 막지는 말고 바로 진행해도 괜찮음.

## 다룰 핵심 개념

- **ARSession**: ARKit의 중심 객체. 카메라 입력 + 모션 센서를 받아 트래킹 데이터를 만들어냄.
- **ARConfiguration 종류**: `ARWorldTrackingConfiguration`(가장 흔히 씀, 6DoF 트래킹)와 그 하위 옵션들(`planeDetection`, `environmentTexturing`, `frameSemantics` 등).
- **월드 트래킹 원리**: VIO(Visual-Inertial Odometry) — 카메라 이미지 특징점 + IMU 데이터를 융합해 기기 위치/방향을 추정한다는 것을 간단히.
- **평면 감지(Plane Detection)**: `.horizontal` / `.vertical` 옵션, 감지되면 `ARPlaneAnchor`가 델리게이트로 전달됨.
- **앵커(Anchor)**: 실제 공간의 한 지점을 "고정"하는 개념. `ARAnchor`가 좌표계의 기준점 역할을 함 — 이후 RealityKit에서 콘텐츠를 붙이는 지점이 된다는 것을 강조 (Day 4 연결고리).
- **히트 테스트 / Raycasting**: 화면 터치 좌표를 3D 공간의 실제 지점으로 변환하는 방법 (`ARSession.raycast(_:)`가 현재 권장 방식이고, 구식 `hitTest`는 deprecated임을 언급).

## 코드 예제 (반드시 포함)

세션 시작 예제:

```swift
let session = ARSession()
let configuration = ARWorldTrackingConfiguration()
configuration.planeDetection = [.horizontal, .vertical]
configuration.environmentTexturing = .automatic
session.run(configuration)
```

평면 감지 델리게이트 예제:

```swift
func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
    for anchor in anchors {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { continue }
        print("평면 감지됨: \(planeAnchor.alignment), 크기: \(planeAnchor.planeExtent)")
    }
}
```

레이캐스트 예제 (탭한 위치에 오브젝트 놓기 직전 단계):

```swift
func placeObject(at point: CGPoint, in arView: ARView) {
    let results = arView.raycast(from: point, allowing: .estimatedPlane, alignment: .horizontal)
    guard let firstResult = results.first else { return }
    let anchor = AnchorEntity(world: firstResult.worldTransform)
    // Day 4에서 여기에 RealityKit 엔티티를 붙이게 됩니다
}
```

## 노트 구조 (`day2-arkit-basics.md`)

Day 1 노트와 동일한 스타일 유지: 오늘의 목표 → 핵심 개념 → 코드 스니펫 → 한 줄 정리 → 퀴즈 → **참고 자료(실제로 fetch한 공식 문서 URL)** → 다음 단계. 코드 블록은 반드시 ```swift로 감싸기.

## 퀴즈

```
Q1. ARWorldTrackingConfiguration에서 평면 감지를 켜는 코드를 직접 써보세요.
Q2. ARAnchor와 ARPlaneAnchor의 관계는?
Q3. hitTest 대신 raycast를 권장하는 이유가 뭘까요? (추측이라도 답해보게 유도)
```

## 실습 과제 (선택)

노을님의 ZupZup 프로젝트처럼 실제 감정 구슬을 배치하는 것과 연결지어, "탭한 평면 위에 빈 앵커를 하나 만들어보기"를 미니 과제로 제안하세요. 이미 아는 프로젝트 맥락이 있다면 자연스럽게 연결해도 좋습니다.

## 톤

Day 1과 동일하게 iOS 개발 경험이 있는 학습자 대상. Swift 문법 기초 설명은 생략하고 ARKit 고유 개념에 집중하세요.
