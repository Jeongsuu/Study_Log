# setNeedsLayout & layoutIfNeeded

<br>

여태 portrait <-> landscape 등 디바이스의 Orientation을 변경하는 등 제약조건에 따른 UI 업데이트를 위해 막연하게만 사용했던 두 메소드에 대하여 한번 알아보도록 하겠습니다.

<br>


`View`의 생명 주기중 `view layout`을 업데이트는 `layoutSubViews()`가 담당합니다.

iOS에서는 앱이 실행되면 메인 스레드에서 `Main run loop` 가 실행되면서  update 사이클을 통해 이벤트들을 처리하게 됩니다.

![image](https://user-images.githubusercontent.com/33051018/96554182-28735f00-12f1-11eb-90d1-7a0cd1bc036b.png)

<br>

### Update Cycle
---

<br>

`Update Cycle`은 애플리케이션이 유저로부터 받은 이벤트들에 대한 핸들링을 진행한 이후 다시 `main run loop`로 권한 및 컨트롤을 반환하는 지점입니다.

해당 지점에서 우리의 앱은 **View에 대한 제약조건을 설정하고(constraints), 배치(layout)하고, 보여주는 (display) 등 일련의 프로세스를 진행하게 됩니다.**

위와 같은 업데이트 프로세스는 매우 빠르게 진행되기 때문에 사용자는 이를 직접적으로 느끼지는 못합니다, 그러나 **이벤트가 처리되는 시점**과 **View가 업데이트되어 다시 그려지는 시점**에는 분명히 **시간 차이**가 존재하기 때문에 View는 우리가 View를 업데이트 하기 원하는 run loop의 특정 시점에 업데이트가 되지 않는 경우도 있습니다.

<br>

### layoutSubviews()
---
<br>

우리는 실행 즉시 즉각 반영시키기 위해 `setNeedsLayout()` 혹은 `layoutIfNeeded()` 메소드를 호출해왔습니다.

두 메소드를 호출하면 view가 갱신되는 이유는 무엇일까요?

**그 이유는 두 메소드가 호출되면 공통적으로 내부에서 view를 갱신하는 `layoutSubviews()` 메소드를 호출하기 때문입니다.**

`UIView` 클래스의 인스턴스 메소드 `layoutSubviews()` 는 현재의 view와 현재 view의 subview들의 위치와 사이즈를 **재계산**하여 배치합니다.

즉, 현재 view의 모든 자식 뷰의 `layoutSubviews()` 메소드를 재귀적을 호출하게 됩니다.

비용이 매우 많이 드는 메소드이며 실제 `layoutSubviews()` 메소드를 직접 호출하는 것은 금지되어 있습니다. 이는 시스템에 의하여 View의 값이 재계산되어야 하는 시점(Update Cycle)에 자동으로 호출됩니다.

`layoutSubviews()`의 실행이 완료되면 콜백으로 `viewDidLayoutSubviews` 가 해당 View를 소유한 ViewController에서 호출됩니다.

**그렇기에 우리는 레이아웃의 크기나 위치와 연관된 로직을 `viewDidLoad()` 혹은 `viewDidAppear()` 가 아닌, `viewDidLayoutSubViews()`에서 호출해주는 것 입니다.**

위와 같이 `layoutSubviews()` 메소드를 적절한 update cycle에서 호출시키기 위한 상황들이 몇 가지 존재합니다.

아래 상황에서는 시스템이 자동으로 'layout을 다시 그려야 하는 View라고 체크를 하고 update cycle에서 해당 뷰를 재계산 하겠다' 하여 변경된 값을 반영합니다.

- View의 크기를 조절할 때
- SubView를 추가할 때
- 사용자가 `UIScrollView`를 스크롤할 때, 스크롤 뷰와 부모뷰에 `layoutSubviews`가 호출
- Device의 orientation이 변경될 때
- View의 Constraint가 변경될 때

위에 나열된 상황에서는 update cycle에서 자동적으로 `layoutSubviews()`를 호출하도록 예약합니다.

하지만, 이를 실행시키도록 유도하는 방법들이 존재하죠.

그것이 바로 `setNeedsLayout()` 과 `layoutIfNeeded()` 입니다.

그럼 이제 본격적으로 두 메소드에 대하여 알아보도록 하겠습니다.

<br>

## setNeedsLayout
---

<br>

`layoutSubViews()` 를 유도하기 위한 가장 경제적(?)인 방법입니다.

비용이 제일 적게 드는 방법으로 `setNeedslayout()`을 호출하게 되면 이 메소드를 호출한 view는 **"재계산 되어야 하는 View"**  라고 체크가 되며 update Cycle에서 해당 View의 `layoutSubviews()`가 호출되게 됩니다.

이 메소드는 비동기(async)적으로 작동하기 때문에 호출이 된 이후 바로 반환하게 되며, View의 재계산은 update Cycle이 실행될 때 변경되게 됩니다.

<br>

## layoutIfNeeded
---

<br>


`layoutIfNeeded()`는 `setNeedsLayout`과 같이 수동적으로 `layoutSubViews()` 를 예약하는 메소드지만 동기적으로 실행됩니다.

따라서, 해당 메소드 호출 후 update cycle이 올 때 까지 기다린 뒤 `layoutSubviews()` 를 호출하는 것이 아니라 해당 메소드 호출 즉시 `layoutSubviews()` 를 호출하게 됩니다.

호출과 동시에 그 즉시 view가 재계산되는 `layoutIfNeeded()`는 특히 애니메이션과 같은 상황에서 유용하게 사용됩니다.

만일 이를 비동기적으로 처리하는 `setNeedsLayout()`을 이용하여 구현하게 된다면, 그 즉시 view에 애니메이션 효과가 발생하지는 않고 추후 update Cycle에서 값이 반영되므로 예상했던 애니메이션 효과는 볼 수 없을 것 입니다.


정리하겠습니다.

`setNeedsLayout()` 과 `layoutIfNeeded()`는 둘 다 수동적으로 View를 재계산하여 그려주는 `layoutSubviews()`를 예약하는 메소드라는 공통점을 가지며 `setNeedsLayout()`은 비동기적으로 작동하고 `layoutIfNeeded()`는 동기적으로 작동한다는 차이점이 있습니다.

<br>
<br>

## Summary
---
<br>

- `layoutSubviews()` 는 현재의 view와 현재 view의 subview들의 위치와 사이즈를 **재계산**하여 배치합니다.
    - 현재 뷰를 비롯한 모든 자식 뷰의 `layoutSubViews()`를 재귀적으로 호출하기에 비용이 많이 드는 메소드이며 직접 호출이 불가합니다.
    - 해당 메소드가 예약되면 main run loop를 순환하다가 다음 update Cycle에 진입했을 때 해당 뷰를 재계산하여 다시 그립니다.

- `layoutSubviews()` 를 수동적으로 예약하는 방법은 크게 두 가지로 나뉘어 집니다.
  - `setNeedsLayout()` : 비동기적으로 작동합니다, -> 다음 update Cycle에서는 이 뷰를 업데이트 합니다.
  - `layoutIfNeeded()` : 동기적으로 작동합니다. -> 지금 당장 `layoutSubViews`를 호출합니다.