# SwiftUI

애플은 `SwiftUI` 를 아래와 같이 정의하고 있다.

![image](https://user-images.githubusercontent.com/33051018/87040110-2d713e80-c22b-11ea-8eac-53de3735ef09.png)

**Better apps, Less Code.**

SwiftUI는 단 한번의 개발로 모든 애플 플랫폼(iOS/ macOS/ watchOS, tvOS)을 관통하는 유저 인터페이스를 만들 수 있도록 하는 완전히 새로운 개발 페러다임이다.

## SwiftUI vs StoryBoard
---

기존의 iOS 혹은 애플 플랫폼 개발자라면 대부분 스토리보드 개발 방식을 숙지하고 있을 것이다.

하지만 스토리보드는 협업 도는 유지 보수가 매우 까다롭기 때문에 iOS 혹은 애플 플랫폼 개발자들 중에서는 스토리보드 방식을 좋아하지 않는 경우가 많다.

스토리보드의 이러한 단점을 SwiftUI가 대부분 해결해준다. 

SwiftUI에서는 코드를 작성하는 동시에 디자인 인터페이스가 생성되고 디자인 요소들이 코드로 생성되기 때문에 더이상 읽기 어려운 XML 방식과 싸우지 않아도 된다.

SwiftUI는 최신 버전의 운영체제에서만 작동하고, 개발이 가능하다.

<br>

```swift
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text("Hello World")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

기본적으로 SwiftUI의 View 파일은 **두 구조체**를 선언하고 있다.

- ContentView : View 프로토콜을 준수하고 있으며 뷰의 컨텐츠와 레이아웃을 정의한다.

- ContentView_Previews : PreviewProvider 프로토콜을 준수하고 있으며 구조체 내에서 `ContentView`를 선언하여 해당 뷰에 대한 미리보기 기능을 제공한다, 이를 통해 `Canvas` 에서 미리보기를 볼 수 있다.

## 뷰 커스터마이징
---

뷰를 커스터마이징 하는 방법은 크게 두 가지이다.

1. 코드를 이용한 방법
2. Inspector를 이용하는 방법 (인스펙터란, 기존에 스토리보드에서 사용하던 `attribute Inspector` 와 동일한 기능), Inspector를 이용하여 디스플레이에 변화를 주면 이에 대응되는 코드가 즉각적으로 작성된다.

![image](https://user-images.githubusercontent.com/33051018/87040995-7fff2a80-c22c-11ea-84f4-830ecc5826a5.png)

SwiftUI 뷰를 커스터마이징 하기 위해서, 우리는 `modifiers` 라고 불리는 메소드를 이용해야 한다.

**modifiers**
- modifier 메소드는 display 혹은 다른 프로퍼티를 변경하기 위해 view를 wrapping한다.
- modifier 메소드는 새로운 뷰를 반환한다. 따라서 다수의 modifier를 이용할 때는 수직 스택으로 연결하는 것이 일반적이다.


SwiftUI 뷰를 생성할 대, 우리는 뷰의 `body` 프로퍼티 내부에 **content(내용), layout(레이아웃), behavior(동작)** 에 대응되는 코드를 작성한다.

**하지만 `body` 프로퍼티는 오직 단일 뷰(Single View)를 리턴한다.**

따라서, 이를 해결하기 위해 다수의 뷰를 수평, 수직, 앞 뒤 그룹화 하는 스택을 이용하여 결합(combine)하거나 끼워(embed)할 수 있다.

기본저긍로 스택은 축에 맞춰서 스택의 내용(Content)의 중심을 맞추며 문맥에 맞춰 적절한 간격을 제공한다.

여러 개의 컴포넌트 뷰를 가진 스택에서 이들에 공간 여백을 주기 위해서는 `Spacer` 라는 modifer를 사용한다.

`Spacer` 가 공간을 확장하는 기준은 컨텐츠 기준이 아닌 부모 뷰를 기준으로 한다.

`padding` modifier는 약간의 숨 쉴 공간? 공간 여백을 제공한다.

`overlay` : 현재 뷰의 뒷쪽에 뷰를 추가하여 레이어를 더함


맵을 렌더링하기 위해서 `MapKit` 으로 부터 `MKMapView` 클래스를 이용한다.

`SwiftUI` 내부에서는 `UIView` 의 서브클래스들을 사용하기 위해서, `SwiftUI` 뷰 안으로 `UIViewRepresentable` 프로토콜을 준수하는 다른 뷰를 감쌀 것이다.



<br>

## Summary
---

- 뷰 생성시, `body` 프로퍼티 내부에 'content(내용), layout(레이아웃), behavior(동작)' 을 작성한다.

- `body` 프로퍼티는 오직 단일 뷰를 리턴한다. -> 따라서 body 하나로 다수의 뷰를 구성할 수 없음. -> 이를 해결하기 위해 뷰를 수평, 수직, 앞 뒤로 그룹화하여 사용한다.