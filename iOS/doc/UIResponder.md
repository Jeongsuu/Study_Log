# UIResponder

본 문서에는 애플 개발자 홈페이지의 `UIResponder` 공식 문서를 번역한 내용을 작성한다.

<br>

## UIResponder란?
---

![image](https://user-images.githubusercontent.com/33051018/83160965-cd26b180-a142-11ea-8e67-ab6ee4958f64.png)

`UIResponder` 클래스는 이벤트에 대한 응답 등과 같은 처리를 위한 추상 인터페이스를 의미한다.

```swift
class UIResponder: NSObject
```

`UIResponder` 클래스는 `NSObject` 클래스를 상속한다.

<br>

## Overview
---

`Responder` 객체는 `UIResponse`의 인스턴스이며 `UIKit app`의 이벤트 핸들링의 백본(Backbone)을 구성한다.

많은 핵심 객체들 (ex: UIApplication 객체, UIViewController 객체 ...etc)는 모두 `Responder`다.

**이벤트가 발생하면 `UIKit`은 이를 처리하기 위해 `Responder` 에게 이를 전달한다.**

여기서 말하는 이벤트란 사용자의 화면 터치, 모션 기능, 원격 제어 등 모든것을 포함한다.

특정 이벤트를 핸들링 하기 위해서 `responder`는 해당 메소드를 `override` 해야한다.

간단한 예시를 살펴보자.

예를 들어 터치 이벤트를 핸들링 하기 위해서는 `responder`는 해당 메소드인 `touchesBegan(_:with:), touchesMoved(_:with:), touchesEnded(_:with:), touchesCancelled(_:with:)` 과 같은 메소드를 구현해야한다.

터치 이벤트의 경우에는 `UIKit`에서 제공하는 이벤트 정보를 활용하여 해당 터치 이벤트의 변경 사항을 추적하고 앱의 인터페이스를 이벤트에 따라서 적절히 처리해야 한다.

`UIKit Responder`는 또한 처리되지 않은 이벤트들을 앱의 다른 부분으로 전달하는 역할도 한다.

**만일 특정 `responder`가 이벤트를 핸들링 하지 않을 경우, 해당 이벤트를 `Responder Chaining`을 통해 다음 이벤트로 전달한다.**

`UIKit`은 사전 정의된 규칙에 따라 이벤트를 수신 할 다음 객체를 결정하는 `Responder Chaining`을 동적으로 관리한다.

예를 들어, `view`는 `superview`로 이벤트를 전달하고, `rootview`는 해당 뷰 컨트롤러로 이벤트를 전달한다.

<br>

## Topics
---

### Responder Chain

```swift
var next: UIResponder?
// Responder Chaining을 이용해 다음 Responder를 전달한다.

var isFirstResponder: Bool
// 현재 객체가 FirstResponder 가 맞는지에 대한 불린 값을 반환한다.

var canBecomeFirstResponder: Bool
// 현재 객체가 FirstrResponder 가 될 수 있는지에 대한 여부를 불린 값으로 반환한다.

func becomeFirstResponder() -> Bool
// UIKit에게 현재 객체가 Window에서 FirstResponder가 될 수 있도록 요청한다.

var canResignFirstResponder: Bool
// 리시버가 FirstResponder 상태를 포기할지를 나타내는 불린 값을 반환한다.

func resignFirstResponder() -> Bool
// 현재 객체가 Window에서 FirstResponder를 포기할지 요청되었음을 알린다.

```

위 메서드들이 `Responder`의 체인을 관리해주는 메서드들이다.

### Responding to Events

```swift
func touchesBegan(Set<UITouch>, with: UIEvent?)
// 뷰 또는 윈도우에서 터치가 발생했음을 responder에게 알린다.

func touchesEnded(Set<UITouch>, with: UIEvent?)
// 뷰 또는 윈도우에서 손가락이 떨어졌을때 이를 responder에게 알린다.

func motionBegan(UIEvent.EventSubtype, with: UIEvent?)
// 모션이 발생했음을 receiver에게 알린다.

func motionEnded(UIEvent.EventSubtype, with: UIEvent?)
// 모션이 끝났음을 receiver에게 알린다.
```

### Type Properties

```swift

class let keyboardDidHideNotification: NSNotification.Name
// 키보드가 dismiss 된 직후 게시한다.

class let keyboardDidShowNotification: NSNotification.Name
// 키보드가 present 된 직후 게시한다.

class let keyboardWillHideNotification: NSNotification.Name
// 키보드가 dismiss 되기 이전에 게시한다.

class let keyboardWillShowNotification: NSNotification.Name
// 키보드가 present 되기 이전에 게시한다.
```



## Reference
- [UIResponder official doc](https://developer.apple.com/documentation/uikit/uiresponder)