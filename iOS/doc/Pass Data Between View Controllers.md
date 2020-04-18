# Pass Data Between View Controllers
---

# INDEX
[1. Outline](#Outline)<br>
[2. Passing Data Between View Controllers With Properties(A -> B)](#Passing-Data-Between-View-Controllers-With-Properties)<br>
[3. Passing Data Between View Controllers Using Segues (A → B)](#Passing-Data-Between-View-Controllers-Using-Segues)

<br>
<br>


### Outline
---

여러개의 화면을 갖는 앱을 만들고 싶다면, 뷰 컨트롤러 간의 데이터 전달은 정말 필요한 기능이다.

**뷰 컨트롤러 간 데이터 전달** 기능은 `iOS` 개발에서 매우 중요한 부분이다.

이는 여러가지 방법을 통해 구현할 수 있으며, 각각의 장단점이 있다.

뷰 컨트롤러 간 데이터를 쉽게 전달하는 기능은 채택한 앱 아키텍처의 영향을 받는다.

**즉, 앱 아키텍처는 뷰 컨트롤러 작업 방식에 영향을 미치며 반대도 마찬가지다.**

이번 문서에서는 뷰 컨트롤러 간 데이터 전달방법을 위한 6개 중 2개 방법을 우선적으로 알아보도록 한다.

여기에는 `Property, NSNotificationCenter, segue` 등을 포함하며 쉬운 방법부터 순차적으로 살펴보도록 한다.

<br>
<br>

### Passing Data Between View Controllers With Properties
---

뷰 컨트롤러 간 데이터 전달방법은 대략 6가지가 있다.

1. 인스턴스 프로퍼티 이용
2. `segue` 이용
3. 인스턴스 프로퍼티와 함수 이용
4. `Delegation` 패턴 이용
5. `closure || completion handler` 이용
6. `NotificationCenter & Observer` 패턴 이용

위 방법들 중 일부는 단방향 통신이라는 점을 참고하고 진행하도록 한다.

이번 문서에서는 1,2번 방법에 대해 작성한다.

<br>

**뷰 컨트롤러 A에서 뷰 컨트롤러 B로 데이터를 가져오는 가장 쉬운 방법은 프로퍼티(속성)을 이용하는 것이다.**

프로퍼티란 클래스 내에 포함된 변수를 의미한다.

클래스의 모든 인스턴스는 해당 프로퍼티를 갖는다.

또한 프로퍼티에 값을 할당하는것도 가능하다.

`UIViewController` 타입의 `ViewController`는 다른 클래스와 마찬가지로 프로퍼티를 가질 수 있다.

![image](https://user-images.githubusercontent.com/33051018/79631039-23dabc00-8191-11ea-99a3-94a958f9b684.png)


text라는 프로퍼티를 갖는  뷰 컨트롤러가 위와 같이 있다고 가정해보자.

```swift

class MainViewController: UIViewController {
    var text: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

`MainViewController` 의 인스턴스가 생성되면, 우리는 아래 내용처럼  `text` 프로퍼티에 값을 할당할 수 있다.

```swift

let vc = MainViewController()       //인스턴스 생성
vc.text = "We Can Assign a value to the text Property!"

```

여기서 사용된 클래스 `UIViewController` 는  `Navigation Controller`의 일부이며 우리는 일부 데이터를 두 번쨰 뷰 데이터에 전달하려고 한다.

두번쨰 뷰 컨트롤러 코드는 아래와 같다.

```swift

class SecondaryViewController: UIViewController {
    var text:String = ""

    @IBOutlet weak var textLabel:UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        textLabel?.text = text      // 프로퍼티에 접근하여 값 할당
    }
}
```

위 코드 내 `viewDidLoad()` 메소드 내부를 살펴보면 textLabel의 text 프로퍼티에 `SecondaryViewController` 의 text 값을 할당한다.

이제 실제 데이터 전달이다.

`MainViewController` 에 아래 메소드를 추가한다.

```swift

@IBAction func onButtonTap() {

    let vc = SecondaryViewController(nibName: "SecondaryViewController", bundle: nil)

    vc.text = "데이터 전달"

    navigationController?.pushViewController(vc, animated: true)
}
```

이후 메인뷰에서 버튼을 `IBAction`과 연결해주고 해당 버튼을 클릭하면 위 코드가 실행된다.

`vc`는 세컨더리 뷰 컨트롤러의 인스턴스다.

해당 인스턴스의 text 속성에 문자열을 할당한다. -> 이것이 뷰 컨트롤러 간 데이터를 실제로 전달하는 것이다.

마지막으로 `pushViewController` 메소드를 사용하여 새 뷰 컨트롤러를 `navigation stack`에 푸쉬한다.

이게 끝이다.

위 내용을 보다 세분화하여 살펴보도록 한다.

속성을 사용하여 뷰 컨트롤러 간 데이터를 전달하는 방법은 아래와 같다.

1. 데이터를 수신할 뷰 컨트롤러에서 데이터의 속성을 만든다. (ex: text)

2. 송신 뷰 컨트롤러에서 수신 뷰 컨트롤러 인스턴스를 생성한 후 프로퍼티의 값을 할당하여 `Navigation stack`에 푸시한다.


<br>
<br>

### 3. Passing Data Between View Controllers Using Segues
---

만일 스토리보드를 사용하여 인터페이스를 구성하였다면, `segue` 방식을 통해 데이터를 전달할 수 있다.

이번에는 `segue` 방식을 사용하여 데이터를 전달하는 방법에 대해 알아본다.

`Xcode` 에서는 `Interface Builder`를 사용하여 인터페이스를 구성하고 코드없이 뷰 컨트롤러간 전환을 작성할 수 있다.

`segue`란, 부드러운 전환을 의미한다.

에를 들어, 내비게이션 컨트롤러를 사용하여 하나의 뷰 컨트롤러에서 다음 뷰 컨트롤러로 화면을 전환할 때 `segue`를 이용하여 만든다.

![image](https://user-images.githubusercontent.com/33051018/79631397-21c62c80-8194-11ea-98be-e3c96dd4b648.png)

```swift
//secondViewController.swift

class secondViewController: UIViewController {
    var username: String = ""

    @IBOutlet weak var usernameLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLabel.text = username
    }
}
```
이전 예제와 마찬가지로 text 프로퍼티를 이용하여 username 값을 할당하였다.

이후, `MainViewController` 에서 `secondViewController`로 데이터를 전달하려면 `prepare(for: sender:)` 라는 함수를 이용한다.

```swift

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.destinaton is secondViewController {
        let vc = segue.destination as? secondViewController
        vc?.username = "Jungsu YEO"
    }
}
```

먼저, `if`와 `is`를 이용하여 segue 대상이 수신 클래스가 맞는지 확인한다.

이후, `segue.destination` 을 `secondViewController`로 캐스팅 하면 `username` 프로퍼티를 사용할 수 있다.

segue의 destination 프로퍼티에는 `UIViewController` 타입이 있으므로 `username` 프로퍼티로 이동하려면 캐스팅을 진행해야 한다.

이후, 우리가 이전에 했던것 처럼 그냥 `property` 값만 수정해주면 된다.

```swift
if let vc = segue.destination as? secondViewController {
    vc.username = "Jungsu YEO"
}
```


<br>
<br>


### 정리
---

-   **즉, 앱 아키텍처는 뷰 컨트롤러 작업 방식에 영향을 미치며 반대도 마찬가지다.**

-   **뷰 컨트롤러 A에서 뷰 컨트롤러 B로 데이터를 가져오는 가장 쉬운 방법은 프로퍼티(속성)을 이용하는 것이다.**

- **1. 데이터를 수신할 뷰 컨트롤러에서 데이터의 속성을 만든다. (ex: text)**

-   **2. 송신 뷰 컨트롤러에서 수신 뷰 컨트롤러 인스턴스를 생성한 후 프로퍼티의 값을 할당하여 `Navigation stack`에 푸시한다.**

-   **segue를 이용하여 뷰 간 데이터 전달시의 핵심은 `prepare()` 메소드와 타입캐스팅이다**