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

`WidgetKit` 을 사용하면 iOS 홈 화면 도는 macOS 알림센터에 위젯을 배치하여 앱의 컨텐츠에 다이렉트로 접근할 수 있다.

또한, 위젯은 항상 최신 상태를 유지하므로 사용자는 매번 업데이트된 최신 정보를 한 눈에 볼 수 있다.

현재 위젯은 세 가지의 사이즈를 제공한다.

small, medium, large 사이즈를 제공하며 화면 내 넓은 범위를 이용하여 다양한 데이터를 보여준다.

또한 사용자가 우너하는 특정 요구에 따라 해당 데이터를 보여주도록 사용자화 할 수 있으며 자신이 원하는 위치에 위젯을 배치하는 것도 당연히 가능하다.

위젯을 구현하기 위해서는 앱에 `widget extension`을 추가해야 한다.

또한, `timeline provider`를 이용하여 위젯을 수정해야 한다. 그리고 위젯 컨텐츠를 구성하기 위해 `SwiftUI`를 사용해야 한다.

> timeline Provider : WidgetKit에게 위젯 내 데이터를 업데이트 해야 하는지 알려주는 역할.

![image](https://user-images.githubusercontent.com/33051018/86920847-44e5f400-c165-11ea-9dbd-f1c4a5f838c4.png)

<br>





<br>

## Summary
---

- `WidgetKit Framework`와 새로운 SwiftUI에서 사용 가능한 `widget API`를 이용하면 iOS, iPadOS, macOS를 아우르는 widget을 만들 수 있다.

- 현재 위젯은 세 가지의 사이즈를 제공한다. (small, medium, large)

- 위젯을 구현하기 위해서는 앱에 `widget extension`을 추가해야 한다.




<br>

## Reference
---

- [Developer.apple.com - widgets](https://developer.apple.com/widgets/)

- [Developer.apple.com - WidgetKit](https://developer.apple.com/documentation/widgetkit/)
