# UIView

최근 업무를 하다가 클래스가 제공하는 메소드와 프로퍼티들을 많이 알고있으면 좋겠다는 생각이 들었습니다.

따라서 오늘은 `UIView` 에 대하여 이 클래스가 제공하는 다양한 기능들에 대해 보다 자세히 살펴보고자 합니다.

<br>
<br>

## Definition & Declaration
---

애플의 공식문서에서는 `UIView` 클래스를 아래와 같이 정의하고 있습니다.

<img width="533" alt="image" src="https://user-images.githubusercontent.com/33051018/112745521-0985a100-8fe4-11eb-8888-0467f6a7fb50.png">

<br>
<br>

"스크린에 직사각형 형태로 보여지는 내용을 관리하는 객체" 라고 합니다.

<img width="546" alt="image" src="https://user-images.githubusercontent.com/33051018/112745503-e2c76a80-8fe3-11eb-9880-e4c0ee8ae3de.png">

그리고 이벤트 핸들링에 대한 인터페이스 `UIResponder` 클래스를 상속받고 있네요

이제 보다 상세한 설명을 살펴보겠습니다.

<br>

## Overview
---

`View` 들은 우리 앱 UI에 기저가 되는 빌딩 블록입니다. 이 빌딩 블록들이 모여서 하나의 페이지를 구성하고 그것이 모여서 우리의 앱이 됩니다.

또한 `UIView` 클래스는 모든 뷰가 공통적으로 가져야 할 동작들을 정의하고 있습니다.

뷰 객체는 내부의 직사각형 형태의 bound 내부에 내용을 렌더링하며 유저와의 상호작용을 핸들링 합니다.

또한 label, image, button 등과 같은 상세 내용들을 그려내기 위해 서브클래스들을 제공합니다.

View 객체는 유저와 앱이 상호작용하기 위한 핵심 통로입니다. View는 이를 위해 아래와 같이 다양한 역할들을 해내고 있습니다.

- Drawing and Animation
  - View는 UIKit, Core Graphics 등을 이용하여 Content 내용을 직사각형 형태로 그려냅니다.
  - 몇몇 View 프로퍼티들은 애니메이션을 통해 보다 새로운 가치를 만들어냅니다.

- Layout and Subview management
  - View는 0개 이상의 Subview들을 포함할 수 있습니다.
  - View는 자신의 Subview 들의 사이즈와 위치를 제어할 수 있습니다.

- Event Handling
  - View는 `UIResponder` 클래스의 하위 클래스입니다, 따라서 터치 혹은 다른 타입의 이벤트에 대하여 반응할 수 있습니다.
  - View는 Gesture Recognizer를 통하여 일반적인 Gesture 이벤트를 받아 핸들링 할 수 있습니다.

<br>

위에서 간단히 살펴본 바와 같이 `View`는 다른 View 내부에 포함되는 구조를 취할수 있습니다. 이는 서로 연관되어있는 내용들을 보여주기에 편리한 방법입니다.

각각의 View의 크기 혹은 위치를 설정할때는 `frame` 과 `bounds` 프로퍼티를 이용합니다.

두 프로퍼티 모두 `CGRect` 타입으로 origin 과 size를 갖습니다. 즉 x좌표, y좌표, width(너비), height(높이)를 가진다고 할 수 있습니다.

`frame` 프로퍼티는 **부모 뷰**의 좌표 시스템을 안에서 View의 위치와 사이즈를 정의합니다.

`bounds` 프로퍼티는 부모 뷰가 아닌 **자신만의** 좌표 시스템 안에서 위치와 사이즈를 정의합니다.

View를 생성하는 예시를 보며 보다 자세히 살펴볼께요!

<br>
<br>

### Creating a View
---

View 작업을 진행할때는 스토리보드를 이용하거나 코드를 이용하여 작업을 진행하죠.

일반적으로 View를 생성할때는 해당 View의 초기 위치와 사이즈를 정의합니다.

아래 예시는 부모 뷰의 상단 왼쪽 코너에서 (10, 10) 위치에 View를 생성하는 예시입니다.

<br>

```swift
let rect = CGRect(x: 10, y: 10, width: 100, height: 100)
let myView = UIView(frame: rect)
```

<br>

이렇게 생성한 View를 Subview로 추가하고자 할때 우리는 부모 뷰에 `addSubView(_:)` 메소드를 이용하여 자식 뷰로 추가합니다.

하나의 부모 뷰에 여러 자식 뷰가 추가된다면 상황에 따라 자식 뷰들이 겹쳐져 보일 수 있습니다.

이러한 경우 우리는 SubViews의 `z` 축에 대한 제어가 필요합니다. 이를 위해 `insertSubview(_:aboveSubView:)`, `insertSubview(_:belowSubview:)` 등과 같은 메소드가 제공되며 이미 추가되어진 View의 z축 위치 변경을 위해 `exchangeSubview(at:withSubviewAt:)` 와 같은 메소드도 제공됩니다.

<br>
<br>

### The View Drawing Cycle
---

뷰는 필요에 의하여 그려지게 됩니다. View가 처음으로 표시되거나 레이아웃에 대한 변경등이 발생하면 View 퍋ㅈ wkcpd


<br>
<br>

## Reference
---

- [developer.apple.com - UIView](https://developer.apple.com/documentation/uikit/uiview)