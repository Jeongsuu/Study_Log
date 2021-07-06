# Coordinator

<br>

오늘은 Coordinator에 대해서 공부해보고자 합니다.

Coordinator란 무엇을 의미하는지, 또 어떤 역할을 하는지 먼저 알아보도록 할꼐요!

<br>

## Coordinator 란?
---

Coordinator 패턴을 소개한 [Soroush Khanlou](https://khanlou.com/2015/10/coordinators-redux/)는 코디네이터를 아래와 같이 설명하고 있습니다.

<br>

>**A Coordinator** is an object that bosses one or more view controllers around.
>
>Taking all of the driving logic out of your view controllers, and moving that stuff on layer up is gonna make your life a lot more awesome.

하나 이상의 뷰 컨트롤러들에게 지시를 내리는 객체이며 여기서 말하는 지시는 view의 트랜지션을 의미합니다.

즉, Coordinator는 앱 전반에 있어 화면 전환 및 계층에 대한 흐름을 제어하는 역할을 합니다.

<br>

## Coordinator를 사용하여 얻을수 있는 이점
---

Coordinator를 이용하여 앱의 흐름을 제어할 수 있으면 어떤 이점을 얻을수 있는지 살펴보겠습니다.

일반적으로 우리는 화면을 전환할때 `segue`를 이용하거나 코드 기반의 UI를 그릴시 View Controller 내부에서 특정 input에 따라 navigationController 혹은 현재 ViewController에 다음으로 보여줄 View Controller를 push 혹은 present 합니다.

위와 같은 패턴으로 사용하게 되면 이러한 화면 전환 관련 코드는 View Cotroller 내부에 작성되어질 것이며 이 책임 또한 온전히 View Controller가 가지게 됩니다. 뿐만 아니라 View Controller간의 의존성도 생기게 되죠!

안그래도 많은 일을 담당하는 View Controller에게 더 많은 일을 시키게 됩니다ㅠㅠ

이러한 상황에서 Coordinator 패턴을 적용하여 화면 전환의 흐름을 제어하게 된다면 View Controller가 담당하던 화면 전환 책임은 Coordinator가 담당하게 됩니다.

또한 Coordinator를 통한 화면 전환시 View Controller에서 사용할 ViewModel을 함께 주입해줄수 있어 DI 또한 쉽게 해결할 수 있습니다!

즉, Coordiantor는 화면 전환 제어 담당과 의존성 주입을 가능하게 해주는 허브라고 생각하면 한 층 이해가 쉬울것 같아요~

<br>


## Coordinator 예제
---

![image](https://user-images.githubusercontent.com/33051018/124553481-c30bd200-de6f-11eb-9950-c7638c9a119a.png)

앞으로 적용해볼 코디네이터 패턴의 흐름은 대략 위 그림과 같습니다.

각각의 View 담당 Coordinator가 다음 화면을 띄울때 Main Coordinator에게 요청을 보내고 이 요청을 받은 Main Coordinator는 응답으로 화면을 전환시켜줄 것 입니다.

<br>
<br>

### Coordinator 추상화
---

```swift
protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
```

각각의 Coordinator는 본인의 자식 코디네이터들을 저장할 [Coordinator] 배열 변수와 네비게이션 스택을 쌓을 UINavigationController 타입의 변수를 하나 갖습니다.

또한, 화면 전환 로직 역할을 수행할 방법인 메서드 `start()` 도 갖게됩니다.

이제 이를 가지고 MainCoordinator를 만들어 보겠습니다!

<br>

### MainCoordinator

```swift
class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewController = MainViewController()
        mainViewController.coordinator = self
        navigationController.pushViewController(mainViewController, animated: true) // transtion
    }
}
```

MainCoordinator는 대략 위와 같은 형태로 작성됩니다.

`init` 생성자의 인자로 navigationController를 넣어주어 초기화를 진행하고 `start` 메서드를 통해 MainVC를 띄우게 되죠!

현재는 간단한 예제 프로젝트기 때문에 별도 ViewModel을 주입받지 않았으나 ViewModel 이 필요할 경우, 위와 같이 ViewController 생성 시점에 필요한 ViewModel을 주입해줍니다.

<br>

### AppDelegate - start MainVC

```swift
// AppDelegate

var window: UIWindow?
var mainCoordinator: MainCoordiantor?

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
```

Appdelegate의 `didFinishLaunchingWithOptions` 메서드입니다.

MainCoordinator 생성을 위해 필요한 NavigaitonController 객체를 생성하고 이를 기반으로 MainCoordinator 객체를 생성합니다.

이후 이전에 작성해두었던 `start()` 메서드를 호출하여 해당 NavigationController에 Main VC를 push합니다.

이를 통해 앱에서 런칭이 끝나면 Main VC가 화면에 보여지게 됩니다!

<br>
<br>

### MainViewController

이번엔 MainVC에서 다른 화면으로의 transition을 만들어보도록 할께요!

MainViewController의 View 내에 간단하게 버튼을 하나 만들고 해당 버튼을 터치하면 SecondViewController를 띄워보도록 하겠습니다.

```swift
class MainViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    weak var pushButton: UIButton!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue

        setupViews()
        setupLayoutConstraints()

        pushButton.rx.tap.asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.coordinator?.pushSecondVC()
            })
            .disposed(disposeBag)
    }

    func setupViews() {
        let pushButton = UIButton()
        pushButton.setTitle("PUSH", for: .normal)
        self.pushButton = pushButton
        view.addSubview(pushButton)
    }

    func setupLayoutConstraints() {
        pushButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
    }
}
```

간단하게 버튼을 만들고 rxCocoa를 활용하여 해당 버튼의 터치 이벤트를 구독하였습니다.

버튼의 터치 이벤트가 방출되게 되면 coordinator delegate reference를 통해 메서드를 호출하여 화면을 전환하는 흐름을 만들어 보고자 합니다!

이를 위해서는 coordinator 클래스에서 해당 메서드를 구현이 필요하니 구현해보도록 할께요!

<br>
<br>

### SecondViewCoordinator

```swift
class SecondViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let secondVC = SecondViewController()
        secondVC.coordinator = self
        navigationController.pushViewController(secondVC, animated: true)
    }
}
```

secondView에 대한 transition 로직을 제어할 Coordinator를 만들어줍니다!

이후 mainVC의 버튼이 터치되면 실행될 `pushSecondVC()` 라는 메서드를 MainCoordinator에 정의해볼께요!

```swift
func pushSecondVC() {
    let secondViewCoordinator = SecondViewCoordinator(navigationController: navigationController)
    secondViewCoordinator.parentCoordinator = self
    childCoordinator.append(secondViewCoordinator)  // 메모리에서 제거되지 않도록 childCoordinator에 추가합니다.
    secondViewCoordinator.start()
}
```

위와 같이 메서드를 정의하면 MainVC의 버튼 터치시 정상적으로 SecondVC로 화면이 전환됩니다!

MainVC로의 이동은 MainCoordinator가, SecondVC로의 이동은 SecondViewCoodinator가 담당하고 있습니다.

MainVC의 버튼 터치 -> MainCoordinator.pushSecondVC() -> SecondViewCoordinator.start() 흐름으로 동작하는 간단한 예제였습니다.

이로써 간단히 Coordinator 패턴 예제를 진행해봤습니다.

다음에는 좀 더 복잡한 UI 계층을 갖는 예제를 진행해보도록 할께요!