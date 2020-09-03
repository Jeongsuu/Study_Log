# Pass Data between View Controllers in swift

<br>

본 문서에는 View Controller 간 화면 전환시 데이터를 전달하는 방법에 대한 내용을 기재한다.

<br>

iOS 앱 개발에서 View Controller 간 데이터 전달은 매우 중요하다.

## Passing Data Between View Controllers with properties
---

첫번째는 프로퍼티를 이용한 데이터 전달방법이다.

프로퍼티란 클래스 내 변수로서 클래스의 모든 인스턴스가 해당 프로퍼티를 가지며 이에 값을 할당하고 사용할 수 있다.

`UIVIewController` 타입의 `View Controller`는 당연히 클래스의 인스턴스이므로 프로퍼티를 가질 수 있다.

```swift
class MainViewController: UIViewController {
    var text: String = ""       // Property

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

위와 같이 `text` 라는 스트링 프로퍼티를 갖는 `MainViewController`라는 클래스를 정의한다.

이후 해당 클래스의 인스턴스를 생성하여 `text` 프로퍼티에 값을 할당할 수 있다.

```swift
let vc = MainViewController()
vc.text = "Pass Data with property"
```

이렇게 해당 컨트롤러 클래스의 인스턴스를 생성하면 프로퍼티에 값을 할당할 수 있다.

만일, `NavigationController`를 사용하고 있다면 아래와 같이 값을 전달하면서 화면을 전환할 수 있다.

```swift

let vc = MainViewController()
vc.text = "Pass Data with property"
navigationController?.pushViewController(vc, animated: true)
```

<br>

## Passing Data Between View Controllers Using Segues(A->B)

이번엔 StoryBoard를 이용한 UI 구성시 `Segue`를 이용하여 데이터를 전달하는 방법이다.

Storyboard를 사용한다면 우리는 `prepare(for:sender:)` 함수를 통해 지정 세그 실행시 데이터를 준비하여 전달할 수 있다.

FirstViewController에서 SecondViewController로 데이터를 전달한다고 가정해보자.

```swift
class SecondViewController: UIViewController {
    var userName: String = ""
    @IBOutlet weak var usernameLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel?.text = userName
    }
}

이후 `FirstViewController` 에서 아래와 같이 코드를 작성해준다.

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
    if segue.destination == SecondViewController {
        let vc = segue.destination as? SecondViewController
        vc?.username = "Jungsu YEO"
    }
}
```

위와 같이 FirstViewController -> SecondViewController 로 화면을 전환하는 Segue 작동시 해당 Segue의 목적지 `destination`을 확인하고, 정상 분기의 경우 우리가 원하는 로직을 처리하도록 한다.

<br>

## Passing Data Back with Delegation
---

이번엔 `Delegate`를 이용하여 데이터를 전달하는 방법에 대해 알아본다.

`Delegation`은 iOS 앱 개발시 빈번히 사용되는 디자인 패턴이다. 

- 나는 피자 음식점에서 서빙 일을 하며 피자를 만드는 베이커가 있다고 가정한다.
- 고객은 피자로 무엇이든 할 수 있다.
- 제빵사는 피자 만드는 작업만 위임하고 있으며 그 외에 업무 프로세스는 전혀 신경쓰지 않는다.

원활한 업무를 위해 나와 피자 제빵사 간 프로토콜을 정의한다.

```swift
protocol PizzaDelegate {
    func onPizzaReady(type: String)
}
```

`protocol`을 정의하고 이제 해당 프로토콜을 준수하는 ViewController를 정의한다.

```swift
class MainViewController: UIViewController, PizzaDelegate {

    func onPizzaReady(type: String) {
        print("\(type) Pizza is baked")
    }
}

```

위와 같이 프로토콜을 준수하여 함수를 구현한다.

이후 데이터를 전달받을 두번쨰 뷰 컨트롤러를 만들면 해당 VC에서도 delegate connection을 추가해줘야 한다.

```swift
class SecondaryViewController: UIViewController {
    var delegate: PizzaDelegate?

    @IBAction func onButtonTapped() {
        delegate?.onPizzaReady(type: "Cheese Pizza")
    }
}
```

`onButtonTapped`를 피자 베이커가 피자 완성시 누르는 버튼이라고 하자.

해당 버튼이 터치되면 `delegate`가 `onPizzaReady`를 호출하게 되고 이것이 호출되면서 해당 `Delegate`를 채택하고 있는 클래스 내에서 해당 함수가 실행된다.

<br>

## Passing Data Between View Controllers With NotificationCenter
---

`NotificationCenter`를 이용해서도 VC 사이에 데이터를 주고 받을 수 있다.

`NotificationCenter`는 이름 그대로 Notification을 핸들링하는 클래스다.

Notification이 들어오면, 이를 관찰하고 있는 옵저버들에게 포워딩해준다.

`NotificationCenter` 에는 3개의 주요 컴포넌트가 있다.

- Notification Observing
- Notification Sending
- Respond to Notification

"Notification이 들어오면 들어온것을 알려달라!" 라는 요청을 하는것이 `Notification Observing` 이다.

Notification을 전달받기 위한 행동으로 모든 Notification은 각각을 식별하기 위한 Identifier를 갖는다.

```swift
static let notificationName = Notification.name("myNotification")
```

위와 같이 static 키워드를 통해 class의 프로퍼티를 생성하면 코드 어디서든 ViewController.notificationName으로 호출할 수 있다.

이후, `Observing`은 아래와 같이 진행한다.

```swift
NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: MainViewController.notificationName, object: nil)
```

위와 같이 `Add Observe` 로직은 주로 `viewDidLoad()` 혹은 `viewWillAppear()` 부분에 추가하여 VC의 화면이 보여지기 이전에 observation을 등록하기 위함이다.

위 코드는 default NotificationCenter에 Observer를 등록하는 것이다.
첫 번째 인자는, Observation을 진행할 인스턴스의 자리이다. 주로 `self`가 기입된다.
두 번째 인자는, Notification이 Observe 되었을 떄, 실행할 함수이다.
세 번째 인자는, notification을 식별하기 위한 notification 이름으로 주로 static constant 타입이다.

NotificationName 생성 -> NotificationCenter를 통한 addObserver 흐름이다.

`notification` 관측을 멈추기 위해서는 아래와 같이 진행한다.

```swift
// 지정 Notification 관측 해제
NotificationCenter.default.removeObserver(self, name: MainViewController.notificationName, object: Nil)

// 모든 Notification 관측 해제
NotificationCenter.default.removeObserver(self)
```

