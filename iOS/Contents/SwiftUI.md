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

SwiftUI는 빠르고 효율적인 앱 개발 환경을 제공할 뿐만 아니라 코드를 크게 변경하지 않아도 다양한 애플 플랫폼에서 동일한 앱을 사용할 수 있게 한다.

<br>

## SwiftUI의 선언적 구문
---

SwiftUI에서는 기존의 `UIKit`과 인터페이스 빌더를 사용한 레이아웃 설계 및 동작 구현과는 달리 **선언적 구문**을 이용한다.

이를 통해 단순하면서도 직관적인 구문을 이용하여 화면을 기술할 수 있도록 해준다.

이 과정에서 기본적으로 레이아웃에 포함할 컴포넌트를 선언하고, **수정자(modifier)**를 사용하여 속성을 명시한다.

<br>

## SwiftUI View
---

사용자 인터페이스 레이아웃은 뷰 사용과 생성, 그리고 결합을 통해 SwiftUI로 구성된다.

SwiftUI에서 뷰는 View 프로토콜을 준수하는 구조체로 선언된다.

이를 위해, 구조체는 `body` 프로퍼티를 가져야 하며, 이 `body` 프로퍼티 안에 뷰가 선언되어야 한다.

**SwiftUI에는 사용자 인터페이스를 구축할 때 사용될 수 있는 다양한 뷰(ex: 텍스트 레이블, 텍스트 필드, 메뉴, 토글 ..etc) 등이 내장되어 있으며 각각의 뷰는 모두 Vieew 프로토콜을 준수하는 독립적인 객체다.**

`body` 프로퍼티 내에 원하는 뷰를 배치하여 다른 뷰를 추가할 수 있다.

하지만, `body` 프로퍼티는 단 하나의 뷰를 반환하도록 구성되어 있어서 아래와 같이 뷰를 추가하면 에러가 발생한다.

```swift
struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
        Text("Goodbye, World!")
    }
}
```

`body` 프로퍼티 내에 두 개의 뷰가 들어있기 때문에 발생하는 에러다.

**이러한 경우에는 스택이나 폼 같은 컨테이너 뷰를 이용하여 각각의 뷰들을 감싸서 반환해야한다.**

<br>

## ContentView
---

`ContentView` 란 SwiftUI에서 사용하는 가장 일반적인 뷰 구조체다.

```swift
struct ContentView: View {
    var body: some View {
        Text("Hello World")
    }
}
```

일반적으로 위와 같이 초기화되며 코드는 짧지만 매우 많은 내용을 함축하고있다.

1. `View`는 SwiftUI 내 구조체다.
2. SwiftUI에서 사용하는 모든 뷰는 반드시 `View` 프로토콜을 준수 해야한다.
3. 해당 프로토콜은 `body` 라는 연산 프로퍼티를 내포하며 실제 layout은 body의 역할이다.
4. body는 `some View` 타입을 반환한다.


SwiftUI에서 View는 최대 10개의 Child View를 가질 수 있고 만일 10개가 초과하게 된다면 Group혹은 Stack 컨테이너를 통해 그룹핑을 해줘야 한다.

SwiftUI의 사용자 인터페이스는 View 프로토콜을 따르는 컴포넌트들로 구성된다.

View 프로토콜을 따르기 위해서 구조체는 View 자신인 `body` 프로퍼티를 포함해야한다.

뷰의 모양과 동작은 수정자(modifier)를 적용하여 구성할 수 있으며, 커스텀 뷰와 하위 뷰를 생성하기 위해 수정되거나 그룹핑 될 수 있다.

<br>

## 수정자 순서
---

수정자들을 연결하여 사용할 때는 수정자들이 적용되는 순서가 매우 중요하다.

```swift
Text("Sample Data")
    .border(Color.black)
    .padding()
```

border 수정자는 뷰 주변의 경계선을 그리고, padding 수정자는 뷰 주변의 여백을 추가한다.

```swift
Text("Smaple Data")
    .padding()
    .border(Color.black)
```

두 개의 코드는 수정자의 순서만 다르다.

패딩을 먼저 주고 경계선을 그리냐, 경계선을 그리고 패딩을 주느냐에 따라 렌더링되는 뷰에서 차이를 확인할 수 있다.

<br>

## SwiftUI 스택
---

SwiftUI는 버튼, 레이블, 슬라이더, 토글 처럼 앱을 개발할 때 사용될 다양한 종류의 사용자 인터페이스 컴포넌트를 갖는다.

또한, 사용자 인터페이스의 구성 방법과 화면의 방향 및 크기에 따라 대응하는 방법을 정의하는 레이아웃 뷰를 제공한다.

대표적으로 스택 컨테이너를 이용해 다양한 뷰를 그룹핑 할 수 있다.

**SwiftUI는 VStack(수직), HStack(수평), ZStack(중첩) 형태인 3개의 스택 레이아웃 뷰를 제공한다.**

```swift
import SwiftUI

struct Demo: View {
    var body: some View {
        
        VStack {        // 수직 스택
            Text("Hello, World!")
            Text("Hello, World!")
            
            HStack {    // 수평 스택
                Image(systemName: "goforward.10")
                Image(systemName: "goforward.15")
                Image(systemName: "goforward.30")
            }
        }
    }
}
```

![image](https://user-images.githubusercontent.com/33051018/87751134-5059af00-c838-11ea-9192-d33d4e8a14aa.png)

코드가 직관적이기 때문에 대략적으로 상상한 그 모습이 그대로 렌더링 된다.

## Spacer, alignment, padding
---

SwiftUI는 뷰 사이 공간을 추가하기 위한 컴포넌트를 갖고 있다.

`Spacer()` 는 부모 뷰의 공간을 기준으로 여백을 추가한다.

`alignment`는 이름 그대로 정렬의 기준을 지정한다. 이 또한 각각의 스택마다 다른 정렬 기준을 제공한다.

`padding()` 은 컴포넌트들 사이에 숨 쉴 공간, 약간의 여백을 제공한다, padding의 인자로 직접 제공할 공간 크기도 제공할 수 있다.


<br>

## State, Observable 객체, 그리고 Environment 객체
---

SwiftUI에서는 상태 프로퍼티, Observable 객체, Environment 객체를 제공한다.

이들 모두는 사용자 인터페이스의 모양과 동작을 결정하는 상태를 제공한다.

뷰와 바인딩된 State 객체가 시간이 지남에 따라 변하면 그 상태에 따라 자동으로 뷰가 업데이트 된다.

<br>

### 상태 프로파티

**상태 프로퍼티**는 상태에 대한 가장 기본적인 혀애팅며, 뷰 레이아웃의 현재 상태를 제어하기 위한 목적으로 사용된다.

상태 프로퍼티는 String 또는 Int와 같이 간단한 타입을 저장하기 위해 사용되며, `@State` 프로퍼티 래퍼를 사용하여 선언한다.

```swift
struct ContentView: View {

    @State private var wifiEnabled = true
    @State private var userName = ""

    var body: some View {
        ...
    }
}
```

상태 프로퍼티 값은 해당 뷰에 속해있기 때문에 `private` 접근 레벨로 선언되어야 한다.

상태 프로퍼티 값이 변경되었다는 것은 그 프로퍼티가 선언된 뷰 계층구조를 다시 렌더링해야 한다는 신호다.

따라서, 상태 프로퍼티의 값에 따라 해당 상태 프로퍼티가 속해있는 뷰가 다시 재생성되고 디스플레이된다.

**상태 프로퍼티가 선언되면 레이아웃에 있는 뷰와 바인딩 할 수 있다. 이후 바인딩 되어 있는 뷰에서 어떠한 변경이 일어나면 해당 상태 프로퍼티에 자동으로 반영된다.**

상태 프로퍼티와의 바인딩은 프로퍼티 앞에 `$` 사인을 붙인다.

아래 예제에서 `TextField` 뷰는 사용자가 입력한 텍스트를 저장하는데 사용하기 위해 `userName` 이라는 상태 프로퍼티와 바인딩된다.

```swift
import SwiftUI

struct textField: View {
    
    @State private var wifiEnabled = true
    @State private var userName = ""
    
    var body: some View {
        VStack {
            TextField("Enter user name", text: $userName)
        }
    }
}

struct textField_Previews: PreviewProvider {
    static var previews: some View {
        textField()
    }
}
```

`userName` 이라는 상태 프로퍼티를 선언한다.

이후 `body` 프로퍼티 내에서 `TextField` 컴포넌트를 생성할 때 인자로 title과 text를 전달받는데, 사용자가 해당 `TextField` 에 값을 입력하게 되면 바인딩은 입력받은 텍스트를 `userName` 프로퍼티에 저장할 것이다.

이와 같이 상태 프로퍼티에 변화가 생길 때 마다 뷰는 SwiftUI에 의해 다시 렌더링된다.

<br>

### 상태 바인딩

상태 프로퍼티는 해당 프로퍼티가 선언된 뷰와 하위 뷰에 대한 상태값이다.

하지만 어떠한 뷰가 하나 이상의 하위 뷰를 가지고 있으며 동일한 상태 프로퍼티에 대해 접근해야 하는 경우가 발생한다.

이러한 경우 **상태 바인딩**이 필요하다.

```swift
..
..
VStack {
    Toggle(isOn: $wifiEnabled) {
        Text("Enable WiFi")
    }
    TextField("Enter user name", text: $username)
    WifiImageView()         // 하위 뷰 호출
    }
}
..
..
struct wifiImageView: View {
    
    var body: some View {
        Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
    }
}
```

우리는 `wifiEnabled` 상태 프로퍼티 값에 따라서 `Image` 셋팅을 달리 해주고 싶다.

`wifiImageView` 라는 View를 생성하여 `wifiEnabled` 상태 프로퍼티에 따라 사진을 달리 뿌려준다.

하지만, `wifiImageView`는 메인 뷰에 포함되지 않기 때문에 `private` 지정자를 갖는 상태 프로퍼티에 접근이 불가능하다.

다시 말해, `wifiImageView` 입장에서는 `wifiEnabled` 상태 프로퍼티는 정의되지 않은 변수이다.

이러한 경우, `@Binding` 프로퍼티 래퍼를 이용하여 프로퍼티를 선언하면 해결이 가능하다.

```swift

struct wifiImageView: View {

    @Binding var wifiEnabled: Bool          // 상태 프로퍼티 바인딩

    var body: some View {
        Image(systemName: wifiEnabled ? "wifi" : "wifi.splash")
    }
}
```

위와 같이 작성을 하고 하위 뷰가 호출될 때 상태 프로퍼티 값을 바인딩해주면 된다.

```swift
WifiImageView(wifiEnabled: $wifiEnabled)
```

메인 뷰에서 하위 뷰를 호출될 떄 상태 프로퍼티에 대한 바인딩을 전달하면 메인 뷰의 상태 프로퍼티를 하위 뷰에서도 사용할 수 있다.

<br>

### Observable 객체

앞서 살펴본 상태 프로퍼티는 뷰의 상태를 저장하는 방법을 제공하며 기본적으로 해당 뷰에서만 사용이 가능했다.

즉, 하위 뷰가 아니거나 상태 바인딩이 구현되어 있지 않다면 다른 뷰에서는 접근이 불가능하다.

뿐만 아니라, 일시적인 것이기 때문에 부모 뷰가 사라지면 상태 프로퍼티도 함께 사라진다.

반면 **Observable 객체**는 여러 다른 뷰들이 외부에서의 접근이 가능하며 영구적인 데이터를 표현하기 위해 사용된다.

**Observable 객체는 published 된 프로퍼티로서 데이터 값을 게시한다.**

이후 Observer 객체는 게시자를 구독하여 게시된 프로퍼티가 변경될 때 마다 업데이트를 받는다.

**Combine** 프레임워크에 포함되어 있는 `Observable` 객체는 게시자(publisher)와 구독자(subscriber) 간의 관계를 쉽게 구축할 수 있다.

**Observable 객체는 시간이 지남에 따라 반복적으로 변하는 데이터 값인 동적 데이터를 래핑하는 데 사용할 때 매우 강력하다.**

<br>

## Summary
---

- SwiftUI 는 기존의 UIKit + 인터페이스 빌더를 사용한 레이아웃 방식과는 달리 **선언적 구문** 을 이용한다.
  
- 즉, **사용자 인터페이스를 어떤 모양으로 만들것인지를 선언하는 방식**으로 레이아웃을 생성할 수 있다.
  
- SwiftUI에서 뷰는 View 프로토콜을 준수하는 구조체로 선언된다.
  
- SwiftUI에는 사용자 인터페이스를 구축할 때 사용될 수 있는 다양한 뷰(ex: 텍스트 레이블, 텍스트 필드, 메뉴, 토글 ..etc) 등이 내장되어 있으며 각각의 뷰는 모두 Vieew 프로토콜을 준수하는 독립적인 객체다.
  
- `body` 프로퍼티는 하나의 뷰를 반환하므로 `body` 내에 여러 뷰를 추가하고 싶을때는 스택 혹은 폼과 같은 컨테이너 뷰를 이용해 각각의 뷰를 감싸서 반환해야한다.

- 뷰의 모양과 동작은 수정자(modifier)를 적용하여 구성할 수 있으며, 커스텀 뷰와 하위 뷰를 생성하기 위해 수정되거나 그룹핑 될 수 있다.

- 수정자를 뷰에 적용하면 수정자가 적용된 뷰가 반환되며 수정자를 적용하는 순서는 중요한 영향을 미친다.

- SwiftUI는 VStack(수직), HStack(수평), ZStack(중첩) 형태인 3개의 스택 레이아웃 뷰를 제공한다.

- SwiftUI에서는 State 프로퍼티, Observable 객체, Environment 객체를 제공하며 이들 모두는 사용자 인터페이스의 모양과 동작을 결정하는 상태를 제공한다.

- 뷰와 바인딩된 State 객체가 시간이 지남에 따라 변하면 그 상태에 따라 뷰가 자동으로 업데이트 된다.

- 상태 프로퍼티 값은 해당 뷰에 속해있기 때문에 `private` 접근 레벨로 선언되어야 한다, 상태 프로퍼티의 값이 변경되면 그 프로퍼티가 선언된 뷰 계층구조가 다시 재생성되고 렌더링된다.

- 상태 프로퍼티가 선언되면 레이아웃에 있는 뷰와 바인딩 할 수 있다. 이후 바인딩 되어 있는 뷰에서 어떠한 변경이 일어나면 해당 상태 프로퍼티에 자동으로 반영된다.

- **Observable 객체**는 여러 다른 뷰들이 외부에서의 접근이 가능하며 영구적인 데이터를 표현하기 위해 사용된다.

- Observable 객체가 데이터 값을 게시하면 Observer 객체가 이를 구독하여 게시된 프로퍼티가 변경될 때 마다 업데이트를 받는다.

- **Combine** 프레임워크에 포함되어 있는 `Observable` 객체는 게시자(publisher)와 구독자(subscriber) 간의 관계를 쉽게 구축할 수 있다.

- Observable 객체는 시간이 지남에 따라 반복적으로 변하는 데이터 값인 동적 데이터를 래핑하는 데 사용할 때 매우 강력하다.


- 뷰 생성시, `body` 프로퍼티 내부에 'content(내용), layout(레이아웃), behavior(동작)' 을 작성한다.

- `body` 프로퍼티는 오직 단일 뷰를 리턴한다. -> 따라서 body 하나로 다수의 뷰를 구성할 수 없음. -> 이를 해결하기 위해 뷰를 수평, 수직, 앞 뒤로 그룹화하여 사용한다.
