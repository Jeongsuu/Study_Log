# WidgetKit Framework & How it works

<br>

위젯은 기존에 존재하는 프로젝트에 연결하여 사용하는 익스텐션이다.

따라서, 기존 프로젝트가 없다면 빈 iOS 프로젝트를 하나 만들고 시작한다.

<br>

## WidgetKit Framework
---

WidgetKit이 어떻게 구성되는가를 알아보기 위해 프로젝트를 만들고 WidgetKit Extension을 연결한다.

`Widget`을 상속하며 `@main` 이라는 속성을 가진 구조체가 시작점이다.

```swift
@main
struct widget: Widget {
    private let kind: String = "widget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: Provider(),
                            placeholder: PlaceholderView())
        { entry in
            widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        
    }
}
```

위 코드에서 얻어낼 수 있는 정보는 아래와 같다.

StaticConfiguration 생성자를 살펴본다.

- `kind` : 위젯 센터에서 각각의 위젯들을 구분하기 위해 사용하는 위젯 식별자다.

- `Provider` : `TimelineProvider` 타입의 구조체로써 위젯의 핵심 엔진이다. 위젯에 데이터를 제공하고 데이터 업데이트 간격을 설정한다.
- `placeholderView` : 위젯이 로드되는 동안 보여줄 뷰를 지정한다.
- `content` : (Provider.Entry) -> Content 타입으로 위젯에 렌더링할 뷰를 의미한다.

이후 아래에 달린 수정자들은 위젯 갤러리에서 보여줄 위젯의 이름과 위젯에 대한 간단한 설명이다.

<br>

## WidgetKit Timeline Provider
---

이름을 보면 알 수 있듯, `Provider` 는 위젯에게 무언가를 공급하는 녀석이다.

`TimelineProvider` 프로토콜을 준수하며 해당 프로토콜은 두 가지 메소드 (snapshot, timeline) 를 반드시 구현해야한다.

```swift
struct Provider: TimelineProvider {
    public typealias Entry = SimpleEntry

    public func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
```

- `snapshot` 함수는 Timeline Provider가 데이터를 로드하는 동안 위젯 뷰를 즉각적으로 표시하는데 사용된다. 해당 뷰는 위젯 갤ㄹ리에도 표시되므로 더미 데이터를 통해 스냅샷을 작성해야한다.

- `SimpleEntry` 는 실제로 단일 TImeline Entry에 대한 데이터를 보유하고 이를 위젯 컨텐츠에 표시한다.

- `timeline` : 반면에 `timeline` 함수는 엔트리를 생성하는 함수다. 이를 통해 Timeline Entry를 업데이트 하는 간격을 설정할 수 있다. 

위 코드에서는 매시간 업데이트하는 데 사용되는 5개의 타임라인 항목을 추가한다.

```swift
let timeline = Timeline(entries: entries, policy: .atEnd)
```

위 코드가 Timeline 인스턴스를 생성하는 부분이다. Timeline 인스턴스는 `TimelineReloadPolicy` 라는 것을 갖게되는데 이를 통해 시스템은 타임라인 함수를 언제 호출할지 결정한다. 위 코드에서는 `.atEnd` 로 지정하였으며 이는 
위젯에 다섯 번째 `SimpleEntry`가 디스플레이 된 이후, 시스템은 다음 배치를 위해 Timeline 함수를 호출한다.

추가적으로, 만일 위젯의 엔트리를 다시 로드하고 싶을때는 `WidgetCenter`의 API를 사용하면 된다.

그러면 특정 타임라인 혹은 모든 타임라인을 리로드 할 수 있다.

**TimelineProvider** 구조체는 정말 매우매우 중요하다.

동적으로 변하는 컨텐츠를 가져와서 특정 간격으로 위젯 내용을 업데이트하는 모든 역할을 하고있다.

<br>

## SwiftUI Widget View

WidgetKit이 어떻게 작동하는지 대략적으로 살펴봤으니 이제는 스크린에 디스플레이 되는 Widget의 SwiftUI 에 대하여 알아본다.

```swift
struct SimpleEntry: TimelineEntry {
    public let date: Date
}

struct widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
            .foregroundColor(.red)
    }
}
```
위 구조체를 보면 widgetEntryView 내부에서는 `Provider.Entry`를 기반으로 데이터를 채운다.

**`Provider.Entry`는 우리 위젯뷰에서 데이터소스 역할을 한다.**

`TimelineProvider`를 다시 보면, 최상단에 typealias를 볼 수 있다.
`SimpleEntry` 구조체의 타입을 `Entry`로 지정해놓았다.

**TimelineProvider에서 지정된 Timeline Entry를 통해 위젯 뷰 내부 데이터를 채우는 동안 Placeholder를 띄운 이후, 실제 위젯이 보여진다.** 

<br>

## Summary
---
- 위젯은 WidgetBundle의 일부일 때 시스템에 의해 인식되며 번들에는 앱 사용자들의 홈 스크린에 보여질 위젯이 포함되어있다.