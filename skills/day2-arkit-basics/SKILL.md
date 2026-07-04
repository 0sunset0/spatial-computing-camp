---
name: day2-arkit-basics
description: Day 2 of the Spatial Computing 7-day camp. Teaches ARKit fundamentals — world tracking, session configuration, plane detection, anchors, hit testing — with Swift code examples, then generates a Day 2 study note and checkpoint quiz. Trigger this when the user runs /day2-arkit-basics, has completed day1-spatial-intro and wants to continue, or asks about ARKit basics, ARSession, plane detection, or anchors in the context of the spatial computing camp.
---

# Day 2 — ARKit 기초

목표: ARKit이 "물리 공간을 어떻게 이해하는지"에 대한 실전 감각을 잡는다. Day 1이 개념 지도였다면, Day 2는 실제로 동작하는 코드 레벨로 내려간다.

## 프로젝트 규칙 (Day 2~7 공통 — 실제 Xcode 프로젝트에 코딩)

이 캠프는 Day 2부터 **하나의 실제 iOS 앱 프로젝트를 7일에 걸쳐 계속 발전시켜 나갑니다.** 코드 스니펫을 대화창에 "보여주기"만 하지 않고, 실제 프로젝트 파일에 직접 작성/수정합니다.

- 프로젝트 위치: 현재 작업 폴더의 `SpatialCampApp/` (xcodegen 기반: `project.yml` + `Sources/SpatialCampApp/*.swift`).
- `SpatialCampApp/project.yml`이 없다면 이번이 이 작업 폴더에서 처음 코딩하는 것이므로, 아래 "프로젝트 최초 생성" 절차부터 수행하세요. 있다면 기존 파일을 이어서 수정하세요.
- Swift 파일을 새로 만들거나 구조를 바꿨다면 반드시 `cd SpatialCampApp && xcodegen generate`를 실행해 `.xcodeproj`를 갱신하세요.
- 코드를 작성/수정한 뒤에는 반드시 `xcodebuild -project SpatialCampApp.xcodeproj -scheme SpatialCampApp -destination 'generic/platform=iOS Simulator' build`로 **컴파일이 되는지 확인**하세요 (시뮬레이터는 ARKit 카메라 트래킹을 지원하지 않지만 컴파일 검증에는 충분합니다). `BUILD SUCCEEDED`가 나올 때까지 고치고, 실패하면 사용자에게 보여주기 전에 먼저 원인을 고치세요.
- 빌드가 성공하면 무엇을 바꿨는지 diff 요약을 대화창에 설명하고, **실제 AR 동작(평면 감지, 오브젝트 배치 등)은 실기(아이폰/아이패드)에서 Xcode로 빌드·실행해야 확인 가능**하다는 점을 안내하세요 (시뮬레이터에서는 카메라 트래킹이 동작하지 않음).

## 트리거 시 할 일

1. `SpatialCampNotes/day2-arkit-basics.md` 생성 (Day 1과 동일한 폴더 관례 사용; 폴더 없으면 새로 생성).
2. **공식 문서 확인 (필수)**: 코드 작성 전에 `web_search` + `web_fetch`로 `ARSession`, `ARWorldTrackingConfiguration`, `ARPlaneAnchor`, `raycast` 등 아래에 등장하는 API의 Apple 공식 문서(`developer.apple.com/documentation/arkit`)를 실제로 열어 최신 시그니처를 확인하세요. 아래 코드는 참고용 초안이며, 실제 API가 바뀌었다면 fetch한 내용 기준으로 코드를 수정해서 작성하세요.
3. **프로젝트 최초 생성** (`SpatialCampApp/`이 없을 때만):
   - `SpatialCampApp/project.yml` 생성 (아래 "project.yml 템플릿" 참고).
   - `SpatialCampApp/Sources/SpatialCampApp/SpatialCampApp.swift` (App 진입점), `ContentView.swift` 생성.
   - `SpatialCampApp/Sources/SpatialCampApp/ARViewContainer.swift`를 아래 "코드 (실제로 작성)" 내용으로 생성.
   - `ContentView.swift`가 `ARViewContainer()`를 보여주도록 연결.
   - `cd SpatialCampApp && xcodegen generate`로 `.xcodeproj` 생성.
4. **이미 프로젝트가 있다면**: `ARViewContainer.swift`를 열어서 아래 "코드 (실제로 작성)" 내용에 맞게 수정/추가하세요 (Day 1의 미리보기 코드와 기본적으로 동일한 내용이지만, 이번엔 실제 파일에 반영합니다).
5. `xcodebuild ... build`로 컴파일 검증 (위 "프로젝트 규칙" 참고). 성공/실패 결과를 대화창에 보고.
6. 확인한 핵심 개념 + 실제로 작성한 코드를 대화창에도 설명.
7. 체크포인트 퀴즈 진행.
8. `00-dashboard.md`의 Day 2 상태를 ✅로 갱신.
9. Day 1 노트가 없다면("처음 오는 사용자") 먼저 `/day1-spatial-intro`를 완료했는지 가볍게 확인하되, 막지는 말고 바로 진행해도 괜찮음.
10. 퀴즈가 모두 끝나면, 사용자에게 "다음" 또는 "완료"라고 입력하면 Day 3으로 넘어간다고 안내합니다. 사용자가 "다음"/"완료"(또는 유사 표현)로 응답하면, `/day3-arkit-advanced` 슬래시 명령을 다시 요구하지 말고 **Skill 도구로 `day3-arkit-advanced`를 직접 호출**하세요.

## project.yml 템플릿 (프로젝트 최초 생성 시에만 사용)

```yaml
name: SpatialCampApp
options:
  bundleIdPrefix: com.techmap.spatialcamp
  deploymentTarget:
    iOS: "17.0"
targets:
  SpatialCampApp:
    type: application
    platform: iOS
    sources:
      - path: Sources/SpatialCampApp
    info:
      path: Sources/SpatialCampApp/Info.plist
      properties:
        UILaunchScreen: {}
        NSCameraUsageDescription: "Spatial Computing Camp 실습에서 ARKit 카메라 트래킹을 사용하기 위해 카메라 접근 권한이 필요합니다."
        UIRequiredDeviceCapabilities: [arkit]
    settings:
      base:
        PRODUCT_BUNDLE_IDENTIFIER: com.techmap.spatialcamp.SpatialCampApp
        SWIFT_VERSION: "5.0"
        TARGETED_DEVICE_FAMILY: "1,2"
        CODE_SIGN_STYLE: Automatic
```

`SpatialCampApp.swift`:

```swift
import SwiftUI

@main
struct SpatialCampApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

`ContentView.swift`:

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}
```

## 다룰 핵심 개념

- **ARSession**: ARKit의 중심 객체. 카메라 입력 + 모션 센서를 받아 트래킹 데이터를 만들어냄.
- **ARConfiguration 종류**: `ARWorldTrackingConfiguration`(가장 흔히 씀, 6DoF 트래킹)와 그 하위 옵션들(`planeDetection`, `environmentTexturing`, `frameSemantics` 등).
- **월드 트래킹 원리**: VIO(Visual-Inertial Odometry) — 카메라 이미지 특징점 + IMU 데이터를 융합해 기기 위치/방향을 추정한다는 것을 간단히.
- **평면 감지(Plane Detection)**: `.horizontal` / `.vertical` 옵션, 감지되면 `ARPlaneAnchor`가 델리게이트로 전달됨.
- **앵커(Anchor)**: 실제 공간의 한 지점을 "고정"하는 개념. `ARAnchor`가 좌표계의 기준점 역할을 함 — 이후 RealityKit에서 콘텐츠를 붙이는 지점이 된다는 것을 강조 (Day 4 연결고리).
- **히트 테스트 / Raycasting**: 화면 터치 좌표를 3D 공간의 실제 지점으로 변환하는 방법 (`ARSession.raycast(_:)`가 현재 권장 방식이고, 구식 `hitTest`는 deprecated임을 언급).

## 코드 (실제로 작성 — `Sources/SpatialCampApp/ARViewContainer.swift`)

Day 2는 아직 RealityKit을 본격적으로 다루지 않지만(그건 Day 4), 탭했을 때 뭔가 눈에 보여야 실기에서 확인하는 의미가 있으므로 최소한의 박스만 배치합니다. 재질/조명 등은 Day 4에서 제대로 다룬다고 안내하세요.

```swift
import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
        arView.session.delegate = context.coordinator

        let tapGesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap(_:))
        )
        arView.addGestureRecognizer(tapGesture)
        context.coordinator.arView = arView

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, ARSessionDelegate {
        weak var arView: ARView?

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                guard let planeAnchor = anchor as? ARPlaneAnchor else { continue }
                print("평면 감지됨: \(planeAnchor.alignment), 크기: \(planeAnchor.planeExtent)")
            }
        }

        @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
            guard let arView = arView else { return }
            let tapLocation = recognizer.location(in: arView)

            let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
            guard let firstResult = results.first else {
                print("탭한 위치에서 평면을 찾지 못했습니다")
                return
            }

            // Day 4에서 이 박스를 제대로 된 RealityKit 엔티티/머티리얼로 다듬습니다.
            let anchorEntity = AnchorEntity(world: firstResult.worldTransform)
            let box = ModelEntity(mesh: .generateBox(size: 0.1), materials: [SimpleMaterial(color: .systemBlue, isMetallic: false)])
            anchorEntity.addChild(box)
            arView.scene.addAnchor(anchorEntity)
        }
    }
}
```

실기에서 실행하면: 카메라 화면이 뜨고, 바닥/책상 같은 평면을 비추면 콘솔에 "평면 감지됨" 로그가 찍히고, 화면을 탭하면 그 지점에 파란 박스가 놓입니다.

## 노트 구조 (`day2-arkit-basics.md`)

Day 1 노트와 동일한 스타일 유지: 오늘의 목표 → 핵심 개념 → 코드 스니펫 → 한 줄 정리 → 퀴즈 → **참고 자료(실제로 fetch한 공식 문서 URL)** → 다음 단계. 코드 블록은 반드시 ```swift로 감싸기.

## 퀴즈

이 3문제를 **객관식 4지선다**로, 한 번에 다 보여주지 말고 **한 문제씩** 진행하세요. **AskUserQuestion 도구를 사용해서 사용자가 방향키/클릭으로 보기 중 하나를 고를 수 있게 하세요** (대화창에 A~D 텍스트를 그냥 출력하고 타이핑으로 답하게 하지 마세요):

1. Q1을 AskUserQuestion으로 물어봅니다. `question`에는 문제 본문을, `options`에는 4개 보기를 `label`(짧게, 예: "A", "B"처럼 식별 가능하게 보기 핵심을 담아)과 `description`(보기 전문)으로 각각 담아 전달하세요. 정답을 먼저 알려주지 않습니다.
2. 사용자가 선택하면 정답 여부를 알려주되, 정답이든 오답이든 **왜 그런지, 다른 보기는 왜 아닌지**까지 피드백합니다 (단순 정오 통보로 끝내지 않기).
3. 이어서 Q2 → AskUserQuestion → 피드백, 마지막으로 Q3도 동일하게 진행합니다.
4. 세 문제가 모두 끝나면 다음 단계로 안내합니다.

아래 정답 표시는 채점 참고용이며 **AskUserQuestion의 옵션에는 넣지 말고, 사용자에게 먼저 노출하지도 마세요**:

```
Q1. ARWorldTrackingConfiguration에서 평면 감지를 켜는 코드로 올바른 것은?
A. config.planeDetection = true
B. config.planeDetection = [.horizontal, .vertical]
C. config.detectPlanes()
D. session.enablePlaneDetection()
(정답: B)

Q2. ARAnchor와 ARPlaneAnchor의 관계는?
A. ARPlaneAnchor는 ARAnchor와 무관한 별개의 클래스다.
B. ARPlaneAnchor는 ARAnchor의 서브클래스로, 감지된 평면에 대한 추가 정보(범위, 정렬 등)를 담는다.
C. ARAnchor가 ARPlaneAnchor의 서브클래스다.
D. 평면 감지에는 ARAnchor만 쓰이고 ARPlaneAnchor는 사용되지 않는다.
(정답: B)

Q3. hitTest 대신 raycast를 권장하는 이유가 뭘까요?
A. raycast가 더 오래된 API라 호환성이 좋다.
B. hitTest는 deprecated 되었고, raycast가 더 정확하고 지속적인(tracked) 레이캐스트 쿼리를 지원한다.
C. hitTest는 3D 오브젝트에서만 동작한다.
D. raycast는 평면 감지가 꺼져 있어도 동작하기 때문이다.
(정답: B)
```

## 실습 과제 (선택)

노을님의 ZupZup 프로젝트처럼 실제 감정 구슬을 배치하는 것과 연결지어, "탭한 평면 위에 빈 앵커를 하나 만들어보기"를 미니 과제로 제안하세요. 이미 아는 프로젝트 맥락이 있다면 자연스럽게 연결해도 좋습니다.

## 톤

Day 1과 동일하게 iOS 개발 경험이 있는 학습자 대상. Swift 문법 기초 설명은 생략하고 ARKit 고유 개념에 집중하세요.
