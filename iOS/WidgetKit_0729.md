# 0729_Study

<br>

## WidgetKit
---

iOS 홈 화면 또는 macOS 알림 센터에 앱과 관련된 컨텐츠를 표시하도록 도와주는 Extension.

<br>

### Overview

위젯킷은 iOS 홈 화면 또는 macOS 알림 센터에 배치하여 사용자가 앱의 컨텐츠에 즉시적으로 접근할 수 있도록 한다.

위젯은 최신 상태를 유지하므로 사용자는 항상 최신 정보를 한 눈에 살펴볼 수 있다.

3가지 사이즈(small, medium, large) 사이즈를 제공하며 이를 통해 앱 내 정보를 디스플레이할 수 있다.

또한 유저는 위젯을 개인화하여 필요에 따른 디테일한 내용을 볼 수 있다.

또한, **Smart Stack & Smart Rotate** 을 사용하면 여러개의 위젯을 스택 쌓듯 중첩할 수 있으며 업데이트 시간에 맞춰 사용자가 정확한 시간에 적절한 앱의 대한 정보를 위젯으로 확인할 수 있도록 한다. (어떠한 위젯을 최상단에 두어 사용자에게 디스플레이 할 지는 디바이스가 결정한다.)

Widget을 구현하기 위해서는 앱에 Widget Extension을 연결해야 한다.

**Timeline Provider** 를 사용하여 위젯을 구성하며 **SwiftUI**를 사용하여 위젯의 content를 사용자에게 보여준다.

**Timeline Provider**는 위젯킷에게 위젯 내 content를 언제 업데이트 해야 하는지 알려주는 역할을 한다.

![image](https://user-images.githubusercontent.com/33051018/88744193-9d674a80-d181-11ea-9391-68d882fd6e0d.png)

<br>

## Creating a Widget Extension
---

앱의 content를 위젯을 통해 보여주기 위해서는 extension을 추가하고 수정해야한다.

<br>

### Overview

위젯은 관련성이 높고 시각적인 콘텐츠를 표시하여 사용자가 앱에 빠르게 접근하여 자세한 내용을 확인할 수 있도록 한다.

하나의 앱은 3가지 사이즈의 위젯을 제공할 수 있다고 했으며 각 사이즈 별 다수의 위젯을 제공할 수 있다.

<br>

### Add Configuration Details

Widget Extension의 기본적인 템플릿에는 구현된 초기 위젯을 제공하며 이는 **Widget** 프로토콜을 준수한다.

widget의 body에 user-configurable 프로퍼티를 통해 사용자 구성 제어가 가능하며 두가지 옵션을 제공한다.

- **StaticConfiguration** : User가 구성 가능한 속성이 없는 경우, 예를 들면 주식 시장 정보 위젯 혹은 뉴스 헤드라인 위젯
- **IntentConfiguration** : User가 구성 가능한 속성이 있는 경우, SiriKit을 이용하며 예를 들면 zip 혹은 postal code가 필요한 날씨 위젯, 배송 추적 현황 알림 위젯

configuration을 초기화 할 때는 아래 파라미터들을 요구하게 된다.

- Kind : 위젯의 식별자로써 문자열을 이용한다. 
- Provider : **TimelineProvider** 프로토콜을 준수하는 객체로써 위젯킷을 렌더링할 시기를 가지는 Timeline 을 생성한다.
  - Timeline은 **TimelineEntry** 로 구성되며 위젯킷이 위젯 컨텐츠를 업데이트할 날짜를 갖는다.
- Placeholder View : SwiftUI View로써 위젯킷이 처음으로 위젯을 렌더링하는데 사용한다.
- Content Closure : SwiftUI View를 포함하는 클로저로써 위젯 내 컨텐츠를 렌더링하기 위해 위젯킷이 이를 호출하며 Provider로 부터 TimelineEntry를 전달받는다.

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
        )
    }
}
```

위 예시의 위젯은 placeholder를 위해 `GameStatusPlaceholder` 를 사용하고 content closure에서 `GameStatusView` 를 사용한다.

Widget의 Provider는 widget을 위한 Timeline을 생성하며 이를 구성하는 각각의 TimelineEntry에는 GameStatus 대한 세부 항목이 들어있다.

**각각의 TimelineEntry에 도달하게 되면 WidgetKit은 Content Closure를 호출하여 위젯의 내용을 디스플레이한다.**

이후 Configuration의 modifier 예시들을 간략하게 살펴본다.

- .configurationDisplayName & .description : 위젯 갤러리에서 보여줄 위젯의 이름과 설명
- .supportedFamilies : 사용자에게 제공할 위젯의 사이즈 지정

`widget` 구조체 최상단에 `@main` 이라는 속성을 살펴볼 수 있는데 해당 속성은 위 구조체가 Widget Extension의 Entry Point임을 알리는 역할을 한다.

<br>

### Provide Timeline Entries

**TimelineProvider** 는 timeline을 생성한다고 살펴봤으며 생성되는 timeline은 TimelineEntry들로 구성된다고 하였다.

각각의 TimelineEntry는 위젯의 content를 언제 업데이트 할 지에 대한 날짜와 시간이 들어있다.

Game Status widget에서는 TimelineEntry 내에 **날짜** 와 **게임의 상태** 값을 아래와 같이 갖게 될 것이다.

```swift
struct GameStatusEntry: TimelineEntry { 
    var date: Date              // 위젯을 업데이트 할 Date
    var gameStatus: String      // 게임 상태를 저장할 String
}
```

위젯 갤러리에서 위젯을 보여주기 위해서 WidgetKit은 Provider에게 `snapshot`을 요청한다.

`snapshot` 함수에서 `isPreview` 프로퍼티를 확인하여 미리보기 가능 여부를 제어할 수 있다.

아래 예시 코드는 Game Status Widget의 Provider로써 서버로부터 데이터를 가져오지 못한경우 빈 데이터를 보여주는 `snapshot` 함수다.

```swift
struct GameStatusProvider: TimelineProvider {
    var hasFetchedGameStatus: Bool      // 서버로부터 데이터를 가져왔는지 확인하기 위한 flag
    var gameStatusFromServer: String

    func snapshot(with context: Context, completion: @escaping (Entry) -> ()) {
        let date = Date()
        let entry: GameStatusEntry

        if context.isPreview && !hasFetehedGameStatus {
            entry = GamesStatusEntry(date: date, gameStatus: "-")
        } else {
            entry = GamesStatusEntry(date: date, gameStatus: gameStatusFromServer)
        }
        completion(entry)
    }
}
```

WidgtKit은 Provider에게 초기 snapshot을 요청한 이후에 `timeline(for:with:completion:)` 을 요청한다.

**Timeline은 하나 이상의 TimelineEntry + 이후 타임라인 요청시 필요한 reload policy를 포함한다.**

아래 예시는 Game Status Widget의 Provider가 서버로부터 받아온 데이터 (현재 게임 상태)를 가진 entry로 구성된 Timeline과 15분 내에 새로운 Timeline을 요청하는 정책이다.

```swift
struct GameStatusProvider: TimelineProvider {
    func timline(with context: Context, completion: @escaping (Timeline<GameStatusEntry>) -> ()) {
        // 현재 시간을 기준으로 timelineEntry 생성
        let date = Date()
        let entry = GameStatusEntry(
            date: date,
            gameStatus: gameStausFromServer
        )

        // 현재로 부터 15분 후의 date 생성
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 15, to: date)!

        // 위에서 생성한 entry와 policy 기반으로 Timeline 생성
        let timeline = Timeline(
            entries: [entry],
            policy: .after(nextUpdateDate)
        )

        // WidgetKit에게 Timeline을 전달하기 위한 completion
        completion(timeline)
    }
}
```

<br>

### Display Content in Your Widget

Widget은 SwiftUI View를 이용하여 자신의 content를 보여준다.

앞서 살펴봤듯이 Widget의 configuration 내에는 Content Closure가 존재했으며 WidgetKit은 위젯의 content를 보여주고자 할 때 이를 호출한다.

사이즈 별 보여주고자 하는 뷰가 다를 경우, `widgetFamily`를 이용해 지정한 View를 보여줄 수 있다.

```swift
struct GameStatusView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var gameStatus: GameStatus

    @ViewBuilder
    var body: some View {
        switch family {
            case .systemSmall: GameTurnSummary(gameStatus)
            case .systemMedium: GameStatusWithLastTurnResult(gameStatus)
            case .systemLarge: GameStatusWithStatistics(gameStatus)
            default: GameDetailsNotAvailable()
        }
    }
}
```

구조체 내부 상단에 `@Environment` 를 이용하여 widgetFamily를 생성하고 이를 기반으로 사이즈에 따라 분기하여 지정한 View를 보여준다.

이때, 뷰는 사용하는 뷰의 유형이 다양하므로 `@ViewBuilder` 로 본문을 선언한다.

<br>

### Declare Multiple Widgets in Your App Extension

앞서 살펴봤던 GameStatusWidget 예시에서는 해당 구조체 위에 `@main` 이라는 속성을 정의하여 Widget Extension의 엔트리 포인트를 지정하였다.

여러개의 위젯을 제공하기 위해서는 `WidgetBundle` 프로토콜을 준수하는 구조체를 생성해야 하며 body 프로퍼티 내에 제공할 Widget들을 기재한다.

또한 `@main` 속성을 Widget이 아닌 `WidgetBundle`에 추가하여 WidgetKit에게 다양한 위젯을 제공할 것임을 알려야한다.

아래 예시는 3개의 위젯을 제공하는 경우에 대한 예시이다.

```swift
@main
struct GameWidgets: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        GameStatusWidget()
        CharacterDetailWidget()
        LeaderboardWidget()
    }
}
```

<br>

### Widget Protocol

Widget의 3 가지 핵심 컴포넌트는 아래와 같다.

- Configuration : 위젯의 기본적인 구성을 담당한다.
- TimelineProvider : 시간이 지남에 따라 위젯의 View를 업데이트하는 프로세스를 주도한다.
- SwiftUI : WidgetKit에서 위젯을 표시하기 위해 사용되는 View

**Implement a Widget**

```swift
// 위젯의 content와 동작을 정의한다.
var body: Self.Body

// 위젯의 content에 대한 configuration를 담당한다.
associatedtype Body: WidgetConfigurtion

// 위젯의 content 구성을 정의하기 위해 채택하는 프로토콜.
protocol WidgetConfiguration
```

<br>

## Keeping a Widget Up To Date
---

Timeline 설정에 따라서 시간의 흐름에 따른 적절한 정보를 출력시킬 수 있다.

<br>

### Overview

Widget은 자신의 content를 보여주기 위해 SwiftUI를 사용한다.

결론적으로 Widget Extension은 Widget이 스크린에 있다고 하더라도 끝없이 활성화되지는 않는다.

항상 활성상태는 아니지만 위젯에 보여지는 Content를 최신 상태로 유지할 수 있는 몇 가지 방법이 있다.

<br>

### Generate a Timeline for Predictable Events

위젯에 성격에 따라 예상가능한 포인트가 있으며 해당 지점에서 컨텐츠를 업데이트 하는 것이 합리적이다.

예를 들어, 날씨 정보를 보여주는 위젯의 경우에는 한 시간에 한번씩 업데이트를 하는 방법이 있다.

이러한 **업데이트 시간**을 미리 예측하고 계획함으로써 WidgetKit이 적절한 시점에서 widget을 업데이트해주는 것이 바람직하다.

widget을 생성할 때, 우리는 위젯을 언제 업데이트 할 지에 대한 정책등을 제시하는 **TimelineProvider**를 구현한다.

WidgetKit은 Provider로 부터 **타임라인**을 전달받고 위젯의 업데이트 시기를 추적하는데 이를 사용한다.

```swift
let timelineEntries: [TimelineEntry]
```

Timeline은 TimelineEntry 타입의 배열 객체이며 Timeline 내 각각의 TimelineEntry는 Date(시간 및 날짜)값을 기본적으로 갖는다, 그 외에는 위젯이 뷰에 렌더링하기 위해 필요한 추가적인 정보를 갖게된다.

Timeline은 TimelineEntry 외에도 reload Policy를 갖는다.

**reload polish는 WidgetKit에게 새로운 타임라인을 언제 요청해야할 지 명시한다.**

아래 예시는 캐릭터의 체력 레벨을 보여주는 위젯이다.

체력이 100 이하인 경우 시간당 25%를 회복한다. 예를 들어 현재 체력이 25%인 경우 모두 회복하는데 3시간이 소요된다.

아래 다이어그램은 **WidgetKit이 Provider에게 어떻게 Timeline을 요청하는지, TimelineEntry에 지정된 시간에 따라 어떻게 렌더링 하는지**에 대한 흐름이다.

![image](https://user-images.githubusercontent.com/33051018/88759125-07451b80-d1a5-11ea-8a05-4bba96d1ce0d.png)

WidgetKit과 TimelineProvider와의 상호작용을 살펴본다.

1. Provider에게 Timeline을 요청한다.
2. Timline 내에 각각의 TimelineEntry에 따라 위젯을 업데이트 및 렌더링한다.
3. 마지막 Entry가 실행되고 난 이후 Provider에게 다시 Timeline을 요청한다. reload Policy에 따라 Timeline을 제공한다.
4. 만일 새로운 Timeline을 제공받았다면 WidgetKit은 1~3 사이클을 반복한다.

위 예시에서는 reload polish 중 `atEnd` 와 `never` 를 사용하였으나 Provider는 그 외 정책 사용 또한 가능하다.

**TimelineReloadPolicy**
- `atEnd` : WidgetKit이 마지막 Entry가 pass 한 이후 새로운 Timeline을 요청하는 정책.
- `after` : WidgetKit이 새로운 Timeline을 요청할 시간 및 날짜를 미리 지정하는 정책.
- `never` : static View, 새로운 타임라인 요청을 하지 않는 정책.
  
![image](https://user-images.githubusercontent.com/33051018/88760159-6310a400-d1a7-11ea-9377-d5a52bde62fe.png)

위 예시에서 첫번째 Timeline의 Reload Policy가 `after(2 hr)` 인 것을 확인할 수 있다.

해당 Timeline 내에는 `Now, 1h, 2h, 3h` 총 4개의 Entry가 있음에도 불구하고 현 시점으로부터 2시간 이후 새로운 타임라인을 요청하는 정책을 사용했기 때문에 `3h` 엔트리는 렌더링되지 않고 새로운 타임라인을 요청한다.

<br>

### Inform WidgetKit when a Timeline Changes

우리의 앱은 WidgetKit에게 새로운 타임라인을 요청하고 위젯의 content를 업데이트하라고 지시할 수 있다.

특정 위젯의 타임라인을 업데이트 새롭게 요청할때는 `WidgetCenter`를 이용한다.

```swift
WidgetCenter.shared.reloadTimelines(ofKind: Widget-Kind)
```

`reloadTimelines` 함수의 파라미터로 주어진 `ofKind`는 WidgetConfiguration시 사용했던 `kind`와 동일하다.

만일 WidgetBundle을 이용하여 여러개의 위젯을 지원한다면 아래 함수를 통해 모든 위젯의 Timeline을 reload 할 수 있다.

```swift
WidgetCenter.shared.reloadAllTimelines()
```

<br>

### TimelineEntry Protocol

TimelineEntry는 위젯을 업데이트 해야 할 시점(date)와 widget view에 렌더링 하기 위해 필요한 추가적인 정보를 포함한다.

<br>

**OverView**

`TimelineProvider`는 하나 혹은 그 이상의 Timeline Entries를 포함한다.

WidgetKit은 widget configuration에서 정의한 `content` 블록을 `entry`를 전달함으로써 실행한다.

(Widget의 Content Block & EntryView 모두 Timeline Entry를 기반으로 View가 렌더링된다.)

`TimelineEntry`를 준수하는 구조체를 정의할 때, 위젯을 렌더링하는데 필요한 추가 정보를 포함해야 한다.

```swift
struct CharacterDetailEntry: TimelineEntry {
    var date: Date
    var healthLevel: Double
}
```

게임 내 케릭터의 체력을 보여주는 위젯이 있다고 가정한다면, 체력을 Widget View에 렌더링해줘야 할 것이며 이를 위해서는 TimelineEntry 내에 해당 값을 저장하고 있는 변수가 필요하다.

```swift
struct CharacterDetailWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "character-detail",
            provider: CharacterDetailProvider(),
            placehloder: CharacterPlaceholderView()) { entry in
                CharacterDetailView(entry: entry)       // Content Closure에 entry 전달.
            }
        )
    }
}
```

이후 WidgetConfiguration 내 Content Block에서 entry를 파라미터로 전달하여 뷰를 렌더링한다.


<br>

## Summary
---

- **Timeline Provider** 를 사용하여 위젯을 구성하며 **SwiftUI**를 사용하여 위젯의 content를 사용자에게 보여준다.
- **Timeline Provider** 는 위젯킷에게 위젯 내 content를 언제 업데이트 해야 하는지 알려주는 역할을 한다.
  - Timeline Provider는 위젯킷을 렌더링할 시기를 가지는 Timeline을 생성하며 이는 TimelineEntry로 구성된다. TimelineEntry에는 위젯킷이 위젯 컨텐츠를 업데이트할 날짜 정보를 갖는다.
- Content Closure : SwiftUI View를 포함하는 클로저로써 위젯 내 컨텐츠를 렌더링하기 위해 위젯킷이 이를 호출하며 Provider로 부터 TimelineEntry를 전달받는다.
- Provider는 Widget을 위한 Timeline을 생성하며 이를 구성하는 각각의 TimelineEntry에는 위젯에 대한 세부 항목 (ex: 업데이트 기간) 등이 들어있다.
  - 각각의 TimelineEntry에 도달하게 되면 WidgetKit은 Content Closure를 호출하여 위젯의 내용을 디스플레이한다.

- Widget 구조체 선언부 상단에는 `@main` 이라는 속성을 확인할 수 있는데 이는 Widget Extension의 Entry Point임을 알리는 것이다.
  
- TimelineProvider는 Timeline을 생성하며 이는 TimelineEntry로 구성된다. TimelineEntry에는 위젯 내 콘텐츠를 업데이트할 날짜와 시간을 지정해야한다.

- **Timeline은 하나 이상의 TimelineEntry + 이후 타임라인 요청시 필요한 reload policy를 포함한다.**
  - reload Policy는 현재 타임라인이 끝나고 새로운 타임라인을 요청할 때 사용하는 정책이다.

- 여러개의 위젯을 제공하기 위해서는 `WidgetBundle` 프로토콜을 준수하는 구조체를 생성해야 하며 body 프로퍼티 내에 제공할 Widget들을 기재한다.
- 또한 `@main` 속성을 Widget이 아닌 `WidgetBundle`에 추가하여 WidgetKit에게 다양한 위젯을 제공할 것임을 알려야한다.

- Timeline 설정에 따라서 시간의 흐름에 따른 적절한 정보를 출력시킬 수 있다.
- Widget Extension은 Widget이 스크린에 디스플레이되어 있다고 하더라도 항시 활성상태를 가질수는 없다.
  - 항시 활성상태는 아니지만 위젯에 보여지는 Content를 최신 상태로 유지할 수 있는 방법은 있다.
- 위젯의 성격에 따라 업데이트가 진행되어야 할 예측 시점이 존재하며 이러한 업데이트 시간을 미리 예측하고 계획함으로써 WidgetKit이 적절한 시점에 widget을 업데이트 할 수 있도록 하는 것이 바람직하다.

- WidgetKit은 Provider로 부터 **타임라인**을 전달받고 위젯의 업데이트 시기를 추적하는데 이를 사용한다.
- Timeline은 TimelineEntry 타입의 배열 객체이며 Timeline 내 각각의 Entry는 기본적으로 Date(시간 및 날짜)값을 가져야한다.

- Timeline = TimelineEntry + reload Policy로 구성된다.
  - **TimelineEntry 는 위젯 업데이트 시점(Date) + 위젯 뷰에 렌더링할 데이터로 구성된다.**
  - **reload polish는 WidgetKit에게 새로운 타임라인을 언제 요청해야할 지 명시한다.**

- reload policy는 atEnd, after, never 가 제공된다.
- reload policy에 따르지 않고 새로운 타임라인을 요청하고 싶을때는 `WidgetCenter.shared.reloadTimelines` 를 이용한다.

- **`TimelineEntry`를 준수하는 구조체를 선언할 때, configuration 내 content block에는 위젯을 렌더링하는데 필요한 추가 정보를 포함해야 한다.**

