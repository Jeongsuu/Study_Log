# UIPickerView
---

**cf) [UISlider](https://developer.apple.com/documentation/uikit/uislider)**

# INDEX

[1. Declaration](#Declaration)<br>
[2. Overview](#Overview)<br>
[3. Responding to User Interaction](#Responding-to-User-Interaction)<br>
[4. Interface Builder Attributes](#Interface-Builder-Attributes)<br>
[5. Topics](#Topics)<br>

<br>
`UISlider` 클래스는 범위 내 연속되는 범위 내에서 단일 값을 선택하는데 사용되는 제어기능을 제공한다.
<br><br>

### Declaration
---

```swift
class UISlider: UIControl
```
<br><br>

### Overview
---

![image](https://user-images.githubusercontent.com/33051018/79690080-9338d480-8293-11ea-9633-28d68514ba92.png)
(그림 참고)

슬라이더의 `thumb`을 이동시키면 업데이트 된 값이 연결된 동작에 자동으로 전달된다.

슬라이더의 외형 구성을 보면 알 수 있듯, 슬라이더의 모양은 사용자가 커스텀 할 수 있다.

track과 thumb에 색상을 넣을수도 있고, 슬라이더의 끝 부분에 이미지를 넣을수도 있다.

프로그래밍 방식 또는 `Interface Builder`를 이용하여 인터페이스에 슬라이더를 추가할 수 있다.

인터페이스에 슬라이더를 추가하는 단계는 아래와 같다.

-   슬라이더가 나타내는 값의 범위를 지정한다.
-   부가적으로 슬라이더의 색상을 변경하거나 이미지를 넣을 수 있다.
-   슬라이더에 `action`을 연결한다.

<br><br>

### Responding to User Interaction
---
슬라이더는 사용자가 슬라이더 값을 변경시키면 일반적으로 `Target-Action` 패턴을 이용해 앱에게 이를 알린다.

슬라이더의 값이 변경되는 것을 알릴때는 `valueChanged` 메소드를 통해 이를 알릴 수 있다.

기본적으로 슬라이더는 사용자가 슬라이더의 `thumb` 위치가 변경하면 계속하여 `valueChanged` 메소드를 호출한다.

만일 `isContinuous` 프로퍼티를 `false`로 설정하면 슬라이더의 `thumb` 이 이동을 끝낼때만 슬라이더가 이벤트를 보내 최종값을 설정한다.

`addTarget(_:action:for:)` 메소드를 통해 슬라이더에 사용자의 액션을 연결하거나 인터페이스 빌더를 통해 `connection`을 연결할 수 있다.

슬라이더의 액션 관련 메소드는 아래와 같다.
```swift
@IBAction func doSomething()
@IBAction func doSomething(sender: UISlider)
@IBAction func doSomething(sender: UISlider, forEvent event: UIEvent)
```

상황에 따라 적절한 포맷의 메소드를 사용하여 `connection`한다.

<br><br>

### Interface Builder Attributes
---

`slider`의 핵심 속성들에 대해 알아보자.

- `Value Minimum/Maximum` : 슬라이더의 `entry-point` 와 `end-point` 를 `minimumValue` & `maximumValue` 프로퍼티를 통해 지정할 수 있다.
-   `value Current` : 이름 그대로 슬라이더 `thumb`의 현재 값을 알아올 수 있는 프로퍼티다. 이는 반드시 `minimumValue` ~ `maximuMValue` 범위 내의 값으로 설정해야한다.
-   `minimumValueImage` : 속성명 그대로 최소값에 이미지를 보여줄 떄 이용하는 프로퍼티다.
-   `maximumValueImage` : 속성명 그대로 최대값에 이미지를 보여줄 때 이용하는 프로퍼티다.
-   `MinTrackTint` : 슬라이더의 `thumb`의 앞쪽 트랙의 색상을 지정할 떄 이용하는 프로퍼티다.
-   `MaxTrackTint` : 슬라이더의 `thumb`의 뒤쪽 트랙의 색상을 지정할 때 이용하는 프로퍼티다.
-   `ThumbTint` : 슬라이더 `thumb`의 색상을 지정할 때 이용하는 프로퍼티다.

<br><br>

### Topics
---

#### Accessing the Slider's Value

```swift
var value: Float
// 슬라이더의 현재 값을 의미한다.

func setValue(Float, animated: Bool)
// 슬라이더의 값을 지정할 때 사용하는 메소드이며 애니메이션 기능을 제공한다.
```

#### Accessing the Slider's Value Limits

```swift
var minimumValue: Float
// 슬라이더의 최저값을 지정한다.

var maximumValue: Float
// 슬라이더의 최대값을 지정한다.
```

#### Modifying the Slider's Behavior

```swift
var isContinuous: Bool
// 슬라이더 값의 변경에 따른 지속적 업데이트 이벤트 생성 여부를 지정한다.
```

#### Changing the Slider's Appearance

```swift
var minimumValueImage: UIImage?
// 슬라이더의 최저값에 이미지를 지정할 때 사용한다.

var maximumValueImage: UIImage?
// 슬라이더의 최대값에 이미지를 지정할 때 사용한다.

var minimumTrackTintColor: UIColor?
// 최저값 트랙의 색상을 지정할 때 사용한다.

var thumbTintColor: UIColor?
// thumb의 색상을 지정할 때 사용한다.
```

<br><br>

