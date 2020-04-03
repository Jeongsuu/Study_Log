## delegate 

---

---

`swift` 를 공부하면서 꼭 알아야 하는 개념중 하나가 `delegate`

`delegate`를 알려면 우선 프로토콜을 알아야 한다.

프로토콜이란 서로간의 규약 및 약속이라고 생각하면 된다.

예를들어, 선생님이라는 프로토콜이 있다고 생각해보자.

선생님 프로토콜에는

> 과목명
담당 클래스
가르치다()
숙제를 주다()

등등 여러가지가 있을것이다.

이러한 약속을 지키는 과학 선생님, 영어 선생님이 있다고 해보자.

이 과학선생님과 영어선생님은 '선생님'이라는 일종의 명찰을 가지고 있으므로 선생님 프로토콜을 준수해야 한다.

왜 프로토콜 상에서 가르치다(), 숙제를 주다() 등 함수의 행동을 정의하만하고 구현은 하지 않았을까?

**그 구현은 각각의 '선생님' 이라는 프로토콜을 채택한 곳에서 이루어진다.**

애플측에서 모든 경우의 수를 생각해 구현하기 힘들기 때문이다.

프로그래머는 함수 프로토타입만 가지고 와서 약속을 준수하며 자신만의 원하는 방향으로 구현만 하면 된다.

이것 하나만 기억하자.

프로토콜은 서로간의 지켜야할 규약 및 약속이다.

자 그럼 이제 `delegate`에 대해 알아보자.

`delegate` 의 사전적 의미는 아래와 같다.

1. (집단의 의사를 대표하는) 대표(자)
2. (권한 및 업무 등을) 위임하다.
3. (대표를) 뽑다

`delegate` 는 대리자, 위임자 등의 뜻으로 이해하면 된다.

**너가 해야할 일을 내가 해서 줄게!  이런 느낌?**

스위프트에서 기존의 버튼이나 텍스트 필드, 라벨 등 객체들은 고유한 특징을 갖는다.

버튼을 누르면 `@IBAction` 을 통해 동작하는 기능.

텍스트 필드는 글자를 입력할 수 있도록 해주는 기능

라벨은 글자 내용을 출력해주는 기능 등..

`delegate` 패턴은 쉽게 말해서, 객체 지향 프로그램에서 하나의 객체가 모든 일을 처리하는 것이 아니라 처리해야 할 일 중 일부를 다른 객체에게 넘기는 것을 의미한다.

메인 스토리보드에 아래와 같이 컴포넌트를 준비한다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2728e83b-6373-4549-a484-aef25f0730c3/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2728e83b-6373-4549-a484-aef25f0730c3/Untitled.png)

버튼에 대한 액션을 줘야하니 `@IBAction` 함수를 만들어준다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3d03a954-bdd3-4061-ae27-6304438e78b9/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3d03a954-bdd3-4061-ae27-6304438e78b9/Untitled.png)

내용은 "내가 이 버튼을 누르면 텍스트필드 내부 텍스트 값을 라벨에 옮겨줘요" 라는 뜻이다.

그리고 버튼을 클릭하면 라벨이 텍스트 필드에 있던 값으로 변경된다.

이제 `delegate` 를 써보자!

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a29c8548-65ab-4176-a300-86710e8564c3/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a29c8548-65ab-4176-a300-86710e8564c3/Untitled.png)

`ViewController` 클래스가 `UITextFieldDelegate` 포로토콜을 채택하도록 한다.

두번째로 딜리게이트 즉, 위임을 누가 할 지 정해줘야한다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bac24fa7-0ce0-4507-9f46-dab54756d5d6/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bac24fa7-0ce0-4507-9f46-dab54756d5d6/Untitled.png)

    textField.delegate = self

여기서 `self` 는 `ViewController` 의 인스턴스가 되겠쥬?

이는 위임자(대리자)가 누구인지 알려주는 과정이라고 생각하면 된다.

"`textField` 의 뒷바라지는 내가 할게!"라는 의미다.

즉, "나(뷰 컨트롤러), 내가 텍스트필드의 뒷바라지를 할게!" 이 말이다!

이건 iOS 내에서 이렇게 해석된다.

텍스트필드야! 너한테 이벤트가 발생하면 프로토콜에 따라서 너한테 응답을 줄게!

그럼 정리를 해봅시다!

1.  `delegate` 프로토콜 채택
2. 위임자(뒷바라지) 선정

자 이제 구현만 하면 된다!

`@IBAction` 을 통해 텍스트 값을 옮겨주는 기능을 대신해주는 함수를 선언한다!

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    	enteredLabe.text = textField.text
    	return true
    }

자 함수를 살펴보자!

`textFieldShouldReturn` 함수는 `UITextFieldDelegate` 프로토콜 내에 정의되어 있는 함수이다.

따라서, 우리는 해당 프로토콜을 채택했으니 이 동작을 '대신' 해 줄 함수를 불러와 그 함수안에 우리가 하고싶은 일을 '구현'만 하면 된다!

함수 이름을 보면 대충 어떤 기능을 할 지 느낌이 온다.

'텍스트필드에서 사용자가 어떠한 일을 하고 리턴될거다.' 라는 의미가 느껴진다.

그러니 아까 적었던 텍스트 필드 내용을 라벨에 옮겨적는 코드를 추가해준다.

그러면 리턴될 때 이 함수는 자동으로 불러오게 된다!

@IBAction : Event가 일어난 경우 호출되는 Action을 정의
@IBOutlet : 값에 접근하기 위한 변수

---

---

---

## delelgate 정리 2 - pickerView Delegate

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/df957f60-9431-4f94-bc1d-e5cf995d8ac8/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/df957f60-9431-4f94-bc1d-e5cf995d8ac8/Untitled.png)

`pickerView` 사용을 위해 `@IBOutlet` 변수를 하나 만든다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f1602138-226e-496a-8651-ebbacf45fa5d/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f1602138-226e-496a-8651-ebbacf45fa5d/Untitled.png)

PickerView에 대한 액션을 만드려고 IBAction 함수를 만드려고 했으나 action이 없다.

그럼 어떻게 내가 원하는 데이터를 넣고 내가 하고싶은 기능들을 제어하지? 라고 생각이 든다.

그럴때를 대비하여 바로 `UIPickerViewDelegate`가 있다.

`Delegate` 라고 쓰여있으니 이 프로토콜은 대충 느낌이 온다! 

"나는 UIPickerView에 대한 프로토콜이야! 내 안에 너가 PickerView 를 가지고 할 수 있는 기능들이 함수로 정의되어 있으니 니가 가져가서 구현해!"

PickerView를 사용하기 위해서는 `UIPickerViewDelegate` 말고도 `UIPickerViewDataSource` 라는 프로토콜이 하나 더 필요하다.

이 둘은 쌍으로 같이 다닌다고 생각하면 된다!

이전에 테이블 뷰에서도 딜리게이트와 데이터소스를 함께 사용했던 기억이 있다!

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d7ba5a85-ca2a-45e5-8552-388be5aa3e03/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d7ba5a85-ca2a-45e5-8552-388be5aa3e03/Untitled.png)

1. `UIPickerViewController, UIPickerViewDataSource` 프로토콜을 채택한다!
2. 대리자(위임자) 위임.
3. 구현!

이제 구현만 하면되는데 갑자기 뭔 애러가 뜬다.

`Type 'ViewController' does not conform to protocol 'UITableViewDataSource'`

ViewController가 `UITableVieweDataSource` 프로토콜을 준수하지 않고 있다네요..?

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5304a2fb-4fe2-49c2-8226-d06027ec7383/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5304a2fb-4fe2-49c2-8226-d06027ec7383/Untitled.png)

`UIPickerViewDataSource` 프로토콜 내부를 살펴보면 위와 같이 함수가 두개 선언되어있다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/cc14a6fc-b438-4167-93af-dd3437f26b09/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/cc14a6fc-b438-4167-93af-dd3437f26b09/Untitled.png)

`UIPickerViewDelegate` 도 함수들이 선언되어 있으나 모두 옵셔널이다.

결론부터 이야기하자면, `optional` 이 붙지 않은 함수들은 무조건 채택과 동시에 `swift` 파일 안에 선언을 해줘야 한다.

**에러가 발생한 이유는 꼭 선언 해주어야 하는 함수들을 선언하지 않아서 그렇다!**

다시 `ViewController.swift` 파일로 돌아가 

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    	return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    	return Array.count
    }

를 추가해준다. 그럼 에러가 사라진다.

 

채택한 프로토콜 내 선언 되어진 함수 중 `optional` 이 붙지 않은 함수는 필수로 `swift` 파일에  구현해야한다.

---

---

---

### Delelgation

델리게이션에 대해 자세히 살펴보기 전에, Delegation의 사전적 의미를 알아두자.

Delegate : 대표(자), 사절, 위임, 대리(자)
위임하다, (대표를) 선정하다

### 델리게이션 디자인 패턴(Delegation Design Pattern)

---

Delegation 이라는 단어에서 예측할 수 있듯이, 

델리게이션은 하나의 객체가 다른 객체를 대신해 동작 또는 조정할 수 있는 기능을 제공한다.

- 델리게이션 디자인 패턴은 Foundation, UIKit, AppleKit 그리고 Cocoa Touch등 애플의 프레임워크에서 광범위하게 활용하고 있다.
- 주로 프레임워크 객체가 위임을 요청하며, 컨트롤러 객체가 위임을 받아 특정 이벤트에 대한 기능을 구현한다.
- 예시로 `UITextFieldDelegate` 를 살펴본다.

    // 대리자에게 특정 텍스트 필드의 문구를 편집하도록 도와주는 메서드
    func textFieldShouldBeginEditing(UITextField)
    
    // 대리자에게 특정 텍스트 필드의 문구가 편집되고 있음을 알리는 메서드
    func textFieldDidBeginEditing(UITextField)
    
    // 특정 텍스트 필드의 문구를 삭제하려고 할 때 대리자를 호출하는 메서드
    func textFieldShouldClear(UITextField)
    
    // 특정 텍스트 필드의 `Return` 키가 눌렸을 때 대리자를 호출하는 메서드
    func textFieldShouldReturn(UITextField)

위 메서드에서 알 수 있듯이, 델리게이트는 특정 상황에 대리자에게 메시지를 전달하고 그에 대한 적절한 응답을 받기 위한 목적으로 사용된다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1d4ee3f6-1ea1-4bb4-8bbd-83066f0a2d30/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1d4ee3f6-1ea1-4bb4-8bbd-83066f0a2d30/Untitled.png)

### 데이터소스(DataSource)

---

- 델리게이트와 매우 비슷한 역할을 하는 데이터소스가 있다.
- 델리게이트가 사용자 인터페이스 제어에 관련된 권한을 위임받고, 데이터소스는 데이터를 제어하는 기능을 위임받았다.
인터페이스 제어 : 델리게이트 , 데이터 제어 : 데이터소스

### 프로토콜(Protocol)

---

- 코코아터치에서 프로토콜을 사용해 델리게이션과 데이터소스를 구현할 수 있다.
- 객체간 소통을 위한 통신 규약으로 데이터나 메세지를 전달할 때 사용한다.
- 프로토콜은 특별한 상황에 대한 역할을 정의하고 제시하지만, 세부 기능은 미리 구현해두지 않는다.

델리게이션은 애플의 프레임워크에서 매우 많이 활용되고 있다. 델리게이션 패턴은 꼭 이해하고 넘어가야할 부분이다.

---

---

이전에 작성했던 뮤직 플레이어 앱을 다시본다.

보면 `ViewController.swift` 파일에 아래와 같은 코드가 존재한다.

    do {
    	try self.player = AVAudioPlayer(data: soundAsset.data)
    	self.player.delegate = self
    } catch let error as NSError {
    	print("플레이어 초기화 실패")
    	print("코드 : \(error.code)}
    }
    
    self.progressSlider.maximumvalue = Float(self.player.duration)
    self.progressSlider.minimumValue = 0
    self.progressSlider.value = Float(self.player.currentTime)
    
    // 

    	self.player.delegate = self

해당 코드의 의미는 이 뷰 컨트롤러의 인스턴스가 AVAudioPlayer의 델리게이트로 역할을 수행하겠다는 의미이다.

→ 이 AudioPlayer는 이 뷰 컨트롤러가 나의 델리게이트(대리자)구나!

오류 처리는 try 와 do-catch 문으로 진행한다.
