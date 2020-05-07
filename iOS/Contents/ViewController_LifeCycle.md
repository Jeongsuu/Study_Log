# 뷰 컨트롤러 생명주기
---

본 문서에는 뷰 컨트롤러 생명주기에 대하여 공부한 내용을 정리하여 기재한다.

<br>

## ViewController LifeCycle
---
<br>

### viewDidLoad()
---

뷰의 생명주기 중 첫번째는 항상 봐왔던 `viewDidLoad()`이다.

모든 `IBOutlet`, `IBAction`, 뷰 관련 모든 객체들이 연결되는 시점이다.

**중요한 점은, 뷰가 만들어지면 딱 한번 실행되는 메서드라는 점이다.**

따라서, 뷰를 사용하기에 앞서 초기화해야 할 내용이 있다면 주로 `viewDidLoad()`에 기재한다.

뷰가 로드된 이후에 운영체제는 `viewWillAppear()` 메서드를 호출한다.

<br>

### viewWillAppear()
---

위 메서드는 뷰가 스크린에 띄워지기 직전에 호출된다.

따라서, UI를 띄우기 직전에 특정 컴포넌트를 숨기거나 보이게하는 등의 작업을 처리하기 적절한 시점이다.

이후 운영체제는 `viewDidAppear()` 메서드를 호출한다.

<br>

### viewDidAppear()
---

위 메서드가 호출된 이후에야 비로소 사용자들이 `View Controller`를 스크린에서 살펴볼 수 있다.

사용자가 뷰 컨트롤러를 마주하는 순간이기 때문에 예시로 타이머와 같은 기능을 초기화하거나 준비한 애니메이션을 실행한다거나 등을 초기화 좋은 시점이다.

이후 운영체제는 `ViewWillDisappear()` 메서드를 호출한다.

<br>

### viewWillDisappear()
---

위 메서드는 뷰가 스크린에서 사라지기 직전에 호출된다.

사용자들이 네비게이션 뷰를 pop 하거나, 현재 뷰 컨트롤러를 `dismiss`하면 해당 액션에 대응하는 일련의 준비를 하기위해 호출되는 함수이다.

이후 운영체제는 `viewDidDisappear()` 메서드를 호출한다.

<br>

### viewDidDisappear()
---

이 시점에서 뷰는 이미 스크린에서 사라진 상황이다.

**뷰가 사라졌다고 해서 메모리에서 삭제되는 것은 아니라는 점은 꼭 기억해야 한다.**

위 메서드가 호출되면 이름 그대로 그저 사용자가 뷰를 볼 수 없다.


<br>

```swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("VC1 viewDidLoad Called")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VC1 viewWillAppear Called")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VC1 viewDidAppear Called")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("VC1 viewWillDisappear Called")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("VC1 viewDidDisappear Called")
    }
}

```

위와 같은 예제 코드가 존재한다고 했을때, 앱이 실행되어 뷰 컨트롤러가 화면에 띄워지면 콘솔창에는 아래와 같은 로그가 남는다.

```
VC1 viewDidLoad Called
VC1 viewWillAppear Called
VC1 viewDidAppear Called
```

뷰가 메모리에 적재되고, 디스플레이 될 준비를 한 이후에 사용자의 화면에 디스플레이된다.

이후 화면이 사라질때는 아래와 같은 로그가 남는다.

```
VC1 viewWillDisappear Called
VC1 viewDidDisappear Called
```

뷰가 화면에서 사라질 준비를 한 뒤, 모든 준비가 완료되면 사라진다.
