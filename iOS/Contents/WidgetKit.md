# WidgetKit

2020 WWDC에서 발표한 위젯에 대하여 공부하고자 한다.

본 문서에는 애플 공식문서를 기반으로 공부하며 이해한 내용을 기재한다.

<br>

## Introducing WidgetKit
---

`WidgetKit Framework`와 새로운 SwiftUI를 위한 `widget API`를 이용하면 iOS, iPadOS, macOS를 아우르는 widget을 만들 수 있다.

위젯은 다양한 사이즈로 제공되며 사용자는 위젯을 홈 하면 어디에나 배치하여 중요한 세부 정보를 한눈에 볼 수 있다.


![image](https://user-images.githubusercontent.com/33051018/86919751-af963000-c163-11ea-9177-7d60a26bd3ee.png)

<br>

## Development Guides
---

![image](https://user-images.githubusercontent.com/33051018/86919906-deaca180-c163-11ea-83b5-18d546b27843.png)

`WidgetKit` 이란 `UIKit`과 같은 FrameWork이다.

앱에서 다루는 컨텐츠를 iOS 홈 화면에 혹은 macOS 알림 센터에 보여줄 수 있도록 기능을 제공한다.


### Overview

`WidgetKit` 을 사용하면 iOS 홈 화면 또는 macOS 알림센터에 위젯을 배치하여 앱의 컨텐츠에 다이렉트로 접근할 수 있다.

또한, 위젯은 항상 최신 상태를 유지하므로 사용자는 매번 업데이트된 최신 정보를 한 눈에 볼 수 있다.

현재 위젯은 세 가지의 사이즈를 제공한다.

small, medium, large 사이즈를 제공하며 화면 내 넓은 범위를 이용하여 다양한 데이터를 보여준다.

또한 사용자가 원하는 특정 요구에 따라 해당 데이터를 보여주도록 사용자화 할 수 있으며 자신이 원하는 위치에 위젯을 배치하는 것도 당연히 가능하다.

위젯을 구현하기 위해서는 앱에 `widget extension`을 추가해야 한다.

또한, `timeline provider`를 이용하여 위젯을 수정해야 한다. 그리고 위젯 컨텐츠를 뷰에 보여주기 위해서는 `SwiftUI`를 사용해야 한다.

> timeline Provider : WidgetKit에게 위젯 내 데이터를 업데이트 해야 하는지 알려주는 역할.

![image](https://user-images.githubusercontent.com/33051018/86920847-44e5f400-c165-11ea-9dbd-f1c4a5f838c4.png)


<br>


## Creating a Widget Extension
---

iOS 홈 스크린 혹은 macOS Notification Center에 앱의 content를 보여주기 위해서는 extension을 연결해야 한다.

### Overview

위젯은 앱과 관련된 내용을 보여줌으로써 당신의 앱에 대한 세부사항을 보다 빨리 접할 수 있게 해준다.

당신의 앱은 다양한 종류의 위젯을 제공할 수 있다. 또한 다양한 사이즈의 위젯을 제공할 수 있으며 앱에서 보여주고자 하는 content에 따라 한정된 공간 내에서 사이즈를 선택하면 된다.

**사람들이 가장 보고싶어하고 중요하게 생각하는 정보를 제공하는데 집중하는 것이 가장 중요하다.**

앱에 위젯을 추가하기 위해서는 약간의 절차가 필요하다. 

또한, 위젯 내 디스플레이는 모두 SwiftUI로 구성해야 한다.

<br>

## Add Configuration Details
---

`widget` 익스텐션 템플릿은 `Widget` 프로토콜을 준수하는 초기 위젯을 제공한다.

해당 위젯의 `body` 프로퍼티가 user-configurable 가능 여부를 결정한다.

두 가지 구성이 가능하다.

- `StaticConfiguration` : 유저가 구성가능한 프로퍼티가 없는 위젯이다. 에를 들어, 일반적인 주식 시장 정보를 보여주는 주식 시장 위젯 혹은 뉴스 내용을 단순히 보여주기만 하는 뉴스 위젯과 같이 정적으로 데이터를 제공하는 방식이다.

- `IntentConfiguration` : 유저가 구성가능한 프로퍼티가 있는 위젯이다. 예를 들어, 날씨 위젯의 경우 도시의 위치를 참고하기 위한 우편번호가 필요할 수 있고, 택배 추적 위젯의 경우 운송장번호가 필요할 수 있다.

Configuration은 프로젝트를 생성할 떄 지정할 수 있으며 프로젝트 생성시 `Widget` 프로토콜을 채택하는 `@main` 코드를 사펴본다.

```swift
@main
struct GameStatusWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "com.mygame.game-status",
            provider: GameStatusProvider(),
            placeholder: GameStatusPlaceholderView()
        ) { entry in
            GameStatusView(entry.gameStatus)
        }
        .configurationDisplayName("Game Status")
        .description("Shows an overview of your game status")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
```

Configuration을 초기화하기 위해서는 아래의 정보들이 필요하다.
- kind : 위젯의 식별자, 추후 코드에서 위젯을 불러오기 위해서는 식별자를 사용한다.
- Provider : `TimelineProvider` 프로토콜을 준수하는 객체로써 위젯에게 언제 디스플레이를 업데이트해야 하는지 일러준다.
- Placeholder View : SwiftUI VIew로 위젯이 렌더링되기 이전에 보여지는 화면이다.
- Content Closure : SwiftUI View 내용을 담는다. WidgetKit은 해당 내용을 렌더링한다.
- Custom Intent : `IntentConfiguration` 을 선택한 경우 필요한 정보이며, user-configurable한 앱을 만들떄 사용한다.

위 예시에서는 Placeholder View `GameStatusPlaceholder` 와 `content Closure` 내부에 있는 GameStatusView 라는 위젯의 엔트리 뷰가 사용된다.

placeholder view에는 실제 데이터를 포함하지 않는다.

**Provider는 위젯을 위한 타임라인을 생성하여 제공한다.**

Provider가 제공한 각각의 타임라인 엔트리에 도착하면 위젯킷은 `content closure`를 다시 실행시켜 위젯의 내용을 다시 렌더링한다.

코드 최상단에 적힌 `@main` 이라는 속성은 위젯 익스텐션은 entry라는 것을 알려주기 위함이다.

<br>

## Providing Timeline Entries
---


앞서 **Provider는 타임라인 엔트리로 구성된 타임라인을 생성하여 위젯킷에게 전달해준다고 했다.** 각각의 엔트리는 위젯의 내용을 업데이트해야 하는 일정이 담겨있다.

`game status` 라는 위젯은 위젯의 timeline entry를 gameStatus라는 스트링 타입의 엔트리 기반으로 작성했다.

```swift
struct GameStatusEntry: TimelineEntry {
  var date: Date
  var gameStatus :String
}
```

위젯 갤러리 내에 나의 위젯을 넣기 위해서는, `WidgetKit`은 preview 스냅샷을 위해서 provider에게 요청한다.

`snapshot(for:with:completion:)` 메소드에 전달된 context 매개변수를 `isPreview` 프로퍼티를 이용하여 preview 여부를 확인할 수 있다.

만일, 전달받은 context가 preview라면 위젯 갤러리에서 우리 위젯을 볼 수 있다.

아래 예시 코드는 game status widget의 provider이다.

```swift
struct GameStatusProvider: TimelineProvider {
  var hasFetchedGameStatus: Bool
  var gameStatusFromServer: String

  func snapshot(with context: Context, completion: @escaping (Entry) -> ()) {
    let date = Date()
    let entry: GameStatysEntry

    if context.isPreivew && !hasFetechGameStatus {
      entry = GameStatusEntry(date: date, gameStatus: "-")
    } else {
      entry = GameStatusEntry(date: date, gameStatus: gameStatusFromServer)
    }
    completion(entry)
  }
}
```

첫 스냅샷을 요청한 이후, `WidgetKit`은 `timeline(with:completion:)` 메소드를 이용해 정기적인 타임라인을 요청한다.

TimelineProvider 프로토콜의 required 메소드 `timeline` 메소드는 timelineEntry를 생성하는 함수로써, 위젯의 업데이트 텀을 결정한다.

아래 예시는 game status 위젯의 provider가 snapshot 메소드를 이용해 싱글 엔트리 타임라인과 15분안에 새로운 타임라인을 요청하는 정책으로 구성된 타임라인 Timeline 생성 방법이다.

```swift
struct GameStatusProvider: TimelineProvider {
  func timeline(with context: Context, completion: @escaping (Timeline<GameStatusEntry>) -> ()) {
    // //Create timeline entry for "now."
    let date = Date()
    let entry = GameStatusEntry {
      date = date,
      gameStatus: gameStatusFromServer
    }

    // Create a date that's 15 minutes in the future.
  let nextUpdateDate = Calender.current.date(byAdding: .minute, value:15, to: date)!

  // Create the timeline with the entry and a reload policy with the date
  // for the next update.
  let timeline = TImeline(
    entries: [Entry], policy: .after(nextUpdateDate)
  }

  // Call the completion to pass the timeline to widgetkit.
  completion(timeline)
}
```

<br>

## Display Content in Your Widget
---

위젯은 SwiftUI 를 이용하여 뷰를 구성한다.

위젯의 configuration은 content closure 클로저를 포함하는데 해당 클로저 내부에서는 WidgetKit이 컨텐츠를 렌더링하기 위해 호출되는 것이다.

이번 game status 위젯의 configuration에서는 content closure에 해당 내용을 보여주도록 하며 `widgetFamily`를 이용하여 사이즈를 통해 어떤 사이즈의 위젯을 제공할 것 인지 결정한다.

```swift
struct GameStatusView: View {
  @Environment(\.widgetFamily) var family: WidgetFamily
  var gameStatus: GameStatus

  @ViewBuilder
  var body: some View {
    switch family {
      case .systemSmall: GameTurnSummary(gameStatus)
      case .systemMedium: GameStatusWithLastTurnResult(gameStatus)
      case .systemLarge: GameStatusWithStatistcs(gameStatus)
      default: GameDetailsNotAvailable()
    }
  }
}
```

<br>

## Add Dynamic Content to Your Widget
---
위젯에 보여지는 뷰는 모두 스냅샷에 기초한다.

우리는 다양한 SwiftUI 뷰를 이용할 수 있으며 해당 뷰를 통해 위젯이 visible한 상태일 때 업데이트를 계속하여 진행할 수 있다.


<br>

## Summary
---

- `WidgetKit Framework`와 새로운 SwiftUI에서 사용 가능한 `widget API`를 이용하면 iOS, iPadOS, macOS를 아우르는 widget을 만들 수 있다.

- `timeline Provider` : WidgetKit에게 위젯 내 데이터를 언제 업데이트 해야 하는지 일러주는 역할.

- 현재 위젯은 세 가지의 사이즈를 제공한다. (small, medium, large)

- 위젯을 구현하기 위해서는 앱에 `widget extension`을 추가해야 한다.

- 사람들이 가장 보고싶어하고 중요하게 생각하는 정보를 제공하는데 집중하는 것이 가장 중요하다.

- 구성 방식은 `StaticConfiguration` 방식과 `IntentConfiguration` 방식이 존재한다.
  - `StaticConfiguration` 방식 : 유저가 구성가능한 속성이 없는 위젯.
  - `IntentConfiguration` 방식 : 유저가 구성가능한 속성이 있는 위젯.


- Provider는 타임라인 엔트리로 구성된 타임라인을 생성하여 위젯킷에게 전달해준다.

- `@main` 이라는 속성은 위젯 익스텐션은 entry라는 것을 알려주기 위함이다.



<br>

## Reference
---

- [Developer.apple.com - widgets](https://developer.apple.com/widgets/)

- [Developer.apple.com - WidgetKit](https://developer.apple.com/documentation/widgetkit/)
