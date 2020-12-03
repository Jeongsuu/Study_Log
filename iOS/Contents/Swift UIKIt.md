# Swift UIKit

<br>

본 문서에는 **UIKit** 에 대한 기본기를 공부하며 정리한 내용을 기재하였습니다.

<br>

## UIKit
---

**UIKit** 프레임워크는 iOS 앱의 UI 구성에 필요한 인프라를 제공합니다.

또한, 인터페이스 구현을 위한 window, view 아키텍처, 애플리케이션에 멀티 터치 및 기타 유형의 입력등을 제공하는 이벤트 처리 인프라, 사용자, 시스템 간 상호 작용을 관리하기 위한 기능을 제공합니다.

이외에도 프레임워크가 제공하는 다른 기능으로는 애니메이션, 문서, 그리기 및 인쇄, 현재 장치에 대한 정보, 텍스트 관리 및 디스플레이, 검색 지원, 접근성 지원, 앱 확장 지원 등의 관리가 있습니다.

**UIKit**이 무엇인지 알아보았으니 주로 이용되는 클래스들에 대하여 알아보도록 하겠습니다.

<br>

### UILabel
---

**UILabel** 은 한 줄 이상의 텍스트 정보를 UI로 표시하기 위해 사용되는 클래스입니다.

즉, 사용자에게 원하는 데이터를 표시하고 싶을때 사용합니다.

> 단, 사용자는 이를 수정할 수 없고 오직 볼 수만 있습니다.

<br>

#### 핵심 속성

`var text: String?`

Label에 표기할 텍스트를 의미합니다.

```swift
label.text = "텍스트 표기"    // Label에 표시될 텍스트 값을 "텍스트 표기"로 변경
```

<br>

`var font: UIFont!`

Label text 프로퍼티의 폰트를 담당합니다.

```swift
label.font = UIFont.systemFont(ofSize: 20)  // Label의 폰트를 systemFont로 지정하며 크기를 20으로 변경합니다.
label.font = UIFont(name: "CustomFont", size 20)    // Label의 폰트를 CustomFont로 지정하며 크기를 20으로 변경합니다.
```

해당 프로퍼티의 기본값은 `systemFont(ofSize: 17)` 입니다.

<br>

`var textColor: UIColor!`

Label의 text 프로퍼티의 색상을 담당합니다.

```swift
label.textColor = UIColor.blue // text 색상을 "blue"로 변경
```

<br>

`var textAlignment: NSTextAlignment`

Label text 프로퍼티에 대한 정렬 기준을 담당합니다.

```swift
label.textAlignment = NSTextAlignment.left  // text 정렬 기준을 왼쪽 정렬로 지정합니다.
label.textAlignment = .center   // text 정렬 기준을 가운데 정렬로 지정합니다.
label.textAlignment = .right    // text 정렬 기준을 오른쪽 정렬로 지정합니다.
```

<br>

`var numberOfLines: Int`

Label에 표시할 text의 최대 행의 수를 지정합니다.

기본 값은 1이며, 제한없이 행을 늘릴 수 있습니다.

```swift
label.numberOfLines = 90    // 최대 행의 수를 90줄로 제한합니다.
```

<br>

### UITextField
---

![image](https://user-images.githubusercontent.com/33051018/100983375-936cb280-358c-11eb-80c6-5292c3db4230.png)


`UITextField` 또한 텍스트를 표시한다는 점에서는 앞서 살펴본 `UILabel` 과 매우 유사한 클래스입니다.

>다만, **editable** 한 속성을 갖기 때문에 사용자가 직접 내부 text에 대한 변경이 가능해집니다.

<br>

#### 핵심 속성

`var text: String?`

TextFiled 에 디스플레이 될 text를 담당합니다.

```swift
textField.text = "제 이름은 여정수입니다"   // textField의 text 기본값을 "제 이름은 여정수입니다" 로 변경합니다.
```

<br>

`var placeholder: String?`

TextFiled 내에 어떠한 text도 없을 떄 임시로 보여줄 text를 담당합니다.

```swift
emailTextField.placeholder = "e.g. duwjdtn1@gmail.com"  // textField의 임시값을 "e.g. duwjdtn1@gmail.com" 으로 변경합니다.
```

<br>

`var font: UIFont?`

TextFiled 내 text에 대한 폰트를 담당합니다.

```swift
textField.font = UIFont.systemFont(ofSize: 20)  // textField 내 text의 폰트를 systemFont로 지정하며 크기를 20으로 변경합니다.
```

<br>

`var textColor: UIColor?`

TextField 내 text에 대한 색상을 담당합니다.

```swift
textField.textColor = UIColor.blue  // textField 내 text의 색상을 blue 색상으로 변경합니다.
```

<br>

`var keyboardAppearance: UIKeyboardAppearance`

TextField 터치시 올라오는 키보드 유형을 담당합니다.

```swift
textField.keyboardType = .numberPad // 키보드 유형을 숫자패드로 변경합니다.
textField.keyboardType = .emailAddress  // 키보드 유형을 이메일 주소 타입으로 변경합니다.
```

**keyboardType 종류**
> - Default: 기본
> - AsciiCapable: 문자 입력
> - URL: URL 입력
> - EmailAddress: 이메일 입력
> - NumberPad: 숫자 입력
> - PhonePad: 전화번호 입력
> - etc...

<br>

`var returnKeyType: UIReturnKeyType`

TextField의 반환 키를 담당합니다.

```swift
textField.returnKeyType = .Done // 리턴 키를 "Done" 으로 변경합니다.
textField.returnKeyType = .Search   // 리턴 키를 "Search" 로 변경합니다.
```

<br>

### UIButton
---

앱 제작시 필수적으로 사용되는 버튼이며 사용자의 터치시 특정 코드를 실행할 수 있도록 제어 기능을 제공합니다.

<br>

#### 핵심 속성 및 함수

`UIControlState`

버튼의 상태를 담당합니다.

> - UIControl.State.normal: 기본 상태
> - UIControl.State.highlighted: 버튼이 터치되고 있는 상태
> - UIControl.State.selected: 버튼이 선택되었을 때
> - UIControl.State.disabled: 버튼을 사용하지 않을 때

<br>

`func setTitle(_ title: String?, for state: UIControl.State)`

버튼 상태에 따라서 버튼의 title을 변경합니다.

```swift
button.setTitle("normal state", for: .normal)   // normal 상태의 버튼 title을 "normal state"로 지정합니다.
button.setTitle("selected state", for: .selected)   // selected 사앹의 버튼 title을 "selected state"로 지정합니다.
```

<br>

`func setTitleColor(_ color: UIColor?, for state: UIControl.State)`

버튼 상태에 따라서 버튼의 title 색상을 변경합니다.

```swift
button.setTitleColor(UIColor.red, for: .normal) // normal 상태의 버튼 title 색상을 red 색상으로 지정합니다.
button.setTitleColor(UIColor.blue, for: .selected)  // selected 상태의 버튼 title 색상을 blue 색상으로 지정합니다.
```

<br>

`var isEnabled: Bool`

버튼의 활성 상태를 담당합니다.

```swift
if validCheck() {
    self.loginButton.isEnabled = true   // validCheck 메소드의 반환값이 true인 경우 loginButton를 활성화합니다.
} else {
    self.loginButton.isEnabled = false  // validCheck 메소드의 반환값이 false인 경우 loginButton를 비활성화합니다.
}
```



<br>
<br>

## Reference
---

[UIKit framework](https://developer.apple.com/documentation/uikit)