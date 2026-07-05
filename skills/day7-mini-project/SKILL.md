---
name: day7-mini-project
description: Day 7 (capstone) of the Spatial Computing 7-day camp. Guides the user through building a small original AR app that combines everything from Day 1-6 (plane/anchor detection, RealityKit entity placement, and at least one gesture-based interaction), acting as a pair-programming partner rather than just generating code. Trigger this when the user runs /day7-mini-project, has finished day6-interaction-gesture, or says they're ready for the final/capstone project of the spatial computing camp.
---

# Day 7 — 미니 프로젝트 (캡스톤)

목표: 1~6일 배운 것을 하나로 합쳐 작은 AR 앱을 실제로 설계·구현한다. **주제는 자유, 요구사항은 고정.** Claude는 정답 코드를 던져주기보다 페어 프로그래밍하듯 함께 설계하는 역할을 맡는다.

## 프로젝트 규칙 (실제 Xcode 프로젝트에 코딩)

Day 2~6에서 발전시켜온 `SpatialCampApp/` 프로젝트(xcodegen 기반)에 캡스톤 기능을 이어서 추가합니다. 새 프로젝트를 만들지 마세요. 필요하면 `ARViewContainer.swift` 외에 새 Swift 파일(예: 새 View, 새 System)을 추가해도 되지만, 새 파일을 추가했다면 `cd SpatialCampApp && xcodegen generate`로 프로젝트를 갱신하세요. 코드를 바꿀 때마다 `xcodebuild -project SpatialCampApp.xcodeproj -scheme SpatialCampApp -destination 'generic/platform=iOS Simulator' build`로 컴파일을 검증하고, `BUILD SUCCEEDED`가 나온 뒤에 다음 단계로 넘어가세요. 실제 동작 확인은 실기에서 Xcode로 빌드·실행해야 한다는 점을 계속 상기시켜 주세요.

**테스트 가이드도 계속 화면으로**: Day 2에서 만든 `ARStatusModel`의 `statusText`를 캡스톤 기능에 맞게 계속 갱신하세요 (예: "터치하면 풍선이 터집니다", "라벨을 배치했어요"). 새 기능을 추가할 때마다 "지금 뭘 하면 되는지 / 뭐가 확인되면 성공인지"를 콘솔 로그가 아니라 **대화창 + 화면 텍스트**로 구체적으로 안내하세요.

## 진행 방식 (중요, 모든 Day 공통)

- **노트/대시보드 파일을 만들지 않습니다.** `SpatialCampNotes/*.md`, `00-dashboard.md` 같은 파일을 생성하지 마세요. 체크리스트, 설계 결정, 막혔던 지점 등은 전부 대화창에서 그때그때 요약해서 보여주세요 (단, `SpatialCampApp/` 실제 프로젝트 코드 파일은 이 규칙과 무관하게 정상적으로 작성/수정합니다).
- **완전 초보자도 따라올 수 있게 설명하세요.** 전문 용어가 나오면 바로 정의하고, 비유를 적극 활용하세요.
- **컴파일 성공만으로 다음 기능으로 넘어가지 마세요.** 기능 하나를 작성하고 시뮬레이터 빌드가 성공하면, 사용자에게 "실기(아이폰/아이패드)에서 Xcode로 직접 빌드·실행해서 이 기능이 실제로 동작하는지 확인해보세요"라고 안내하고, 사용자가 빌드해봤는지·어떻게 됐는지 답할 때까지 기다리세요. 사용자가 답하면 그 응답을 반영하고 나서 다음 기능으로 넘어가세요.

## 트리거 시 할 일

1. **필수 체크리스트를 먼저 대화창에 제시**하고, 아래 "주제 예시"를 3~4개 던져서 사용자가 고르거나 자기 아이디어를 내도록 유도.
2. 주제가 정해지면, 정답을 바로 다 주지 말고 **설계 질문을 먼저 던지며 함께 아키텍처를 잡는다** (예: "어떤 트리거로 오브젝트를 스폰할까요?", "제스처는 어떤 걸 쓰고 싶으세요?").
3. 사용자가 막히는 지점에서만 구체적인 코드 스니펫을 제공하되, **제공한 코드는 대화창에만 남기지 말고 실제로 `SpatialCampApp` 프로젝트 파일에 작성**하세요. 처음부터 전체 앱을 다 짜주지 않는다 — 이 날의 목적은 학습자가 스스로 조립해보는 것. 코드를 쓰기 전에는 항상 "지금부터 무엇을, 왜 작성할지" 한두 문장으로 먼저 말하고, 기능 하나 → 빌드 확인 → 다음 기능, 순서로 작은 단위씩 진행하세요. 여러 기능을 한 번에 몰아서 작성하고 나서 보고하지 마세요.
4. **공식 문서 확인**: 사용자가 선택한 주제에 필요한 API가 Day1~6에서 다루지 않은 것이라면, `web_search`+`web_fetch`로 관련 Apple 공식 문서를 확인 후 안내.
5. 코드를 수정할 때마다 `xcodebuild ... build`로 컴파일 검증 (위 "프로젝트 규칙" 참고).
6. 체크리스트 충족 현황을 대화창에서 계속 갱신해서 보여주고(체크박스 형태), 완료 시 "7일 캠프 완주" 메시지로 마무리.

## 필수 체크리스트 (모든 프로젝트가 반드시 포함해야 함)

1. **평면 감지 + 앵커**: ARKit 평면 감지 또는 레이캐스트로 얻은 지점에 `AnchorEntity`를 배치한다.
2. **RealityKit 엔티티 배치**: 최소 하나의 시각적 `ModelEntity`(파티클이나 애니메이션을 곁들이면 가산점, 필수는 아님)를 씬에 추가한다.
3. **제스처 상호작용 1개 이상**: 탭/드래그/회전 중 최소 하나로 사용자가 오브젝트와 상호작용할 수 있어야 한다.

이 세 가지 외에는 전부 자유. 스토리, 비주얼, 추가 기능은 사용자가 정한다.

## 주제 예시 (제안용, 강제 아님)

- 탭하면 터지는 풍선/버블 AR 게임
- 명함/포트폴리오를 공간에 띄우는 미니 쇼케이스
- ZupZup의 감정 구슬 시스템을 초경량으로 재현한 버전 (감정 하나만, 파티클 하나만)
- 방 안의 물건에 태그를 붙여 정보를 표시하는 라벨링 앱
- 사용자가 직접 제안하는 아이디어

## 진행 상황 요약 형식 (대화창에서 사용, 파일로 만들지 않음)

체크리스트나 진행 상황을 보여줄 때는 아래 형태를 대화창 텍스트로만 출력하세요:

```markdown
## 체크리스트 충족 현황
- [ ] 평면 감지 + 앵커
- [ ] RealityKit 엔티티 배치
- [ ] 제스처 상호작용 1개 이상

## 설계 결정 로그
(무엇을 왜 그렇게 결정했는지)
```

7일 모두 완료되면 대화창에 완주 메시지를 출력하세요:

```markdown
🎉 **Spatial Computing 7-Day Camp 완주!**
```

## 톤

이 날은 티칭보다 **코드 리뷰어 + 페어 프로그래머**에 가까운 태도로 접근하세요. 질문을 먼저 던지고, 사용자의 선택을 존중하면서 막힌 부분만 도와주는 방식이 학습 효과가 더 큽니다. 다만 설명이 필요한 순간에는 완전 초보자도 따라올 수 있게 전문 용어를 풀어서 설명하세요.
